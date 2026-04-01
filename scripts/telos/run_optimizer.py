#!/usr/bin/env python3
"""Telos Token Optimizer — End-of-day runner.

Orchestrates:
  1. Harvest real parameters from OpenClaw
  2. (v2) Harvest quality scores from EvalPal
  3. Load and solve the .telos manifest
  4. Write advisory recommendation via OpenClawActuator

Run:
  python scripts/telos/run_optimizer.py                         # v1: cost only
  python scripts/telos/run_optimizer.py --v2                     # v2: cost + quality
  python scripts/telos/run_optimizer.py --v2 --quality-weight 3  # quality bias
  python scripts/telos/run_optimizer.py --date 2026-03-31 --dry-run

Requires: telos-os installed in a venv with highspy (for ARM Macs).
Meant to be called after the last OpenClaw cron run of the day.
"""

from __future__ import annotations

import argparse
import json
import os
import sys
from pathlib import Path

# Add the scripts/telos directory to the Python path
SCRIPT_DIR = Path(__file__).resolve().parent
REPO_DIR = SCRIPT_DIR.parent.parent  # ai-workforce-lab/
sys.path.insert(0, str(SCRIPT_DIR))

from harvest_params import harvest
from openclaw_actuator import OpenClawActuator


def patch_solver():
    """Monkey-patch Telos compiler to use HiGHS instead of CBC on ARM Macs.

    This works around the x86-only CBC binary bundled with PuLP.
    See: https://github.com/MatthewEngman/telos-framework/issues/4
    """
    import platform

    if platform.machine() == "arm64":
        try:
            import pulp
            from pulp import HiGHS

            # Verify HiGHS is available
            if HiGHS(msg=False).available():
                import telos.compiler as compiler

                _original_compile = compiler.TelosCompiler.compile

                @staticmethod
                def _patched_compile(schema, context=None):
                    """Compile with HiGHS solver instead of CBC."""
                    context = dict(context or {})
                    direction = (
                        pulp.LpMinimize
                        if schema.teleology.direction == "minimize"
                        else pulp.LpMaximize
                    )
                    prob = pulp.LpProblem("Telos_Matrix", direction)

                    lp_vars = {}
                    for v in schema.ontology.variables:
                        cat = pulp.LpInteger if v.type == "int" else pulp.LpContinuous
                        lp_vars[v.name] = pulp.LpVariable(
                            v.name, lowBound=v.bounds[0], upBound=v.bounds[1], cat=cat
                        )

                    env = {**lp_vars, **context}

                    from telos.linear_milp import parse_linear_milp_expression

                    obj = parse_linear_milp_expression(
                        schema.teleology.objective.strip(), env
                    )
                    prob += obj

                    for inv in schema.invariants:
                        raw = parse_linear_milp_expression(
                            inv.expression.strip(), env
                        )
                        lhs = compiler._as_pulp_affine(raw)
                        if inv.type == "eq":
                            prob += lhs == 0
                        else:
                            prob += lhs >= 0

                    # Use HiGHS instead of CBC
                    prob.solve(HiGHS(msg=False))
                    if pulp.LpStatus[prob.status] != "Optimal":
                        return None

                    out = {}
                    for name, var in lp_vars.items():
                        val = pulp.value(var)
                        out[name] = 0.0 if val is None else float(val)
                    return out

                compiler.TelosCompiler.compile = _patched_compile
                print("[solver] Patched TelosCompiler to use HiGHS (ARM64 workaround)")
                return True
        except ImportError:
            pass

    return False


def run_optimizer(
    target_date: str | None = None,
    dry_run: bool = False,
    use_v2: bool = False,
    quality_weight: float = 2.0,
) -> dict:
    """Run the full optimization pipeline."""

    # 1. Patch solver for ARM Macs
    patch_solver()

    # 2. Harvest cost parameters
    print("\n=== Phase 1: Harvesting parameters from OpenClaw ===")
    params = harvest(target_date)
    print(f"[harvest] Collected {len(params)} cost parameters")
    for k, v in params.items():
        print(f"  {k}: {v}")

    # 2b. (v2) Harvest quality parameters from EvalPal
    if use_v2:
        print("\n=== Phase 1b: Harvesting quality scores from EvalPal ===")
        from evalpal_quality import parse_local_eval_scores, aggregate_provider_quality

        scores = parse_local_eval_scores()
        quality = aggregate_provider_quality(scores)
        params["quality_anthropic"] = quality.get("quality_anthropic", 0.85)
        params["quality_openai"] = quality.get("quality_openai", 0.85)
        params["quality_google"] = quality.get("quality_google", 0.80)
        params["quality_weight"] = quality_weight
        print(f"[quality] {len(scores)} eval scores → provider quality:")
        for provider in ["anthropic", "openai", "google"]:
            print(f"  quality_{provider}: {params[f'quality_{provider}']:.4f}")
        print(f"  quality_weight: {quality_weight}")

    # Save live params
    live_params_path = REPO_DIR / "scripts" / "telos" / "params" / "openclaw_live.json"
    live_params_path.parent.mkdir(parents=True, exist_ok=True)
    with open(live_params_path, "w") as f:
        json.dump(params, f, indent=2)

    if dry_run:
        print("\n[dry-run] Would run solver with above parameters. Exiting.")
        return params

    # 3. Load and solve the manifest
    version_label = "v2 (cost + quality)" if use_v2 else "v1 (cost only)"
    print(f"\n=== Phase 2: Running MILP solver ({version_label}) ===")
    from telos import TelosParser, TelosRuntime

    manifest_name = (
        "openclaw_token_optimizer_v2.telos" if use_v2
        else "openclaw_token_optimizer.telos"
    )
    manifest_path = REPO_DIR / "EVALS" / "telos" / manifest_name
    schema = TelosParser.load(manifest_path)

    rt = TelosRuntime()
    actuator = OpenClawActuator(
        output_dir=REPO_DIR / "EVALS" / "telos" / "recommendations"
    )
    rt.attach_actuator(actuator)

    print(f"[solver] Manifest: {manifest_path}")
    print(f"[solver] Solving...")

    result = rt.tick({"main": schema}, params)

    if result and result.get("state"):
        state = result["state"]
        print(f"\n=== Phase 3: Results ===")
        print(f"[solver] Status: HEALTHY")
        for k, v in state.items():
            print(f"  {k}: {v:.4f}")
    else:
        print(f"\n[solver] ❌ Solver returned non-optimal status.")
        print(f"[solver] This may indicate infeasible constraints with current parameters.")
        print(f"[solver] Check: are all providers down? Is the budget too low?")

    return result or {}


def main():
    parser = argparse.ArgumentParser(
        description="Run the Telos token optimizer for the OpenClaw fleet"
    )
    parser.add_argument(
        "--date",
        help="Target date (YYYY-MM-DD). Default: today",
        default=None,
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Harvest parameters only, don't run the solver",
    )
    parser.add_argument(
        "--v2",
        action="store_true",
        help="Use v2 manifest with EvalPal quality-weighted routing",
    )
    parser.add_argument(
        "--quality-weight",
        type=float,
        default=2.0,
        help="Quality weight for v2 (0=pure cost, higher=more quality bias). Default: 2.0",
    )
    args = parser.parse_args()

    result = run_optimizer(
        target_date=args.date,
        dry_run=args.dry_run,
        use_v2=args.v2,
        quality_weight=args.quality_weight,
    )

    if not args.dry_run and not result:
        sys.exit(1)


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Harvest real parameters from OpenClaw for the Telos token optimizer.

Reads from:
  1. OpenClaw cron run logs (~/.openclaw/cron/runs/*.jsonl)
  2. OpenClaw gateway error log (~/.openclaw/logs/gateway.err.log)
  3. Model pricing config (scripts/model-pricing.json)

Outputs: scripts/telos/params/openclaw_live.json

NOTE: This reads the same JSONL data that OpenClaw's native dashboard
uses. We parse it here to extract the specific parameters the MILP
manifest needs. If OpenClaw exposes a more accurate API in the future,
this script should be updated to use it.
"""

from __future__ import annotations

import json
import os
import sys
from datetime import datetime, timedelta
from pathlib import Path
from typing import Any, Dict, List


# --- Config ---
RUNS_DIR = Path.home() / ".openclaw" / "cron" / "runs"
ERR_LOG = Path.home() / ".openclaw" / "logs" / "gateway.err.log"
REPO_DIR = Path(__file__).resolve().parent.parent.parent  # ai-workforce-lab/
PRICING_FILE = REPO_DIR / "scripts" / "model-pricing.json"
OUTPUT_FILE = REPO_DIR / "scripts" / "telos" / "params" / "openclaw_live.json"
BUDGET_CAP = 10.0  # daily variable token cap


def load_pricing() -> Dict[str, Dict[str, float]]:
    """Load model pricing from repo config."""
    with open(PRICING_FILE) as f:
        data = json.load(f)
    return data.get("models", {})


def collect_todays_runs(target_date: str | None = None) -> List[Dict[str, Any]]:
    """Collect finished runs with token usage for a given date."""
    if target_date is None:
        target_date = datetime.now().strftime("%Y-%m-%d")

    dt = datetime.strptime(target_date, "%Y-%m-%d")
    day_start_ms = int(dt.timestamp() * 1000)
    day_end_ms = int((dt + timedelta(days=1)).timestamp() * 1000)

    runs = []
    for logfile in RUNS_DIR.glob("*.jsonl"):
        try:
            with open(logfile) as f:
                for line in f:
                    line = line.strip()
                    if not line:
                        continue
                    record = json.loads(line)
                    if (
                        record.get("action") == "finished"
                        and record.get("usage")
                        and day_start_ms <= record.get("ts", 0) < day_end_ms
                    ):
                        runs.append(record)
        except (json.JSONDecodeError, OSError):
            continue

    return runs


def compute_cost_per_run(runs: List[Dict], pricing: Dict) -> Dict[str, float]:
    """Compute average cost per run by provider."""
    provider_costs: Dict[str, List[float]] = {
        "anthropic": [],
        "openai": [],
        "google": [],
    }

    for run in runs:
        provider = run.get("provider", "").lower()
        model = run.get("model", "")
        usage = run.get("usage", {})
        input_tokens = usage.get("input_tokens", 0)
        output_tokens = usage.get("output_tokens", 0)

        # Find pricing for this model
        model_pricing = pricing.get(model, {})
        input_rate = model_pricing.get("input", 1.0)  # per 1M tokens
        output_rate = model_pricing.get("output", 5.0)

        cost = (input_tokens * input_rate + output_tokens * output_rate) / 1_000_000

        for key in provider_costs:
            if key in provider:
                provider_costs[key].append(cost)
                break
        else:
            # Match by model name prefix
            if "claude" in model or "anthropic" in provider:
                provider_costs["anthropic"].append(cost)
            elif "gpt" in model or "openai" in provider or "codex" in provider:
                provider_costs["openai"].append(cost)
            elif "gemini" in model or "google" in provider:
                provider_costs["google"].append(cost)

    result = {}
    for provider, costs in provider_costs.items():
        result[provider] = sum(costs) / len(costs) if costs else 0.10  # fallback
    return result


def check_provider_health() -> Dict[str, float]:
    """Check recent gateway errors to determine provider availability.

    Returns 1.0 = healthy, 0.0 = down.
    """
    health = {"anthropic": 1.0, "openai": 1.0, "google": 1.0}

    if not ERR_LOG.exists():
        return health

    # Read last 2000 lines of error log (file can be very large)
    try:
        with open(ERR_LOG) as f:
            lines = f.readlines()
        recent = lines[-2000:] if len(lines) > 2000 else lines

        for line in recent:
            line_lower = line.lower()

            # Check for Anthropic rate limit (monthly cap)
            if "anthropic" in line_lower and "reached your specified api usage limits" in line_lower:
                health["anthropic"] = 0.0

            # Check for OpenAI Codex OAuth failure
            # Pattern: "openai-codex" + "refresh token" or "refresh_token_reused"
            if "openai-codex" in line_lower and (
                "refresh token" in line_lower
                or "refresh_token_reused" in line_lower
                or "oauth token refresh failed" in line_lower
            ):
                health["openai"] = 0.0

            # Check for Google rate limit (transient — only flag if very recent)
            if "google" in line_lower and "rate limit" in line_lower:
                # Google rate limits are usually transient; mark as degraded not dead
                health["google"] = min(health["google"], 0.5)

    except OSError:
        pass

    return health


def estimate_anthropic_remaining_pct() -> float:
    """Estimate how much of Anthropic's monthly quota remains.

    This is a rough estimate based on:
    - Days elapsed in the billing cycle (assumed monthly reset on 1st)
    - Cumulative usage this month vs expected proportional usage
    """
    now = datetime.now()
    day_of_month = now.day
    days_in_month = 30  # approximate
    days_remaining = days_in_month - day_of_month

    # Simple: percentage of month remaining
    # If we're on day 31 and Anthropic hit its cap, this returns ~0%
    remaining_pct = max(0.0, (days_remaining / days_in_month) * 100)

    # Check if we know Anthropic is already capped
    health = check_provider_health()
    if health["anthropic"] == 0.0:
        remaining_pct = 0.0

    return round(remaining_pct, 1)


def harvest(target_date: str | None = None) -> Dict[str, float]:
    """Main harvest: produce parameters for the Telos optimizer."""
    pricing = load_pricing()
    runs = collect_todays_runs(target_date)
    cost_per_run = compute_cost_per_run(runs, pricing)
    health = check_provider_health()
    anthropic_remaining = estimate_anthropic_remaining_pct()

    params = {
        "cost_per_run_anthropic": round(cost_per_run["anthropic"], 4),
        "cost_per_run_openai": round(cost_per_run["openai"], 4),
        "cost_per_run_google": round(cost_per_run["google"], 4),
        "daily_runs": max(len(runs), 20),  # use actual or minimum expected
        "daily_budget": BUDGET_CAP,
        "anthropic_remaining_pct": anthropic_remaining,
        "openai_available": health["openai"],
        "google_available": health["google"],
    }

    return params


def main() -> None:
    target_date = sys.argv[1] if len(sys.argv) > 1 else None
    params = harvest(target_date)

    OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)
    with open(OUTPUT_FILE, "w") as f:
        json.dump(params, f, indent=2)

    print(f"[harvest_params] Parameters written to {OUTPUT_FILE}")
    print(f"[harvest_params] Summary:")
    for k, v in params.items():
        print(f"  {k}: {v}")


if __name__ == "__main__":
    main()

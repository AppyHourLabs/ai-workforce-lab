"""OpenClaw Token Optimizer Actuator — Advisory mode.

Reads alloc_* variables from the MILP solver output and writes a
markdown recommendation report. Does NOT auto-reconfigure OpenClaw
routing (Phase A: human approval required).

Prefix convention: alloc_* (allocation fractions per provider).
"""

from __future__ import annotations

import json
import os
from datetime import datetime
from pathlib import Path
from typing import Any, Dict

from telos.actuators.base import BaseActuator


class OpenClawActuator(BaseActuator):
    """Advisory actuator for OpenClaw fleet token optimization.

    Phase A: writes markdown recommendation + JSON snapshot.
    Phase B (future): could update openclaw.json model routing.
    """

    def __init__(
        self,
        output_dir: str | Path = "EVALS/telos/recommendations",
        openclaw_config: str | Path | None = None,
    ) -> None:
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(parents=True, exist_ok=True)
        self.openclaw_config = Path(
            openclaw_config or os.path.expanduser("~/.openclaw/openclaw.json")
        )
        self._current_routing: Dict[str, str] = {}
        self._load_current_routing()

    def _load_current_routing(self) -> None:
        """Read current agent → model assignments from openclaw.json."""
        try:
            with open(self.openclaw_config) as f:
                config = json.load(f)
            defaults = config.get("agents", {}).get("defaults", {}).get("model", {})
            self._current_routing = {
                "primary": defaults.get("primary", "unknown"),
                "fallbacks": defaults.get("fallbacks", []),
            }
        except (FileNotFoundError, json.JSONDecodeError):
            self._current_routing = {"primary": "unknown", "fallbacks": []}

    def on_update(self, optimal_state: Dict[str, Any]) -> None:
        """Process solver output and write advisory recommendation."""
        today = datetime.now().strftime("%Y-%m-%d")

        # Extract allocation fractions
        alloc = {
            "anthropic": optimal_state.get("alloc_anthropic", 0.0),
            "openai": optimal_state.get("alloc_openai", 0.0),
            "google": optimal_state.get("alloc_google", 0.0),
        }

        # Determine recommended primary provider (highest allocation)
        recommended_primary = max(alloc, key=alloc.get)

        # Build recommendation
        provider_map = {
            "anthropic": "anthropic/claude-sonnet-4-6",
            "openai": "openai-codex/gpt-5.4",
            "google": "google/gemini-2.5-pro",
        }

        # Determine if recommendation differs from current config
        current_primary_provider = "unknown"
        for provider_key, model_prefix in [
            ("anthropic", "anthropic/"),
            ("openai", "openai"),
            ("google", "google/"),
        ]:
            if self._current_routing.get("primary", "").startswith(model_prefix):
                current_primary_provider = provider_key
                break

        delta = recommended_primary != current_primary_provider
        delta_pct = abs(alloc.get(recommended_primary, 0) - alloc.get(current_primary_provider, 0)) * 100

        # Write markdown recommendation
        report = self._format_report(today, alloc, recommended_primary, provider_map, delta, delta_pct)
        report_path = self.output_dir / f"recommendation-{today}.md"
        with open(report_path, "w") as f:
            f.write(report)

        # Write JSON snapshot for programmatic consumption
        snapshot = {
            "date": today,
            "solver_output": {k: round(v, 4) for k, v in optimal_state.items()},
            "allocations": {k: round(v, 4) for k, v in alloc.items()},
            "recommended_primary": recommended_primary,
            "recommended_model": provider_map[recommended_primary],
            "current_primary": self._current_routing.get("primary", "unknown"),
            "routing_change_recommended": delta,
        }
        snapshot_path = self.output_dir / f"snapshot-{today}.json"
        with open(snapshot_path, "w") as f:
            json.dump(snapshot, f, indent=2)

        # Console output
        print(f"[OpenClawActuator] Recommendation written to {report_path}")
        if delta:
            print(f"[OpenClawActuator] ⚠️  Routing change recommended: {current_primary_provider} → {recommended_primary} (Δ {delta_pct:.0f}%)")
        else:
            print(f"[OpenClawActuator] ✅ Current routing is optimal — no change needed.")

    def _format_report(
        self,
        date: str,
        alloc: Dict[str, float],
        recommended_primary: str,
        provider_map: Dict[str, str],
        delta: bool,
        delta_pct: float,
    ) -> str:
        """Format advisory report as markdown."""
        # Sort providers by allocation (descending)
        sorted_alloc = sorted(alloc.items(), key=lambda x: x[1], reverse=True)

        lines = [
            f"# Token Optimizer Recommendation — {date}",
            "",
            "> Generated by Telos OS MILP solver (advisory mode — Phase A)",
            "",
            "## Optimal Allocation",
            "",
            "| Provider | Allocation | Model | Role |",
            "|----------|-----------|-------|------|",
        ]

        for i, (provider, frac) in enumerate(sorted_alloc):
            role = "Primary" if i == 0 else f"Fallback {i}"
            bar = "█" * int(frac * 20) + "░" * (20 - int(frac * 20))
            lines.append(
                f"| {provider.capitalize()} | {frac:.0%} {bar} | `{provider_map[provider]}` | {role} |"
            )

        lines.extend([
            "",
            "## Current vs Recommended",
            "",
            f"- **Current primary:** `{self._current_routing.get('primary', 'unknown')}`",
            f"- **Recommended primary:** `{provider_map[recommended_primary]}`",
            f"- **Change needed:** {'⚠️ Yes' if delta else '✅ No'}" + (f" (Δ {delta_pct:.0f}%)" if delta else ""),
            "",
        ])

        if delta:
            lines.extend([
                "## Suggested Action",
                "",
                "Update `openclaw.json` agent defaults:",
                "",
                "```json",
                '{',
                f'  "primary": "{provider_map[recommended_primary]}",',
                '  "fallbacks": [',
            ])
            fallbacks = [
                f'    "{provider_map[p]}"'
                for p, _ in sorted_alloc
                if p != recommended_primary and alloc[p] > 0.01
            ]
            lines.append(",\n".join(fallbacks))
            lines.extend([
                '  ]',
                '}',
                "```",
                "",
                "> ⚠️ Phase A: Do NOT apply automatically. Submit for Matt's review.",
                "",
            ])

        lines.extend([
            "---",
            f"*Generated by `telos run openclaw_token_optimizer.telos` at {datetime.now().isoformat()}*",
        ])

        return "\n".join(lines) + "\n"

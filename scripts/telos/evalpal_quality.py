#!/usr/bin/env python3
"""EvalPal Quality Score Harvester for Telos Token Optimizer.

Connects to EvalPal's API to pull per-agent and per-provider quality scores,
then produces quality parameters for the Telos MILP manifesfrom.

This bridges EvalPal's evaluation data into Telos's optimization loop:
  EvalPal → quality scores → Telos parameters → routing recommendations

Usage:
  python scripts/telos/evalpal_quality.py                    # fetch live data
  python scripts/telos/evalpal_quality.py --from-evals-dir   # parse local EVALS/ files
  python scripts/telos/evalpal_quality.py --dry-run           # show what would be computed

Requires:
  pip install evalpal  (or install from local sdk/python)
"""

from __future__ import annotations

import json
import os
import re
import sys
from datetime import datetime, timedelta
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

REPO_DIR = Path(__file__).resolve().parent.parent.parent  # ai-workforce-lab/
EVALS_DIR = REPO_DIR / "EVALS" / "results"
OUTPUT_FILE = REPO_DIR / "scripts" / "telos" / "params" / "quality_scores.json"

# Provider → models mapping (from openclaw.json)
PROVIDER_MODEL_MAP = {
    "anthropic": ["claude-sonnet-4-6", "claude-opus-4-6"],
    "openai": ["gpt-5.4", "gpt-5.1-codex"],
    "google": ["gemini-2.5-pro", "gemini-2.5-flash"],
}

# Agent → provider mapping from openclaw.json
AGENT_PROVIDER_MAP = {
    "moss": "anthropic",
    "doc": "anthropic",
    "qa": "openai",
    "content": "anthropic",
    "security": "anthropic",
    "manager": "anthropic",
    "cfo": "anthropic",
    "cto": "openai",  # uses Opus but falls back to Codex
    "sdr": "anthropic",
    "dev": "openai",
    "product": "anthropic",  # uses Opus
}


def parse_local_eval_scores(days_back: int = 14) -> List[Dict[str, Any]]:
    """Parse quality scores from local EVALS/results/ markdown files.

    Returns list of {agent, provider, score, max_score, date, eval_type} dicts.
    """
    scores: List[Dict[str, Any]] = []
    cutoff = datetime.now() - timedelta(days=days_back)

    for f in sorted(EVALS_DIR.glob("*.md")):
        # Parse date from filename: 2026-03-22-episode-041-quality.md
        match = re.match(r"(\d{4}-\d{2}-\d{2})-(.+)-(?:quality|voice)\.md", f.name)
        if not match:
            continue

        date_str, subject = match.group(1), match.group(2)
        try:
            file_date = datetime.strptime(date_str, "%Y-%m-%d")
        except ValueError:
            continue

        if file_date < cutoff:
            continue

        eval_type = "quality" if "quality" in f.name else "voice"

        # Try to extract scores from the file
        try:
            content = f.read_text()
        except OSError:
            continue

        # Look for "Total score: X / Y" pattern
        score_match = re.search(r"Total score:\s*(\d+)\s*/\s*(\d+)", content)
        if not score_match:
            continue

        score = int(score_match.group(1))
        max_score = int(score_match.group(2))

        # Determine agent from filename context
        agent = "doc"  # default — most evals are for doc agent
        if "briefing" in subject.lower():
            agent = "manager"
        elif "content" in subject.lower():
            agent = "content"
        elif "billing" in subject.lower() or "cost" in subject.lower():
            agent = "cfo"
        elif "security" in subject.lower() or "scan" in subject.lower():
            agent = "security"

        provider = AGENT_PROVIDER_MAP.get(agent, "unknown")

        scores.append({
            "date": date_str,
            "agent": agent,
            "provider": provider,
            "eval_type": eval_type,
            "score": score,
            "max_score": max_score,
            "normalized": round(score / max_score, 4) if max_score > 0 else 0.0,
            "source": f.name,
        })

    return scores


def fetch_evalpal_scores(api_key: Optional[str] = None) -> List[Dict[str, Any]]:
    """Fetch quality scores from EvalPal's API.

    Requires: pip install evalpal, and a valid API key.
    Falls back to local files if not available.
    """
    api_key = api_key or os.environ.get("EVALPAL_API_KEY")

    if not api_key:
        print("[evalpal_quality] No EVALPAL_API_KEY set — falling back to local EVALS/ files")
        return parse_local_eval_scores()

    try:
        from evalpal import EvalPalClient
        client = EvalPalClient(api_key=api_key)

        scores: List[Dict[str, Any]] = []

        # List projects
        projects = client.projects.list()
        for project in projects.items:
            # List eval definitions
            evals = client.evaluations.list(project_id=project.id)
            for eval_def in evals.items:
                # Get recent runs
                runs = client.evaluations.list_runs(eval_def.id)
                for run in (runs.items if hasattr(runs, 'items') else runs):
                    if run.status != "completed":
                        continue

                    # Parse summary metrics
                    try:
                        metrics = json.loads(run.summaryMetrics) if isinstance(run.summaryMetrics, str) else run.summaryMetrics
                    except (json.JSONDecodeError, TypeError):
                        metrics = {}

                    pass_rate = metrics.get("passRate", metrics.get("pass_rate", 0.0))
                    if isinstance(pass_rate, str):
                        pass_rate = float(pass_rate.strip('%')) / 100

                    # Determine provider from the agent's model or run metadata
                    provider = "unknown"
                    model = run.model or ""
                    for p, models in PROVIDER_MODEL_MAP.items():
                        if any(m in model for m in models):
                            provider = p
                            break

                    scores.append({
                        "date": run.startedAt[:10] if run.startedAt else "unknown",
                        "agent": eval_def.name,
                        "provider": provider or (run.provider or "unknown"),
                        "eval_type": "evalpal",
                        "score": pass_rate,
                        "max_score": 1.0,
                        "normalized": pass_rate,
                        "source": f"evalpal:run:{run.id}",
                        "tokens": run.totalTokens,
                        "cost": run.totalEstimatedCost,
                    })

        return scores

    except ImportError:
        print("[evalpal_quality] evalpal SDK not installed — falling back to local EVALS/ files")
        return parse_local_eval_scores()
    except Exception as e:
        print(f"[evalpal_quality] EvalPal API error: {e} — falling back to local EVALS/ files")
        return parse_local_eval_scores()


def aggregate_provider_quality(scores: List[Dict[str, Any]]) -> Dict[str, float]:
    """Aggregate per-eval scores into per-provider quality scores (0.0 - 1.0)."""
    provider_scores: Dict[str, List[float]] = {
        "anthropic": [],
        "openai": [],
        "google": [],
    }

    for s in scores:
        provider = s.get("provider", "unknown")
        if provider in provider_scores:
            provider_scores[provider].append(s["normalized"])

    result = {}
    for provider, vals in provider_scores.items():
        if vals:
            result[f"quality_{provider}"] = round(sum(vals) / len(vals), 4)
        else:
            result[f"quality_{provider}"] = 0.85  # default assumption
    
    return result


def generate_telos_quality_params(
    scores: List[Dict[str, Any]]
) -> Dict[str, float]:
    """Generate Telos-compatible quality parameters from eval data."""
    provider_quality = aggregate_provider_quality(scores)

    params = {
        "quality_floor_anthropic": provider_quality.get("quality_anthropic", 0.85),
        "quality_floor_openai": provider_quality.get("quality_openai", 0.85),
        "quality_floor_google": provider_quality.get("quality_google", 0.80),
        "quality_data_points": len(scores),
        "quality_last_updated": datetime.now().isoformat(),
    }

    return params


def main():
    import argparse

    parser = argparse.ArgumentParser(
        description="Harvest quality scores from EvalPal for Telos optimizer"
    )
    parser.add_argument(
        "--from-evals-dir",
        action="store_true",
        help="Use local EVALS/ files instead of EvalPal API",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Print scores but don't write files",
    )
    parser.add_argument(
        "--api-key",
        help="EvalPal API key (or set EVALPAL_API_KEY env var)",
    )
    args = parser.parse_args()

    # Fetch scores
    if args.from_evals_dir:
        print("[evalpal_quality] Reading from local EVALS/results/ files")
        scores = parse_local_eval_scores()
    else:
        scores = fetch_evalpal_scores(api_key=args.api_key)

    if not scores:
        print("[evalpal_quality] No scores found. Using defaults.")
        scores = []

    # Show scores
    print(f"\n[evalpal_quality] {len(scores)} eval scores collected:")
    for s in scores[-10:]:  # show last 10
        status = "✅" if s["normalized"] >= 0.875 else "⚠️"
        print(f"  {status} {s['date']} | {s['agent']:10} | {s['provider']:10} | {s['eval_type']:8} | {s['normalized']:.0%} ({s['score']}/{s['max_score']})")

    # Aggregate
    params = generate_telos_quality_params(scores)
    print(f"\n[evalpal_quality] Provider quality scores:")
    for k, v in params.items():
        if isinstance(v, float):
            print(f"  {k}: {v:.4f}")
        else:
            print(f"  {k}: {v}")

    if not args.dry_run:
        OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)
        # Filter to serializable values for JSON
        json_params = {k: v for k, v in params.items() if isinstance(v, (int, float, str))}
        with open(OUTPUT_FILE, "w") as f:
            json.dump(json_params, f, indent=2)
        print(f"\n[evalpal_quality] Written to {OUTPUT_FILE}")


if __name__ == "__main__":
    main()

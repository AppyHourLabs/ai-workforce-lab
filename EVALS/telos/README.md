# Telos OS Token Optimizer — Experiment

> **Status:** Active experiment  
> **Framework:** [Telos OS v1.3.0](https://github.com/MatthewEngman/telos-framework)  
> **Manifest:** [`openclaw_token_optimizer.telos`](./openclaw_token_optimizer.telos)

## What This Does

Uses **Mixed-Integer Linear Programming (MILP)** to find the optimal allocation of agent traffic across the fleet's three LLM providers (Anthropic, OpenAI, Google), minimizing cost while respecting:

- Daily variable token budget cap ($10/day)
- Provider availability (auth failures, rate limits)
- Monthly quota remaining (Anthropic monthly cap)

## How to Run

```bash
# Activate the Telos venv
source ~/telos-framework/.venv/bin/activate

# Run the full pipeline (harvest + solve + recommend)
PYTHONPATH="$HOME/telos-framework/telos-framework:$PYTHONPATH" \
  python scripts/telos/run_optimizer.py

# Dry run (harvest only, no solve)
PYTHONPATH="$HOME/telos-framework/telos-framework:$PYTHONPATH" \
  python scripts/telos/run_optimizer.py --dry-run

# Run for a specific date
PYTHONPATH="$HOME/telos-framework/telos-framework:$PYTHONPATH" \
  python scripts/telos/run_optimizer.py --date 2026-03-31
```

## Output

- **Recommendation report:** `EVALS/telos/recommendations/recommendation-YYYY-MM-DD.md`
- **JSON snapshot:** `EVALS/telos/recommendations/snapshot-YYYY-MM-DD.json`
- **Live parameters:** `scripts/telos/params/openclaw_live.json`

## Architecture

```
harvest_params.py          run_optimizer.py          openclaw_actuator.py
┌──────────────┐          ┌────────────────┐        ┌──────────────────┐
│ OpenClaw     │─params──>│ Telos MILP     │─state─>│ Advisory Report  │
│ cron logs    │          │ Solver (HiGHS) │        │ (markdown + json)│
│ gateway.err  │          │                │        │                  │
│ model-pricing│          └────────────────┘        └──────────────────┘
└──────────────┘                │
                    openclaw_token_optimizer.telos
```

## Parameters (harvested from OpenClaw)

| Parameter | Source | Description |
|-----------|--------|-------------|
| `cost_per_run_*` | Cron run logs + pricing config | Avg cost per provider run |
| `daily_runs` | Cron run count | Total runs today |
| `daily_budget` | Config ($10) | Variable token cap |
| `anthropic_remaining_pct` | Calendar + health check | Est. monthly quota remaining |
| `openai_available` | Gateway error log | 0.0 if OAuth broken |
| `google_available` | Gateway error log | 0.5 if rate-limited |

## Known Issues

- **ARM64 Mac:** PuLP's bundled CBC solver is x86-only. We use HiGHS as a workaround (auto-patched). See [telos-framework#4](https://github.com/MatthewEngman/telos-framework/issues/4).
- **Token data accuracy:** Currently reads the same JSONL logs as custom scripts. Once OpenClaw's native dashboard API is confirmed, the harvester should switch to that source.

## Phase A Safety

This experiment runs in **advisory mode only**:
- Solver writes recommendations to markdown
- No automatic changes to `openclaw.json`
- Matt reviews before any routing change

## Files

| File | Purpose |
|------|---------|
| `EVALS/telos/openclaw_token_optimizer.telos` | MILP manifest |
| `scripts/telos/run_optimizer.py` | Orchestration runner |
| `scripts/telos/harvest_params.py` | Parameter harvester |
| `scripts/telos/openclaw_actuator.py` | Advisory actuator |
| `scripts/telos/params/openclaw_defaults.json` | Fallback parameters |

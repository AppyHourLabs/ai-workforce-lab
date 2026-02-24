# CFO Bootstrap: LLM Spend Data

> **Status:** ready
> **Owner:** CFO Agent + Founder
> **Created:** 2026-02-23

## Purpose

The CFO agent needs initial LLM/API spend data to begin budget modeling. This document defines what to provide and in what format.

## Required Data (Founder Provides)

### 1. Provider Dashboard Exports

Export daily spend from each provider for the last 7 days:

| Provider | Dashboard URL | Agents Using |
|---|---|---|
| **OpenAI** | https://platform.openai.com/usage | Product, CTO, CFO, Dev |
| **Anthropic** | https://console.anthropic.com/settings/billing | Doc, Content, SDR |
| **Google** | https://aistudio.google.com/ or Cloud Console | QA, Security, Manager |

### 2. Data Format

Save each export as a file in this directory:

```
TASKS/finance/
├── spend-bootstrap.md          ← this file
├── openai-spend-YYYY-MM-DD.csv ← daily OpenAI usage export
├── anthropic-spend-YYYY-MM-DD.csv
└── google-spend-YYYY-MM-DD.csv
```

If CSV export isn't available, a screenshot or text dump of the usage page is acceptable. The CFO agent can parse either format.

### 3. What the CFO Agent Will Do With This Data

1. Establish a daily spend baseline per provider
2. Calculate per-agent estimated cost (total / agents per provider)
3. Recommend a Phase A hard cap (proposed: $10/day — see [TASKS/0032-budget-cap.md](../0032-budget-cap.md))
4. Set up trend tracking for weekly cost reports

## Quick Start (For Founder)

The fastest path to unblock the CFO agent:

1. Visit each provider dashboard above
2. Export or screenshot the last 7 days of usage
3. Save to `TASKS/finance/` with the naming convention above
4. The CFO agent will pick this up on the next cron run (04:45 ET)

## Suggested Initial Cap

Based on a 10-agent fleet with staggered daily runs, typical Phase A daily spend is **$2–$8/day**. Recommended hard cap: **$10/day** with an 80% alert at $8/day.

> The CFO agent should confirm this recommendation after analyzing the actual spend data.

## Links

- [TASKS/0032-budget-cap.md](../0032-budget-cap.md)
- [POLICIES/phase-a-to-b.md](../POLICIES/phase-a-to-b.md)
- [RUNBOOKS/phase-a-execution-plan.md](../RUNBOOKS/phase-a-execution-plan.md)

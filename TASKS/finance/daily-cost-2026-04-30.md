# Daily Cost Report — 2026-04-30

## Fixed Costs (Subscriptions)

| Provider | Plan | Monthly | Daily (amortized) |
|----------|------|---------|-------------------|
| OpenAI | Pro $200/mo | $6.66 |
| Anthropic | Max (5x) $200/mo | $6.66 |
| Google | AI Pro $200/mo | $6.66 |

**Monthly fixed cost: $600.00 | Daily amortized: $20.00**

> Token usage below is included in subscription plans. Per-token estimates use list rates for tracking **relative usage** and detecting waste — not actual billing.

## Token Usage Summary

| Provider | Model | Runs | Input Tokens | Output Tokens | List Rate Est. |
|----------|-------|------|-------------|---------------|----------------|
| openai-codex | gpt-5.4 | 7 | 128586 | 8723 | $0.4523 |

**Token usage at list rates: $0.45 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai-codex | gpt-5.4 | 22043 | 793 | $0.067 | 46.2s | ok |
| content | openai-codex | gpt-5.4 | 1654 | 388 | $0.01 | 33s | ok |
| cto | openai-codex | gpt-5.4 | 46387 | 2004 | $0.146 | 75.5s | ok |
| dev | openai-codex | gpt-5.4 | 14474 | 1246 | $0.0549 | 67.7s | ok |
| product | openai-codex | gpt-5.4 | 16282 | 1620 | $0.065 | 82s | ok |
| qa | openai-codex | gpt-5.4 | 9674 | 614 | $0.0334 | 41.4s | ok |
| security | openai-codex | gpt-5.4 | 18072 | 2058 | $0.0761 | 91.1s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

# Daily Cost Report — 2026-03-11

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
| anthropic | claude-opus-4-6 | 2 | 19 | 4656 | $0.1165 |
| google | gemini-2.5-flash | 1 | 94856 | 2076 | $0.0155 |
| google | gemini-3.1-pro-preview | 4 | 547103 | 10591 | $0 |

**Token usage at list rates: $0.13 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | google | gemini-2.5-flash | 94856 | 2076 | $0.0155 | 17.8s | ok |
| content | google | gemini-3.1-pro-preview | 232965 | 3023 | $0 | 53.7s | ok |
| cto | anthropic | claude-opus-4-6 | 11 | 3355 | $0.0839 | 79.1s | ok |
| dev | anthropic | claude-opus-4-6 | 8 | 1301 | $0.0326 | 104.9s | ok |
| product | google | gemini-3.1-pro-preview | 52493 | 1524 | $0 | 25.9s | ok |
| qa | google | gemini-3.1-pro-preview | 69760 | 1232 | $0 | 20.1s | ok |
| security | google | gemini-3.1-pro-preview | 191885 | 4812 | $0 | 70.4s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-03-04)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

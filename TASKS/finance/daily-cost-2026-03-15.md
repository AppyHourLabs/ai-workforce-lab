# Daily Cost Report — 2026-03-15

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
| anthropic | claude-opus-4-6 | 2 | 13 | 3176 | $0.0795 |
| google | gemini-2.5-flash | 4 | 1472931 | 17159 | $0.2312 |
| google | gemini-3.1-pro-preview | 1 | 283238 | 2261 | $0 |

**Token usage at list rates: $0.31 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | google | gemini-2.5-flash | 138096 | 1702 | $0.0217 | 19s | ok |
| content | google | gemini-2.5-flash | 942584 | 11493 | $0.1483 | 93.3s | ok |
| cto | anthropic | claude-opus-4-6 | 6 | 1829 | $0.0458 | 41.3s | ok |
| dev | google | gemini-2.5-flash | 225607 | 1284 | $0.0346 | 73.3s | ok |
| product | anthropic | claude-opus-4-6 | 7 | 1347 | $0.0337 | 33s | ok |
| qa | google | gemini-3.1-pro-preview | 283238 | 2261 | $0 | 54.7s | ok |
| security | google | gemini-2.5-flash | 166644 | 2680 | $0.0266 | 22.9s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-03-04)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

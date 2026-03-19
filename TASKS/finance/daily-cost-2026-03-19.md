# Daily Cost Report — 2026-03-19

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
| anthropic | claude-opus-4-6 | 2 | 14 | 4079 | $0.102 |
| google | gemini-2.5-flash | 3 | 517660 | 4777 | $0.0805 |
| google | gemini-3.1-pro-preview | 1 | 215244 | 5061 | $0 |

**Token usage at list rates: $0.18 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | google | gemini-2.5-flash | 93331 | 1410 | $0.0148 | 14.4s | ok |
| content | google | gemini-2.5-flash | 125521 | 2001 | $0.02 | 20.2s | ok |
| cto | anthropic | claude-opus-4-6 | 7 | 2436 | $0.0609 | 58.7s | ok |
| dev | google | gemini-2.5-flash | 298808 | 1366 | $0.0456 | 79.6s | ok |
| product | anthropic | claude-opus-4-6 | 7 | 1643 | $0.0411 | 41.7s | ok |
| qa | google | gemini-3.1-pro-preview | 215244 | 5061 | $0 | 79.1s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-03-04)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 6
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

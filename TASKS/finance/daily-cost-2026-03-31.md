# Daily Cost Report — 2026-03-31

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
| google | gemini-2.5-pro | 7 | 1634211 | 12954 | $2.1075 |

**Token usage at list rates: $2.11 / $10.00 cap (20.0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | google | gemini-2.5-pro | 102786 | 1452 | $0.1357 | 30.9s | ok |
| content | google | gemini-2.5-pro | 141978 | 1414 | $0.1845 | 28.1s | ok |
| cto | google | gemini-2.5-pro | 619351 | 3026 | $0.7893 | 73.9s | ok |
| dev | google | gemini-2.5-pro | 315566 | 1240 | $0.4007 | 91s | ok |
| product | google | gemini-2.5-pro | 123810 | 1233 | $0.1609 | 28.4s | ok |
| qa | google | gemini-2.5-pro | 61490 | 1055 | $0.0821 | 16.3s | ok |
| security | google | gemini-2.5-pro | 269230 | 3534 | $0.3542 | 48.4s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-03-04)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

# Daily Cost Report — 2026-03-26

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
| google | gemini-2.5-pro | 7 | 1045259 | 10818 | $1.3607 |

**Token usage at list rates: $1.36 / $10.00 cap (10.0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | google | gemini-2.5-pro | 131145 | 1625 | $0.1721 | 53s | ok |
| content | google | gemini-2.5-pro | 139094 | 1535 | $0.1815 | 42.1s | ok |
| cto | google | gemini-2.5-pro | 323424 | 2686 | $0.4177 | 100s | ok |
| dev | google | gemini-2.5-pro | 260024 | 1152 | $0.3308 | 93.5s | ok |
| product | google | gemini-2.5-pro | 109185 | 2459 | $0.1488 | 53.2s | ok |
| qa | google | gemini-2.5-pro | 62277 | 962 | $0.0827 | 26.3s | ok |
| security | google | gemini-2.5-pro | 20110 | 399 | $0.0271 | 15.3s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-03-04)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

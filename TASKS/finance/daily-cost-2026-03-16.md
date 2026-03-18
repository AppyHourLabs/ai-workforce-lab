# Daily Cost Report — 2026-03-16

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
| anthropic | claude-opus-4-6 | 2 | 14 | 3854 | $0.0964 |
| google | gemini-2.5-flash | 4 | 3043541 | 34292 | $0.4771 |
| google | gemini-3.1-pro-preview | 1 | 255803 | 2745 | $0 |

**Token usage at list rates: $0.57 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | google | gemini-2.5-flash | 94680 | 1389 | $0.015 | 15.1s | ok |
| content | google | gemini-2.5-flash | 760258 | 17090 | $0.1243 | 117.6s | ok |
| cto | anthropic | claude-opus-4-6 | 7 | 2344 | $0.0586 | 48.1s | ok |
| dev | google | gemini-2.5-flash | 1571327 | 9827 | $0.2416 | 226.9s | error |
| product | anthropic | claude-opus-4-6 | 7 | 1510 | $0.0378 | 35.9s | ok |
| qa | google | gemini-3.1-pro-preview | 255803 | 2745 | $0 | 70.3s | ok |
| security | google | gemini-2.5-flash | 617276 | 5986 | $0.0962 | 66s | error |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-03-04)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

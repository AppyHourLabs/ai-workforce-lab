# Daily Cost Report — 2026-03-12

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
| anthropic | claude-opus-4-6 | 2 | 25 | 5945 | $0.1488 |
| google | gemini-2.5-flash | 1 | 137002 | 1788 | $0.0216 |
| google | gemini-3.1-pro-preview | 4 | 285467 | 6847 | $0 |

**Token usage at list rates: $0.17 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | google | gemini-2.5-flash | 137002 | 1788 | $0.0216 | 19.5s | ok |
| content | google | gemini-3.1-pro-preview | 74539 | 1400 | $0 | 23.4s | ok |
| cto | anthropic | claude-opus-4-6 | 18 | 4920 | $0.1231 | 119.6s | ok |
| dev | anthropic | claude-opus-4-6 | 7 | 1025 | $0.0257 | 74.8s | ok |
| product | google | gemini-3.1-pro-preview | 104715 | 1744 | $0 | 37.8s | error |
| qa | google | gemini-3.1-pro-preview | 52485 | 1525 | $0 | 25.8s | ok |
| security | google | gemini-3.1-pro-preview | 53728 | 2178 | $0 | 25.9s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-03-04)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

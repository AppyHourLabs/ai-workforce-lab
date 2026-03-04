# Daily Cost Report — 2026-03-04

## Fixed Costs (Subscriptions)

| Provider | Plan | Monthly | Daily (amortized) |
|----------|------|---------|-------------------|
| OpenAI | Plus $20.00/mo | $.66 |
| Anthropic | Pro $17.00/mo | $.56 |
| Google | AI Ultra $250.00/mo | $8.33 |

**Monthly fixed cost: $287.00 | Daily amortized: $9.56**

> Token usage below is included in subscription plans. Per-token estimates use list rates for tracking **relative usage** and detecting waste — not actual billing.

## Token Usage Summary

| Provider | Model | Runs | Input Tokens | Output Tokens | List Rate Est. |
|----------|-------|------|-------------|---------------|----------------|
| anthropic | claude-opus-4-6 | 1 | 6 | 1957 | $0.049 |
| google | gemini-3.1-pro-preview | 1 | 55491 | 2179 | $0 |

**Token usage at list rates: $0.05**
**Actual cost: $9.56/day (subscription) | Token budget cap: $10.00/day**

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cto | anthropic | claude-opus-4-6 | 6 | 1957 | $0.049 | 41.1s | ok |
| product | google | gemini-3.1-pro-preview | 55491 | 2179 | $0 | 53.2s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-02-25)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 2
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

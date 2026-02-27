# Daily Cost Report — 2026-02-27

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
| anthropic | claude-opus-4-6 | 2 | 17 | 3193 | $0.0799 |

**Token usage at list rates: $0.08**
**Actual cost: $9.56/day (subscription) | Token budget cap: $10.00/day**

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cto | anthropic | claude-opus-4-6 | 12 | 2315 | $0.0579 | 64.6s | ok |
| product | anthropic | claude-opus-4-6 | 5 | 878 | $0.022 | 34s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-02-25)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 2
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

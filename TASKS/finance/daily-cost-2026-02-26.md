# Daily Cost Report — 2026-02-26

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
| anthropic | claude-opus-4-6 | 2 | 13 | 2279 | $0.057 |

**Token usage at list rates: $0.06**
**Actual cost: $9.56/day (subscription) | Token budget cap: $10.00/day**

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cto | anthropic | claude-opus-4-6 | 8 | 1408 | $0.0352 | 116.2s | ok |
| product | anthropic | claude-opus-4-6 | 5 | 871 | $0.0218 | 32.6s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-02-25)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 2
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

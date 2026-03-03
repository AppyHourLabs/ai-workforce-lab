# Daily Cost Report — 2026-03-03

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
| anthropic | claude-opus-4-6 | 3 | 17 | 3248 | $0.0813 |
| google | gemini-2.5-flash | 1 | 132962 | 1311 | $0.0207 |
| google | gemini-3.1-pro-preview | 2 | 31421 | 819 | $0 |

**Token usage at list rates: $0.10**
**Actual cost: $9.56/day (subscription) | Token budget cap: $10.00/day**

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | google | gemini-2.5-flash | 132962 | 1311 | $0.0207 | 16.1s | ok |
| cto | anthropic | claude-opus-4-6 | 3 | 549 | $0.0137 | 21.6s | ok |
| dev | anthropic | claude-opus-4-6 | 9 | 1584 | $0.0396 | 1015.7s | ok |
| product | anthropic | claude-opus-4-6 | 5 | 1115 | $0.0279 | 59.2s | ok |
| qa | google | gemini-3.1-pro-preview | 15633 | 447 | $0 | 531.7s | ok |
| security | google | gemini-3.1-pro-preview | 15788 | 372 | $0 | 333.8s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-02-25)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 6
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

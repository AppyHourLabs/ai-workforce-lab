# Daily Cost Report — 2026-04-27

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
| anthropic | claude-opus-4-6 | 2 | 12 | 2253 | $0.0564 |
| anthropic | claude-sonnet-4-6 | 3 | 16 | 4077 | $0.0612 |

**Token usage at list rates: $0.12 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| content | anthropic | claude-sonnet-4-6 | 7 | 2971 | $0.0446 | 56s | ok |
| cto | anthropic | claude-opus-4-6 | 5 | 1044 | $0.0261 | 26.1s | ok |
| manager | anthropic | claude-sonnet-4-6 | 5 | 654 | $0.0098 | 15.9s | ok |
| product | anthropic | claude-opus-4-6 | 7 | 1209 | $0.0303 | 32.7s | ok |
| unknown | anthropic | claude-sonnet-4-6 | 4 | 452 | $0.0068 | 14.6s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 5
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

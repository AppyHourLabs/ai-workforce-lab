# Daily Cost Report — 2026-04-14

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
| anthropic | claude-opus-4-6 | 1 | 6 | 1284 | $0.0321 |
| anthropic | claude-sonnet-4-6 | 3 | 77 | 20134 | $0.3022 |
| google | gemini-2.5-pro | 3 | 151618 | 4850 | $0.2138 |

**Token usage at list rates: $0.55 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | google | gemini-2.5-pro | 31945 | 1396 | $0.0469 | 116.2s | ok |
| content | google | gemini-2.5-pro | 61530 | 1032 | $0.0821 | 184.3s | ok |
| cto | anthropic | claude-opus-4-6 | 6 | 1284 | $0.0321 | 47.8s | ok |
| dev | anthropic | claude-sonnet-4-6 | 61 | 16302 | $0.2447 | 315.8s | ok |
| product | google | gemini-2.5-pro | 58143 | 2422 | $0.0848 | 172.9s | ok |
| qa | anthropic | claude-sonnet-4-6 | 6 | 817 | $0.0123 | 43.7s | ok |
| security | anthropic | claude-sonnet-4-6 | 10 | 3015 | $0.0453 | 61.5s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

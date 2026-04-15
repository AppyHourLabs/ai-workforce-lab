# Daily Cost Report — 2026-04-15

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
| anthropic | claude-opus-4-6 | 1 | 6 | 1266 | $0.0317 |
| anthropic | claude-sonnet-4-6 | 3 | 26 | 5765 | $0.0866 |
| google | gemini-2.5-pro | 3 | 150979 | 4763 | $0.2125 |

**Token usage at list rates: $0.33 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | google | gemini-2.5-pro | 40479 | 1336 | $0.0573 | 126.6s | ok |
| content | google | gemini-2.5-pro | 70851 | 1457 | $0.0958 | 135.1s | ok |
| cto | anthropic | claude-opus-4-6 | 6 | 1266 | $0.0317 | 61.7s | ok |
| dev | anthropic | claude-sonnet-4-6 | 9 | 1511 | $0.0227 | 73.4s | ok |
| product | google | gemini-2.5-pro | 39649 | 1970 | $0.0594 | 132.9s | ok |
| qa | anthropic | claude-sonnet-4-6 | 6 | 836 | $0.0126 | 45.4s | ok |
| security | anthropic | claude-sonnet-4-6 | 11 | 3418 | $0.0513 | 78.1s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

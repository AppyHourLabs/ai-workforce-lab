# Daily Cost Report — 2026-03-14

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
| anthropic | claude-opus-4-6 | 2 | 15 | 3634 | $0.0909 |
| google | gemini-2.5-flash | 4 | 774762 | 7054 | $0.1204 |
| google | gemini-3.1-pro-preview | 1 | 105151 | 2935 | $0 |

**Token usage at list rates: $0.21 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | google | gemini-2.5-flash | 137991 | 1775 | $0.0218 | 18.4s | ok |
| content | google | gemini-2.5-flash | 209628 | 2307 | $0.0328 | 24.3s | ok |
| cto | anthropic | claude-opus-4-6 | 7 | 2112 | $0.0528 | 48.6s | ok |
| dev | google | gemini-2.5-flash | 222763 | 1189 | $0.0341 | 74s | ok |
| product | anthropic | claude-opus-4-6 | 8 | 1522 | $0.0381 | 35.6s | ok |
| qa | google | gemini-3.1-pro-preview | 105151 | 2935 | $0 | 41s | ok |
| security | google | gemini-2.5-flash | 204380 | 1783 | $0.0317 | 23s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-03-04)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

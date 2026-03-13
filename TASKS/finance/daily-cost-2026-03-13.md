# Daily Cost Report — 2026-03-13

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
| anthropic | claude-opus-4-6 | 1 | 7 | 2270 | $0.0568 |
| google | gemini-2.5-flash | 6 | 897554 | 8300 | $0.1396 |

**Token usage at list rates: $0.20 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | google | gemini-2.5-flash | 140609 | 1973 | $0.0223 | 21.2s | ok |
| content | google | gemini-2.5-flash | 165692 | 1540 | $0.0258 | 19.3s | ok |
| cto | anthropic | claude-opus-4-6 | 7 | 2270 | $0.0568 | 54.6s | ok |
| dev | google | gemini-2.5-flash | 228107 | 1703 | $0.0352 | 77.2s | ok |
| product | google | gemini-2.5-flash | 92305 | 725 | $0.0143 | 13.1s | ok |
| qa | google | gemini-2.5-flash | 117252 | 1260 | $0.0183 | 15.2s | ok |
| security | google | gemini-2.5-flash | 153589 | 1099 | $0.0237 | 17.1s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-03-04)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

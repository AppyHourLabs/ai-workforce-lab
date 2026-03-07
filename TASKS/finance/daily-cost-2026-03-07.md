# Daily Cost Report — 2026-03-07

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
| anthropic | claude-opus-4-6 | 1 | 11 | 2020 | $0.0506 |
| google | gemini-2.5-flash | 1 | 155993 | 2717 | $0.025 |
| google | gemini-3.1-pro-preview | 5 | 1023247 | 14385 | $0 |

**Token usage at list rates: $0.08 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | google | gemini-2.5-flash | 155993 | 2717 | $0.025 | 22.6s | ok |
| content | google | gemini-3.1-pro-preview | 210171 | 4246 | $0 | 66s | ok |
| cto | anthropic | claude-opus-4-6 | 11 | 2020 | $0.0506 | 50.9s | ok |
| dev | google | gemini-3.1-pro-preview | 586728 | 3253 | $0 | 123.6s | ok |
| product | google | gemini-3.1-pro-preview | 71642 | 2716 | $0 | 33s | ok |
| qa | google | gemini-3.1-pro-preview | 68224 | 1978 | $0 | 25.9s | ok |
| security | google | gemini-3.1-pro-preview | 86482 | 2192 | $0 | 36.5s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-03-04)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

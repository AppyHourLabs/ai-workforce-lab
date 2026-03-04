# Daily Cost Report — 2026-03-04

## Fixed Costs (Subscriptions)

| Provider | Plan | Monthly | Daily (amortized) |
|----------|------|---------|-------------------|
| OpenAI | null $null/mo | $0 |
| Anthropic | null $null/mo | $0 |
| Google | null $null/mo | $0 |

**Monthly fixed cost: $0.00 | Daily amortized: $0**

> Token usage below is included in subscription plans. Per-token estimates use list rates for tracking **relative usage** and detecting waste — not actual billing.

## Token Usage Summary

| Provider | Model | Runs | Input Tokens | Output Tokens | List Rate Est. |
|----------|-------|------|-------------|---------------|----------------|
| anthropic | claude-opus-4-6 | 2 | 21 | 5145 | $0.1287 |
| google | gemini-2.5-flash | 1 | 278656 | 4709 | $0.0446 |
| google | gemini-3.1-pro-preview | 4 | 527474 | 6903 | $0 |

**Token usage at list rates: $0.17**
**Actual cost: $0/day (subscription) | Token budget cap: $10.00/day**

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | google | gemini-2.5-flash | 278656 | 4709 | $0.0446 | 36.1s | ok |
| content | anthropic | claude-opus-4-6 | 15 | 3188 | $0.0798 | 691.6s | ok |
| cto | anthropic | claude-opus-4-6 | 6 | 1957 | $0.049 | 41.1s | ok |
| dev | google | gemini-3.1-pro-preview | 128023 | 1047 | $0 | 362.9s | ok |
| product | google | gemini-3.1-pro-preview | 55491 | 2179 | $0 | 53.2s | ok |
| qa | google | gemini-3.1-pro-preview | 147396 | 1422 | $0 | 94.3s | ok |
| security | google | gemini-3.1-pro-preview | 196564 | 2255 | $0 | 67.1s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-03-04)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

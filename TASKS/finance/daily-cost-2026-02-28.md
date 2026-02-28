# Daily Cost Report — 2026-02-28

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
| anthropic | claude-opus-4-6 | 6 | 37 | 10642 | $0.2662 |
| google | gemini-3.1-pro-preview | 29 | 9885865 | 137190 | $0 |

**Token usage at list rates: $0.27**
**Actual cost: $9.56/day (subscription) | Token budget cap: $10.00/day**

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | google | gemini-3.1-pro-preview | 151879 | 2073 | $0 | 69.6s | ok |
| cto | anthropic | claude-opus-4-6 | 6 | 1800 | $0.045 | 40.1s | ok |
| cto | anthropic | claude-opus-4-6 | 6 | 1868 | $0.0467 | 40.8s | ok |
| cto | anthropic | claude-opus-4-6 | 6 | 1737 | $0.0435 | 40.3s | ok |
| cto | anthropic | claude-opus-4-6 | 7 | 1869 | $0.0468 | 40.5s | ok |
| cto | anthropic | claude-opus-4-6 | 6 | 1695 | $0.0424 | 42s | ok |
| cto | anthropic | claude-opus-4-6 | 6 | 1673 | $0.0419 | 38.1s | ok |
| dev | google | gemini-3.1-pro-preview | 1020496 | 37583 | $0 | 548.7s | ok |
| dev | google | gemini-3.1-pro-preview | 803291 | 5739 | $0 | 254.8s | ok |
| dev | google | gemini-3.1-pro-preview | 583905 | 4038 | $0 | 247.9s | ok |
| dev | google | gemini-3.1-pro-preview | 581546 | 6299 | $0 | 181.9s | ok |
| dev | google | gemini-3.1-pro-preview | 441220 | 4517 | $0 | 174.7s | ok |
| dev | google | gemini-3.1-pro-preview | 46773 | 385 | $0 | 25.8s | ok |
| doc | google | gemini-3.1-pro-preview | 42202 | 484 | $0 | 32.4s | ok |
| doc | google | gemini-3.1-pro-preview | 442454 | 5705 | $0 | 163s | ok |
| doc | google | gemini-3.1-pro-preview | 534515 | 5827 | $0 | 137.6s | ok |
| doc | google | gemini-3.1-pro-preview | 390991 | 4143 | $0 | 126.7s | error |
| doc | google | gemini-3.1-pro-preview | 222808 | 2772 | $0 | 100.1s | ok |
| manager | google | gemini-3.1-pro-preview | 220166 | 2505 | $0 | 96.2s | ok |
| manager | google | gemini-3.1-pro-preview | 76802 | 1745 | $0 | 48.9s | ok |
| manager | google | gemini-3.1-pro-preview | 180871 | 3608 | $0 | 111.3s | ok |
| manager | google | gemini-3.1-pro-preview | 149297 | 1822 | $0 | 82.2s | ok |
| manager | google | gemini-3.1-pro-preview | 84147 | 2620 | $0 | 61s | ok |
| manager | google | gemini-3.1-pro-preview | 86975 | 1738 | $0 | 75.7s | ok |
| product | google | gemini-3.1-pro-preview | 78615 | 2220 | $0 | 62.7s | ok |
| qa | google | gemini-3.1-pro-preview | 410958 | 5797 | $0 | 161.9s | ok |
| qa | google | gemini-3.1-pro-preview | 180950 | 3462 | $0 | 119.4s | error |
| qa | google | gemini-3.1-pro-preview | 770375 | 7168 | $0 | 197.5s | ok |
| qa | google | gemini-3.1-pro-preview | 233347 | 3564 | $0 | 112.7s | ok |
| qa | google | gemini-3.1-pro-preview | 512017 | 5627 | $0 | 193.1s | error |
| security | google | gemini-3.1-pro-preview | 549141 | 3521 | $0 | 142.6s | error |
| security | google | gemini-3.1-pro-preview | 233142 | 3082 | $0 | 99.8s | ok |
| security | google | gemini-3.1-pro-preview | 304731 | 3588 | $0 | 116.8s | ok |
| security | google | gemini-3.1-pro-preview | 180330 | 2563 | $0 | 74.3s | ok |
| security | google | gemini-3.1-pro-preview | 371921 | 2995 | $0 | 143.2s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-02-25)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 35
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

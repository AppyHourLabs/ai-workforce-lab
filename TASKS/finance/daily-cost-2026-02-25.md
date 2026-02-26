# Daily Cost Report — 2026-02-25

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
| anthropic | claude-sonnet-4-0 | 4 | 639 | 14689 | $0.2223 |
| google | gemini-2.5-flash | 5 | 645732 | 9023 | $0.1023 |
| openai | gpt-5.1-codex | 5 | 455372 | 28956 | $1.428 |

**Token usage at list rates: $1.75**
**Actual cost: $9.56/day (subscription) | Token budget cap: $10.00/day**

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai | gpt-5.1-codex | 58902 | 5093 | $0.1982 | 116.9s | error |
| cfo | openai | gpt-5.1-codex | 41369 | 5061 | $0.154 | 99.8s | error |
| content | anthropic | claude-sonnet-4-0 | 225 | 4339 | $0.0658 | 123.5s | ok |
| content | anthropic | claude-sonnet-4-0 | 120 | 2390 | $0.0362 | 59.6s | ok |
| cto | openai | gpt-5.1-codex | 77213 | 4586 | $0.2389 | 105.3s | ok |
| dev | openai | gpt-5.1-codex | 260807 | 10540 | $0.7574 | 267.8s | error |
| doc | anthropic | claude-sonnet-4-0 | 136 | 1840 | $0.028 | 65.8s | ok |
| manager | google | gemini-2.5-flash | 73448 | 2330 | $0.0124 | 23.6s | ok |
| manager | google | gemini-2.5-flash | 117523 | 1721 | $0.0187 | 32.4s | ok |
| manager | google | gemini-2.5-flash | 54985 | 604 | $0.0086 | 11.6s | ok |
| product | openai | gpt-5.1-codex | 17081 | 3676 | $0.0795 | 77.7s | ok |
| qa | google | gemini-2.5-flash | 157034 | 1353 | $0.0244 | 69.7s | ok |
| sdr | anthropic | claude-sonnet-4-0 | 158 | 6120 | $0.0923 | 159.1s | ok |
| security | google | gemini-2.5-flash | 242742 | 3015 | $0.0382 | 39.5s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-02-25)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 14
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

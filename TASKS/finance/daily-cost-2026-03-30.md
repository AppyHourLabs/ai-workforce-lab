# Daily Cost Report — 2026-03-30

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
| openai-codex | gpt-5.4 | 7 | 190189 | 17094 | $0 |

**Token usage at list rates: $0.00 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai-codex | gpt-5.4 | 21068 | 2289 | $0 | 58s | ok |
| content | openai-codex | gpt-5.4 | 21552 | 1729 | $0 | 45.4s | ok |
| cto | openai-codex | gpt-5.4 | 28449 | 4082 | $0 | 129s | ok |
| dev | openai-codex | gpt-5.4 | 49353 | 2460 | $0 | 111.5s | ok |
| product | openai-codex | gpt-5.4 | 27886 | 2516 | $0 | 74.7s | ok |
| qa | openai-codex | gpt-5.4 | 17252 | 1039 | $0 | 27.7s | ok |
| security | openai-codex | gpt-5.4 | 24629 | 2979 | $0 | 75s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-03-04)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

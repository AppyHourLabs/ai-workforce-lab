# Daily Cost Report — 2026-03-29

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
| openai-codex | gpt-5.4 | 7 | 158480 | 16962 | $0 |

**Token usage at list rates: $0.00 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai-codex | gpt-5.4 | 19614 | 2215 | $0 | 55.9s | ok |
| content | openai-codex | gpt-5.4 | 22930 | 1634 | $0 | 41.6s | ok |
| cto | openai-codex | gpt-5.4 | 27558 | 4303 | $0 | 91.7s | ok |
| dev | openai-codex | gpt-5.4 | 32885 | 1916 | $0 | 104.4s | ok |
| product | openai-codex | gpt-5.4 | 19712 | 2617 | $0 | 61.9s | ok |
| qa | openai-codex | gpt-5.4 | 16137 | 1046 | $0 | 31.8s | ok |
| security | openai-codex | gpt-5.4 | 19644 | 3231 | $0 | 71.3s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-03-04)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

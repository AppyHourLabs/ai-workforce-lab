# Daily Cost Report — 2026-04-05

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
| anthropic | claude-sonnet-4-6 | 3 | 30 | 7060 | $0.106 |
| openai-codex | gpt-5.4 | 4 | 417194 | 17705 | $1.3086 |

**Token usage at list rates: $1.41 / $10.00 cap (10.0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | anthropic | claude-sonnet-4-6 | 10 | 1865 | $0.028 | 37.8s | ok |
| content | anthropic | claude-sonnet-4-6 | 10 | 2050 | $0.0308 | 46.4s | ok |
| cto | openai-codex | gpt-5.4 | 27441 | 3112 | $0.1153 | 71.8s | ok |
| dev | openai-codex | gpt-5.4 | 332473 | 9646 | $0.9759 | 268.5s | ok |
| product | openai-codex | gpt-5.4 | 32156 | 1443 | $0.102 | 33.4s | ok |
| qa | openai-codex | gpt-5.4 | 25124 | 3504 | $0.1154 | 98.7s | ok |
| security | anthropic | claude-sonnet-4-6 | 10 | 3145 | $0.0472 | 60.6s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

# Daily Cost Report — 2026-04-18

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
| anthropic | claude-sonnet-4-6 | 1 | 11 | 4066 | $0.061 |
| openai-codex | gpt-5.4 | 6 | 188042 | 14779 | $0.6918 |

**Token usage at list rates: $0.75 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai-codex | gpt-5.4 | 45535 | 2162 | $0.1463 | 130.1s | ok |
| content | openai-codex | gpt-5.4 | 25292 | 1632 | $0.0877 | 130s | ok |
| cto | openai-codex | gpt-5.4 | 26339 | 3566 | $0.1193 | 94.7s | ok |
| dev | openai-codex | gpt-5.4 | 38986 | 3031 | $0.1429 | 90.4s | ok |
| product | openai-codex | gpt-5.4 | 34022 | 3090 | $0.1314 | 95.9s | ok |
| qa | openai-codex | gpt-5.4 | 17868 | 1298 | $0.0641 | 35.1s | ok |
| security | anthropic | claude-sonnet-4-6 | 11 | 4066 | $0.061 | 84.1s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

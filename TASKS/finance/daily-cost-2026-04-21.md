# Daily Cost Report — 2026-04-21

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
| anthropic | claude-sonnet-4-6 | 1 | 11 | 2700 | $0.0405 |
| openai-codex | gpt-5.4 | 6 | 161607 | 15541 | $0.6371 |

**Token usage at list rates: $0.68 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai-codex | gpt-5.4 | 25384 | 2560 | $0.1019 | 137.2s | ok |
| content | openai-codex | gpt-5.4 | 25531 | 1975 | $0.0935 | 123.7s | ok |
| cto | openai-codex | gpt-5.4 | 32587 | 4003 | $0.1415 | 113.5s | ok |
| dev | openai-codex | gpt-5.4 | 33879 | 2995 | $0.1296 | 109.5s | ok |
| product | openai-codex | gpt-5.4 | 25005 | 2517 | $0.1003 | 74.8s | ok |
| qa | openai-codex | gpt-5.4 | 19221 | 1491 | $0.0704 | 62.9s | ok |
| security | anthropic | claude-sonnet-4-6 | 11 | 2700 | $0.0405 | 61.2s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

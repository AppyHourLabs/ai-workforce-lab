# Daily Cost Report — 2026-03-28

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
| openai-codex | gpt-5.4 | 7 | 143367 | 16037 | $0 |

**Token usage at list rates: $0.00 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai-codex | gpt-5.4 | 21131 | 2576 | $0 | 62.9s | ok |
| content | openai-codex | gpt-5.4 | 16853 | 1379 | $0 | 44.5s | ok |
| cto | openai-codex | gpt-5.4 | 23532 | 3388 | $0 | 79.5s | ok |
| dev | openai-codex | gpt-5.4 | 23801 | 2526 | $0 | 95.3s | ok |
| product | openai-codex | gpt-5.4 | 18924 | 2016 | $0 | 43.3s | ok |
| qa | openai-codex | gpt-5.4 | 13964 | 1030 | $0 | 29.3s | ok |
| security | openai-codex | gpt-5.4 | 25162 | 3122 | $0 | 93.1s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-03-04)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

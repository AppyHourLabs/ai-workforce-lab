# Daily Cost Report — 2026-04-23

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
| anthropic | claude-sonnet-4-6 | 1 | 9 | 3027 | $0.0454 |
| openai-codex | gpt-5.4 | 6 | 178626 | 14701 | $0.6671 |

**Token usage at list rates: $0.71 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai-codex | gpt-5.4 | 52472 | 2831 | $0.1736 | 261.9s | ok |
| content | openai-codex | gpt-5.4 | 30608 | 2504 | $0.1141 | 219.3s | ok |
| cto | openai-codex | gpt-5.4 | 24157 | 3716 | $0.1161 | 236.8s | ok |
| dev | openai-codex | gpt-5.4 | 30706 | 2335 | $0.1118 | 160.6s | ok |
| product | openai-codex | gpt-5.4 | 19579 | 1637 | $0.0735 | 96.5s | ok |
| qa | openai-codex | gpt-5.4 | 21104 | 1678 | $0.0779 | 97.8s | ok |
| security | anthropic | claude-sonnet-4-6 | 9 | 3027 | $0.0454 | 64.4s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

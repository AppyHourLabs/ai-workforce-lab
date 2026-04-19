# Daily Cost Report — 2026-04-19

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
| anthropic | claude-sonnet-4-6 | 1 | 12 | 3685 | $0.0553 |
| openai-codex | gpt-5.4 | 6 | 172037 | 15293 | $0.6595 |

**Token usage at list rates: $0.71 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai-codex | gpt-5.4 | 22489 | 2405 | $0.0923 | 140.3s | ok |
| content | openai-codex | gpt-5.4 | 25866 | 2115 | $0.0964 | 127.7s | ok |
| cto | openai-codex | gpt-5.4 | 30877 | 3781 | $0.1339 | 132.4s | ok |
| dev | openai-codex | gpt-5.4 | 46418 | 2889 | $0.1594 | 108.1s | ok |
| product | openai-codex | gpt-5.4 | 25757 | 2505 | $0.102 | 87.9s | ok |
| qa | openai-codex | gpt-5.4 | 20630 | 1598 | $0.0755 | 48.9s | ok |
| security | anthropic | claude-sonnet-4-6 | 12 | 3685 | $0.0553 | 79.1s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

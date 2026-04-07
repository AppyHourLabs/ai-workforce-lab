# Daily Cost Report — 2026-04-07

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
| anthropic | claude-sonnet-4-6 | 2 | 18 | 4068 | $0.0611 |
| openai-codex | gpt-5.4 | 5 | 612707 | 30472 | $1.9888 |

**Token usage at list rates: $2.05 / $10.00 cap (20.0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | anthropic | claude-sonnet-4-6 | 10 | 1589 | $0.0239 | 40.7s | ok |
| content | openai-codex | gpt-5.4 | 50164 | 6872 | $0.2285 | 184.6s | ok |
| cto | openai-codex | gpt-5.4 | 24899 | 3754 | $0.1186 | 114.6s | ok |
| dev | openai-codex | gpt-5.4 | 487036 | 13211 | $1.4158 | 539.2s | ok |
| product | openai-codex | gpt-5.4 | 22013 | 2048 | $0.0858 | 76.2s | ok |
| qa | openai-codex | gpt-5.4 | 28595 | 4587 | $0.1403 | 122.4s | ok |
| security | anthropic | claude-sonnet-4-6 | 8 | 2479 | $0.0372 | 53s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

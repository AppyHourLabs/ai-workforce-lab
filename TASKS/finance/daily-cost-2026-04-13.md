# Daily Cost Report — 2026-04-13

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
| anthropic | claude-sonnet-4-6 | 1 | 10 | 3151 | $0.0473 |
| openai-codex | gpt-5.4 | 6 | 183817 | 15978 | $0.6992 |

**Token usage at list rates: $0.75 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai-codex | gpt-5.4 | 26432 | 3227 | $0.1145 | 223.6s | ok |
| content | openai-codex | gpt-5.4 | 22576 | 1991 | $0.0863 | 128s | ok |
| cto | openai-codex | gpt-5.4 | 27198 | 3708 | $0.1236 | 111s | ok |
| dev | openai-codex | gpt-5.4 | 34647 | 3175 | $0.1342 | 98.4s | ok |
| product | openai-codex | gpt-5.4 | 50623 | 2380 | $0.1623 | 83.8s | ok |
| qa | openai-codex | gpt-5.4 | 22341 | 1497 | $0.0783 | 45.6s | ok |
| security | anthropic | claude-sonnet-4-6 | 10 | 3151 | $0.0473 | 69.6s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

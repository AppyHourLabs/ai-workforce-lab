# Daily Cost Report — 2026-04-10

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
| anthropic | claude-sonnet-4-6 | 1 | 12 | 3749 | $0.0563 |
| openai-codex | gpt-5.4 | 6 | 488710 | 20495 | $1.5292 |

**Token usage at list rates: $1.59 / $10.00 cap (10.0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai-codex | gpt-5.4 | 44425 | 2924 | $0.1549 | 159.7s | ok |
| content | openai-codex | gpt-5.4 | 22686 | 2426 | $0.0931 | 165.6s | ok |
| cto | openai-codex | gpt-5.4 | 40240 | 4287 | $0.1649 | 113.4s | ok |
| dev | openai-codex | gpt-5.4 | 327843 | 6922 | $0.9234 | 353.9s | ok |
| product | openai-codex | gpt-5.4 | 32916 | 2407 | $0.1184 | 126.9s | ok |
| qa | openai-codex | gpt-5.4 | 20600 | 1529 | $0.0744 | 62.4s | ok |
| security | anthropic | claude-sonnet-4-6 | 12 | 3749 | $0.0563 | 83.1s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

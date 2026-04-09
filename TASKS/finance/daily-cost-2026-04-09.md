# Daily Cost Report — 2026-04-09

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
| anthropic | claude-sonnet-4-6 | 1 | 9 | 3293 | $0.0494 |
| openai-codex | gpt-5.4 | 6 | 566966 | 28844 | $1.8501 |

**Token usage at list rates: $1.90 / $10.00 cap (10.0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai-codex | gpt-5.4 | 104827 | 3211 | $0.3102 | 180.4s | ok |
| content | openai-codex | gpt-5.4 | 101573 | 7426 | $0.3653 | 429s | ok |
| cto | openai-codex | gpt-5.4 | 114503 | 4450 | $0.353 | 167.7s | ok |
| dev | openai-codex | gpt-5.4 | 168461 | 9455 | $0.563 | 368.1s | ok |
| product | openai-codex | gpt-5.4 | 55971 | 2615 | $0.1792 | 119.9s | ok |
| qa | openai-codex | gpt-5.4 | 21631 | 1687 | $0.0794 | 48.2s | ok |
| security | anthropic | claude-sonnet-4-6 | 9 | 3293 | $0.0494 | 74.9s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

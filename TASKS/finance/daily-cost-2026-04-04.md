# Daily Cost Report — 2026-04-04

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
| anthropic | claude-sonnet-4-6 | 3 | 34 | 10260 | $0.154 |
| openai-codex | gpt-5.4 | 4 | 71974 | 5649 | $0.2647 |

**Token usage at list rates: $0.42 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | anthropic | claude-sonnet-4-6 | 11 | 3088 | $0.0464 | 62.1s | ok |
| content | anthropic | claude-sonnet-4-6 | 18 | 5994 | $0.09 | 130.7s | ok |
| cto | openai-codex | gpt-5.4 | 17134 | 1100 | $0.0593 | 27.8s | ok |
| dev | openai-codex | gpt-5.4 | 21265 | 2834 | $0.0957 | 105.3s | ok |
| product | openai-codex | gpt-5.4 | 14714 | 768 | $0.0483 | 26.3s | ok |
| qa | openai-codex | gpt-5.4 | 18861 | 947 | $0.0614 | 32.6s | ok |
| security | anthropic | claude-sonnet-4-6 | 5 | 1178 | $0.0177 | 27.9s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

# Daily Cost Report — 2026-04-12

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
| anthropic | claude-sonnet-4-6 | 1 | 10 | 2608 | $0.0392 |
| openai-codex | gpt-5.4 | 6 | 154231 | 16789 | $0.6374 |

**Token usage at list rates: $0.68 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai-codex | gpt-5.4 | 24118 | 3850 | $0.118 | 208.1s | ok |
| content | openai-codex | gpt-5.4 | 23598 | 2194 | $0.0919 | 125.4s | ok |
| cto | openai-codex | gpt-5.4 | 26260 | 3546 | $0.1188 | 102.8s | ok |
| dev | openai-codex | gpt-5.4 | 41616 | 3300 | $0.1535 | 106.9s | ok |
| product | openai-codex | gpt-5.4 | 21732 | 2602 | $0.0934 | 101.4s | ok |
| qa | openai-codex | gpt-5.4 | 16907 | 1297 | $0.0617 | 48.4s | ok |
| security | anthropic | claude-sonnet-4-6 | 10 | 2608 | $0.0392 | 52.1s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

# Daily Cost Report — 2026-05-02

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
| openai-codex | gpt-5.4 | 5 | 86976 | 7423 | $0.3288 |

**Token usage at list rates: $0.33 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai-codex | gpt-5.4 | 9187 | 463 | $0.0299 | 34.4s | ok |
| cto | openai-codex | gpt-5.4 | 21791 | 2094 | $0.0859 | 84.9s | ok |
| dev | openai-codex | gpt-5.4 | 14105 | 1459 | $0.0571 | 63s | ok |
| product | openai-codex | gpt-5.4 | 13819 | 997 | $0.0495 | 54.2s | ok |
| security | openai-codex | gpt-5.4 | 28074 | 2410 | $0.1063 | 106.2s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 5
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

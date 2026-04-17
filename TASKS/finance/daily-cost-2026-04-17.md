# Daily Cost Report — 2026-04-17

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
| anthropic | claude-sonnet-4-6 | 1 | 12 | 3489 | $0.0524 |
| openai-codex | gpt-5.4 | 6 | 268422 | 16812 | $0.9232 |

**Token usage at list rates: $0.98 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai-codex | gpt-5.4 | 25365 | 2499 | $0.1009 | 170.7s | ok |
| content | openai-codex | gpt-5.4 | 23136 | 1919 | $0.0866 | 119.3s | ok |
| cto | openai-codex | gpt-5.4 | 50511 | 3792 | $0.1832 | 137.4s | ok |
| dev | openai-codex | gpt-5.4 | 123167 | 5625 | $0.3923 | 261.6s | ok |
| product | openai-codex | gpt-5.4 | 27464 | 1840 | $0.0963 | 55.4s | ok |
| qa | openai-codex | gpt-5.4 | 18779 | 1137 | $0.064 | 39.8s | ok |
| security | anthropic | claude-sonnet-4-6 | 12 | 3489 | $0.0524 | 76.3s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

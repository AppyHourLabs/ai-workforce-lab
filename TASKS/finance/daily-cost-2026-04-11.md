# Daily Cost Report — 2026-04-11

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
| anthropic | claude-sonnet-4-6 | 1 | 11 | 2197 | $0.033 |
| openai-codex | gpt-5.4 | 6 | 203643 | 15329 | $0.739 |

**Token usage at list rates: $0.77 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai-codex | gpt-5.4 | 50001 | 2919 | $0.1688 | 161.5s | ok |
| content | openai-codex | gpt-5.4 | 23305 | 2161 | $0.0907 | 118.9s | ok |
| cto | openai-codex | gpt-5.4 | 32613 | 4230 | $0.145 | 127.6s | ok |
| dev | openai-codex | gpt-5.4 | 34374 | 2302 | $0.1205 | 78.2s | ok |
| product | openai-codex | gpt-5.4 | 41751 | 2318 | $0.1391 | 80.3s | ok |
| qa | openai-codex | gpt-5.4 | 21599 | 1399 | $0.075 | 60s | ok |
| security | anthropic | claude-sonnet-4-6 | 11 | 2197 | $0.033 | 56.1s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

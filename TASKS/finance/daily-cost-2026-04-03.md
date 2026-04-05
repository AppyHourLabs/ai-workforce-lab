# Daily Cost Report — 2026-04-03

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
| anthropic | claude-sonnet-4-6 | 3 | 25 | 10215 | $0.1533 |
| openai-codex | gpt-5.4 | 4 | 155185 | 7654 | $0.5028 |

**Token usage at list rates: $0.66 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | anthropic | claude-sonnet-4-6 | 9 | 2157 | $0.0324 | 44.4s | ok |
| content | anthropic | claude-sonnet-4-6 | 12 | 6567 | $0.0985 | 133.6s | ok |
| cto | openai-codex | gpt-5.4 | 42905 | 2282 | $0.1415 | 71.2s | ok |
| dev | openai-codex | gpt-5.4 | 34462 | 1313 | $0.1059 | 30.4s | ok |
| product | openai-codex | gpt-5.4 | 60093 | 2760 | $0.1916 | 109.5s | ok |
| qa | openai-codex | gpt-5.4 | 17725 | 1299 | $0.0638 | 36.7s | ok |
| security | anthropic | claude-sonnet-4-6 | 4 | 1491 | $0.0224 | 30.2s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

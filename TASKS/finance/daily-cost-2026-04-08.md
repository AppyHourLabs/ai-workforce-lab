# Daily Cost Report — 2026-04-08

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
| anthropic | claude-sonnet-4-6 | 1 | 7 | 4134 | $0.062 |
| openai-codex | gpt-5.4 | 6 | 342485 | 23317 | $1.206 |

**Token usage at list rates: $1.27 / $10.00 cap (10.0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai-codex | gpt-5.4 | 48855 | 3185 | $0.1699 | 192s | ok |
| content | openai-codex | gpt-5.4 | 33410 | 9698 | $0.229 | 307.2s | ok |
| cto | openai-codex | gpt-5.4 | 49695 | 3250 | $0.173 | 126.3s | ok |
| dev | openai-codex | gpt-5.4 | 63734 | 3489 | $0.2117 | 140s | ok |
| product | openai-codex | gpt-5.4 | 127622 | 2472 | $0.3561 | 157.9s | ok |
| qa | openai-codex | gpt-5.4 | 19169 | 1223 | $0.0663 | 35.3s | ok |
| security | anthropic | claude-sonnet-4-6 | 7 | 4134 | $0.062 | 85.9s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

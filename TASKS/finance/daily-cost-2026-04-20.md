# Daily Cost Report — 2026-04-20

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
| anthropic | claude-sonnet-4-6 | 1 | 11 | 2478 | $0.0372 |
| openai-codex | gpt-5.4 | 6 | 188828 | 15442 | $0.7037 |

**Token usage at list rates: $0.74 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai-codex | gpt-5.4 | 27209 | 2960 | $0.1124 | 162.1s | ok |
| content | openai-codex | gpt-5.4 | 44941 | 1896 | $0.1408 | 126.5s | ok |
| cto | openai-codex | gpt-5.4 | 30263 | 3833 | $0.1332 | 129.3s | ok |
| dev | openai-codex | gpt-5.4 | 46077 | 3109 | $0.1618 | 88.3s | ok |
| product | openai-codex | gpt-5.4 | 23501 | 2536 | $0.0968 | 75.1s | ok |
| qa | openai-codex | gpt-5.4 | 16837 | 1108 | $0.0587 | 35s | ok |
| security | anthropic | claude-sonnet-4-6 | 11 | 2478 | $0.0372 | 90.2s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

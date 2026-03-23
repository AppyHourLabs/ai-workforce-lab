# Daily Cost Report — 2026-03-23

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
| openai-codex | gpt-5.4 | 3 | 81425 | 7323 | $0 |

**Token usage at list rates: $0.00 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai-codex | gpt-5.4 | 40177 | 2715 | $0 | 85.1s | ok |
| cto | openai-codex | gpt-5.4 | 22964 | 2887 | $0 | 84s | ok |
| product | openai-codex | gpt-5.4 | 18284 | 1721 | $0 | 41.8s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-03-04)
- Provider aliases normalize provider variants (for example, `openai-codex` → `openai`)
- Model aliases allow proxy pricing for new model IDs until explicit list rates are added (for example, `gpt-5.4` → `gpt-5.1-codex`)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 3
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

# Daily Cost Report — 2026-03-24

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
| openai | gpt-5.4 | 7 | 285311 | 24539 | $0.9587 |

**Token usage at list rates: $0.96 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai | gpt-5.4 | 21862 | 3615 | $0.0908 | 93.8s | ok |
| content | openai | gpt-5.4 | 20544 | 1854 | $0.0699 | 50.2s | ok |
| cto | openai | gpt-5.4 | 46969 | 3351 | $0.1509 | 88.3s | ok |
| dev | openai | gpt-5.4 | 73541 | 3591 | $0.2198 | 129.5s | ok |
| product | openai | gpt-5.4 | 30520 | 2063 | $0.0969 | 50.9s | ok |
| qa | openai | gpt-5.4 | 15267 | 1230 | $0.0505 | 35.2s | ok |
| security | openai | gpt-5.4 | 76608 | 8835 | $0.2799 | 239.2s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-03-04)
- Provider aliases normalize provider variants (for example, `openai-codex` → `openai`)
- Model aliases allow proxy pricing for new model IDs until explicit list rates are added (for example, `gpt-5.4` → `gpt-5.1-codex`)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

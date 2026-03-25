# Daily Cost Report — 2026-03-25

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
| google | gemini-2.5-pro | 7 | 1108995 | 10901 | $1.4407 |

**Token usage at list rates: $1.44 / $10.00 cap (10.0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | google | gemini-2.5-pro | 108508 | 1539 | $0.1433 | 40.7s | ok |
| content | google | gemini-2.5-pro | 20142 | 579 | $0.0281 | 15.9s | ok |
| cto | google | gemini-2.5-pro | 297646 | 2121 | $0.3827 | 63.8s | ok |
| dev | google | gemini-2.5-pro | 250412 | 1588 | $0.321 | 62.2s | ok |
| product | google | gemini-2.5-pro | 84597 | 1605 | $0.1138 | 36s | ok |
| qa | google | gemini-2.5-pro | 84359 | 1009 | $0.1105 | 33.8s | ok |
| security | google | gemini-2.5-pro | 263331 | 2460 | $0.3415 | 59.4s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-03-04)
- Provider aliases normalize provider variants (for example, `openai-codex` → `openai`)
- Model aliases allow proxy pricing for new model IDs until explicit list rates are added (for example, `gpt-5.4` → `gpt-5.1-codex`)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

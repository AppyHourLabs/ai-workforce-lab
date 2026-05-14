# Daily Cost Report — 2026-05-14

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
| google | gemini-2.5-flash | 1 | 52185 | 2451 | $0.0093 |
| openai-codex | gpt-5.4 | 2 | 189439 | 13267 | $0.6726 |

**Token usage at list rates: $0.68 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cto | openai-codex | gpt-5.4 | 116119 | 9078 | $0.4265 | 446.7s | ok |
| dev | openai-codex | gpt-5.4 | 73320 | 4189 | $0.2461 | 167.5s | ok |
| security | google | gemini-2.5-flash | 52185 | 2451 | $0.0093 | 73.8s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 3
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

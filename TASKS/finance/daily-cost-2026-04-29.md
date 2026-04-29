# Daily Cost Report — 2026-04-29

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
| openai-codex | gpt-5.4 | 7 | 136162 | 9611 | $0.4846 |

**Token usage at list rates: $0.48 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai-codex | gpt-5.4 | 20741 | 899 | $0.0653 | 84.9s | ok |
| content | openai-codex | gpt-5.4 | 9286 | 482 | $0.0304 | 62.8s | ok |
| cto | openai-codex | gpt-5.4 | 32378 | 2386 | $0.1167 | 121.3s | ok |
| dev | openai-codex | gpt-5.4 | 11347 | 1209 | $0.0465 | 100.7s | ok |
| product | openai-codex | gpt-5.4 | 25991 | 1832 | $0.0925 | 122.8s | ok |
| qa | openai-codex | gpt-5.4 | 9791 | 645 | $0.0342 | 68s | ok |
| security | openai-codex | gpt-5.4 | 26628 | 2158 | $0.0989 | 109.5s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

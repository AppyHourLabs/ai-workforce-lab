# Daily Cost Report — 2026-05-01

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
| openai-codex | gpt-5.4 | 7 | 105173 | 9230 | $0.4014 |

**Token usage at list rates: $0.40 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | openai-codex | gpt-5.4 | 11119 | 871 | $0.0409 | 50.1s | ok |
| content | openai-codex | gpt-5.4 | 11970 | 1053 | $0.0457 | 52.9s | ok |
| cto | openai-codex | gpt-5.4 | 25610 | 1876 | $0.0922 | 91.1s | ok |
| dev | openai-codex | gpt-5.4 | 13729 | 1345 | $0.0545 | 63.2s | ok |
| product | openai-codex | gpt-5.4 | 15254 | 1311 | $0.0578 | 69.8s | ok |
| qa | openai-codex | gpt-5.4 | 3036 | 532 | $0.0156 | 41.4s | ok |
| security | openai-codex | gpt-5.4 | 24455 | 2242 | $0.0948 | 98.6s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

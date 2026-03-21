# Daily Cost Report — 2026-03-21

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
| anthropic | claude-opus-4-6 | 2 | 14 | 3943 | $0.0986 |
| anthropic | claude-sonnet-4-6 | 3 | 39 | 16035 | $0.2406 |
| openai-codex | gpt-5.4 | 2 | 813443 | 12423 | $0 |

**Token usage at list rates: $0.34 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | anthropic | claude-sonnet-4-6 | 10 | 1944 | $0.0292 | 45s | ok |
| content | anthropic | claude-sonnet-4-6 | 21 | 11250 | $0.1688 | 256.9s | ok |
| cto | anthropic | claude-opus-4-6 | 7 | 2270 | $0.0568 | 52.2s | ok |
| dev | openai-codex | gpt-5.4 | 795889 | 10919 | $0 | 349.9s | error |
| product | anthropic | claude-opus-4-6 | 7 | 1673 | $0.0419 | 45.5s | ok |
| qa | openai-codex | gpt-5.4 | 17554 | 1504 | $0 | 51s | ok |
| security | anthropic | claude-sonnet-4-6 | 8 | 2841 | $0.0426 | 62.3s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-03-04)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

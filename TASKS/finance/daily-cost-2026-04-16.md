# Daily Cost Report — 2026-04-16

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
| anthropic | claude-opus-4-6 | 1 | 9 | 1408 | $0.0352 |
| anthropic | claude-sonnet-4-6 | 3 | 22 | 6239 | $0.0937 |
| google | gemini-2.5-pro | 3 | 101872 | 3545 | $0.1451 |

**Token usage at list rates: $0.27 / $10.00 cap (0%)**

> **Note:** The $10.00/day budget cap tracks **variable token spend only**. Fixed subscription costs ($20.00/day) are tracked separately above and are not compared against this cap.

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
| cfo | google | gemini-2.5-pro | 3167 | 114 | $0.0045 | 131s | ok |
| content | google | gemini-2.5-pro | 41216 | 1445 | $0.0587 | 117.6s | ok |
| cto | anthropic | claude-opus-4-6 | 9 | 1408 | $0.0352 | 55s | ok |
| dev | anthropic | claude-sonnet-4-6 | 8 | 1578 | $0.0237 | 75.8s | ok |
| product | google | gemini-2.5-pro | 57489 | 1986 | $0.0818 | 129.6s | ok |
| qa | anthropic | claude-sonnet-4-6 | 6 | 909 | $0.0137 | 46.2s | ok |
| security | anthropic | claude-sonnet-4-6 | 8 | 3752 | $0.0563 | 66.4s | ok |

## Notes

- Token counts sourced from `~/.openclaw/cron/runs/*.jsonl`
- Pricing from `scripts/model-pricing.json` (last updated: 2026-04-02)
- Runs with no `usage` field (auth errors, instant failures) are excluded
- Total runs with token data: 7
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based

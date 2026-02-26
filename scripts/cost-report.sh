#!/usr/bin/env bash
# cost-report.sh — Generate a daily cost report from OpenClaw cron run logs
#
# Usage:
#   bash scripts/cost-report.sh              # today's report
#   bash scripts/cost-report.sh 2026-02-25   # specific date
#
# Requires: jq (brew install jq)
# Output:  TASKS/finance/daily-cost-YYYY-MM-DD.md

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
RUNS_DIR="$HOME/.openclaw/cron/runs"
JOBS_FILE="$HOME/.openclaw/cron/jobs.json"
PRICING_FILE="$SCRIPT_DIR/model-pricing.json"
TARGET_DATE="${1:-$(date +%Y-%m-%d)}"
OUTPUT_DIR="$REPO_DIR/TASKS/finance"
OUTPUT_FILE="$OUTPUT_DIR/daily-cost-${TARGET_DATE}.md"

# ---------- preflight ----------
if ! command -v jq &>/dev/null; then
  echo "ERROR: jq is required. Install with: brew install jq" >&2
  exit 1
fi

if [[ ! -d "$RUNS_DIR" ]]; then
  echo "ERROR: Run logs directory not found: $RUNS_DIR" >&2
  exit 1
fi

if [[ ! -f "$PRICING_FILE" ]]; then
  echo "ERROR: Pricing config not found: $PRICING_FILE" >&2
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

# ---------- date range (epoch ms) ----------
# BSD date (macOS) — force midnight with explicit HMS to avoid inheriting current time
DAY_START_MS=$(( $(date -j -f "%Y-%m-%dT%H:%M:%S" "${TARGET_DATE}T00:00:00" +%s) * 1000 ))
DAY_END_MS=$(( $(date -j -f "%Y-%m-%dT%H:%M:%S" -v+1d "${TARGET_DATE}T00:00:00" +%s) * 1000 ))

# ---------- collect all matching runs into one JSON array ----------
TMP_RUNS=$(mktemp)
trap 'rm -f "$TMP_RUNS"' EXIT

for logfile in "$RUNS_DIR"/*.jsonl; do
  [[ -f "$logfile" ]] || continue
  jq -c "select(.action == \"finished\" and .usage != null and .ts >= $DAY_START_MS and .ts < $DAY_END_MS)" "$logfile" 2>/dev/null >> "$TMP_RUNS" || true
done

RUN_COUNT=$(wc -l < "$TMP_RUNS" | tr -d ' ')

if [[ "$RUN_COUNT" -eq 0 ]]; then
  cat > "$OUTPUT_FILE" <<EOF
# Daily Cost Report — $TARGET_DATE

No runs with token usage data found for this date.
EOF
  echo "Report written to $OUTPUT_FILE (no runs found)"
  exit 0
fi

# ---------- use jq to do all the heavy lifting ----------
BUDGET_CAP=$(jq -r '.budget_cap_daily_usd' "$PRICING_FILE")
PRICING_UPDATED=$(jq -r '._updated' "$PRICING_FILE")

# Merge runs with job names and pricing, compute everything in jq
REPORT_JSON=$(jq -s --argjson jobs "$(cat "$JOBS_FILE")" --argjson pricing "$(cat "$PRICING_FILE")" '
  # Build job-id -> agent-name map
  ($jobs.jobs | map({(.id): .agentId}) | add) as $agent_map |

  # Process each run
  map(
    .jobId as $jid |
    (.model // "unknown") as $model |
    (.provider // "unknown") as $provider |
    (.usage.input_tokens // 0) as $inp |
    (.usage.output_tokens // 0) as $outp |
    (.durationMs // 0) as $dur |
    (.status // "unknown") as $st |
    ($agent_map[$jid] // "unknown") as $agent |
    ($pricing.models[$model].input // 0) as $pin |
    ($pricing.models[$model].output // 0) as $pout |
    (($inp / 1000000 * $pin) + ($outp / 1000000 * $pout)) as $cost |
    {
      agent: $agent,
      provider: $provider,
      model: $model,
      input_tokens: $inp,
      output_tokens: $outp,
      cost: $cost,
      duration_s: (($dur / 1000 * 10 | floor) / 10),
      status: $st
    }
  ) |

  # Sort by agent name
  sort_by(.agent) |

  # Compute per-agent rows
  . as $runs |

  # Provider summary: group by provider+model
  (group_by(.provider + "|" + .model) | map({
    provider: .[0].provider,
    model: .[0].model,
    runs: length,
    input_tokens: (map(.input_tokens) | add),
    output_tokens: (map(.output_tokens) | add),
    cost: (map(.cost) | add)
  }) | sort_by(.provider)) as $summary |

  # Total cost
  ($runs | map(.cost) | add) as $total |

  {
    agent_rows: $runs,
    summary: $summary,
    total_cost: $total,
    run_count: ($runs | length)
  }
' "$TMP_RUNS")

# ---------- render markdown ----------
TOTAL_COST=$(echo "$REPORT_JSON" | jq -r '.total_cost')
UTILIZATION=$(echo "scale=1; $TOTAL_COST / $BUDGET_CAP * 100" | bc)

# Read subscription info
MONTHLY_FIXED=$(jq -r '.monthly_fixed_cost_usd' "$PRICING_FILE")
SUB_OPENAI=$(jq -r '.subscriptions.openai | "\(.plan) $\(.monthly_usd)/mo"' "$PRICING_FILE")
SUB_ANTHROPIC=$(jq -r '.subscriptions.anthropic | "\(.plan) $\(.monthly_usd)/mo"' "$PRICING_FILE")
SUB_GOOGLE=$(jq -r '.subscriptions.google | "\(.plan) $\(.monthly_usd)/mo"' "$PRICING_FILE")
DAILY_FIXED=$(echo "scale=2; $MONTHLY_FIXED / 30" | bc)

{
  cat <<EOF
# Daily Cost Report — $TARGET_DATE

## Fixed Costs (Subscriptions)

| Provider | Plan | Monthly | Daily (amortized) |
|----------|------|---------|-------------------|
| OpenAI | ${SUB_OPENAI} | \$$(echo "scale=2; $(jq -r '.subscriptions.openai.monthly_usd' "$PRICING_FILE") / 30" | bc) |
| Anthropic | ${SUB_ANTHROPIC} | \$$(echo "scale=2; $(jq -r '.subscriptions.anthropic.monthly_usd' "$PRICING_FILE") / 30" | bc) |
| Google | ${SUB_GOOGLE} | \$$(echo "scale=2; $(jq -r '.subscriptions.google.monthly_usd' "$PRICING_FILE") / 30" | bc) |

**Monthly fixed cost: \$$(printf "%.2f" "$MONTHLY_FIXED") | Daily amortized: \$${DAILY_FIXED}**

> Token usage below is included in subscription plans. Per-token estimates use list rates for tracking **relative usage** and detecting waste — not actual billing.

## Token Usage Summary

| Provider | Model | Runs | Input Tokens | Output Tokens | List Rate Est. |
|----------|-------|------|-------------|---------------|----------------|
EOF

  echo "$REPORT_JSON" | jq -r '.summary[] | "| \(.provider) | \(.model) | \(.runs) | \(.input_tokens) | \(.output_tokens) | $\(.cost | . * 10000 | round / 10000 | tostring) |"'

  cat <<EOF

**Token usage at list rates: \$$(printf "%.2f" "$TOTAL_COST")**
**Actual cost: \$${DAILY_FIXED}/day (subscription) | Token budget cap: \$$(printf "%.2f" "$BUDGET_CAP")/day**

## Per-Agent Breakdown

| Agent | Provider | Model | Input Tokens | Output Tokens | List Rate Est. | Duration | Status |
|-------|----------|-------|-------------|---------------|----------------|----------|--------|
EOF

  echo "$REPORT_JSON" | jq -r '.agent_rows[] | "| \(.agent) | \(.provider) | \(.model) | \(.input_tokens) | \(.output_tokens) | $\(.cost | . * 10000 | round / 10000 | tostring) | \(.duration_s)s | \(.status) |"'

  cat <<EOF

## Notes

- Token counts sourced from \`~/.openclaw/cron/runs/*.jsonl\`
- Pricing from \`scripts/model-pricing.json\` (last updated: ${PRICING_UPDATED})
- Runs with no \`usage\` field (auth errors, instant failures) are excluded
- Total runs with token data: ${RUN_COUNT}
- Per-token costs are list-rate estimates for relative comparison; actual billing is subscription-based
EOF
} > "$OUTPUT_FILE"

echo "✅ Report written to $OUTPUT_FILE"
echo "   Total: \$$(printf "%.2f" "$TOTAL_COST") / \$$(printf "%.2f" "$BUDGET_CAP") (${UTILIZATION}%)"

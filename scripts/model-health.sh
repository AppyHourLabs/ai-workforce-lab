#!/usr/bin/env bash
# model-health.sh — Model provider health dashboard from OpenClaw cron run logs
#
# Usage:
#   bash scripts/model-health.sh              # last 24h (default)
#   bash scripts/model-health.sh 2026-03-01   # specific date
#   bash scripts/model-health.sh --stdout      # print only, skip file save
#
# Requires: jq (brew install jq), python3
# Output:  TASKS/finance/model-health-YYYY-MM-DD.md (and stdout)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
RUNS_DIR="$HOME/.openclaw/cron/runs"
JOBS_FILE="$HOME/.openclaw/cron/jobs.json"
CONFIG_FILE="$HOME/.openclaw/openclaw.json"
TARGET_DATE=""
STDOUT_ONLY=false

# ---------- parse args ----------
for arg in "$@"; do
  case "$arg" in
    --stdout) STDOUT_ONLY=true ;;
    --help|-h)
      sed -n '2,10p' "$0" | sed 's/^# \?//'
      exit 0
      ;;
    *) TARGET_DATE="$arg" ;;
  esac
done
TARGET_DATE="${TARGET_DATE:-$(date +%Y-%m-%d)}"

OUTPUT_DIR="$REPO_DIR/TASKS/finance"
OUTPUT_FILE="$OUTPUT_DIR/model-health-${TARGET_DATE}.md"

# ---------- preflight ----------
if ! command -v jq &>/dev/null; then
  echo "ERROR: jq is required. Install with: brew install jq" >&2
  exit 1
fi

if [[ ! -d "$RUNS_DIR" ]]; then
  echo "ERROR: Run logs directory not found: $RUNS_DIR" >&2
  exit 1
fi

# ---------- date range (epoch ms) ----------
DAY_START_MS=$(( $(date -j -f "%Y-%m-%dT%H:%M:%S" "${TARGET_DATE}T00:00:00" +%s) * 1000 ))
DAY_END_MS=$(( $(date -j -f "%Y-%m-%dT%H:%M:%S" -v+1d "${TARGET_DATE}T00:00:00" +%s) * 1000 ))

# ---------- collect finished runs ----------
TMP_RUNS=$(mktemp)
trap 'rm -f "$TMP_RUNS"' EXIT

for logfile in "$RUNS_DIR"/*.jsonl; do
  [[ -f "$logfile" ]] || continue
  jq -c "select(.action == \"finished\" and .ts >= $DAY_START_MS and .ts < $DAY_END_MS)" "$logfile" 2>/dev/null >> "$TMP_RUNS" || true
done

RUN_COUNT=$(wc -l < "$TMP_RUNS" | tr -d ' ')

# ---------- read fallback config ----------
FALLBACKS=$(jq -r '
  (.agents.defaults.model.primary // "unknown") as $primary |
  (.agents.defaults.model.fallbacks // []) as $fbs |
  if ($fbs | length) == 0 then
    $primary + " (no fallbacks)"
  else
    $primary + " → " + ($fbs | join(" → "))
  end
' "$CONFIG_FILE" 2>/dev/null || echo "unknown")

# ---------- compute stats ----------
if [[ "$RUN_COUNT" -eq 0 ]]; then
  REPORT=$(cat <<EOF
📊 Model Health — $TARGET_DATE
──────────────────────────────
No runs found for this date.

Fallback config: $FALLBACKS
EOF
)
else
  REPORT=$(python3 -c "
import json, sys

runs = []
with open('$TMP_RUNS') as f:
    for line in f:
        line = line.strip()
        if line:
            runs.append(json.loads(line))

# Group by provider
providers = {}
error_details = []
fallback_uses = []

for r in runs:
    provider = r.get('provider', 'unknown')
    status = r.get('status', 'unknown')
    duration_ms = r.get('durationMs', 0)
    model = r.get('model', 'unknown')
    agent_id = r.get('jobId', '')
    error = r.get('error', '') or r.get('summary', '')

    if provider not in providers:
        providers[provider] = {
            'runs': 0, 'ok': 0, 'fail': 0,
            'total_duration': 0, 'models': set()
        }

    p = providers[provider]
    p['runs'] += 1
    p['models'].add(model)
    p['total_duration'] += duration_ms

    if status == 'ok':
        p['ok'] += 1
    else:
        p['fail'] += 1
        # Check for rate limit / overload errors
        err_text = str(error).lower()
        if any(kw in err_text for kw in ['overload', 'rate', '429', '503', 'capacity', 'temporarily']):
            error_details.append(f'{provider}: rate-limit/overload ({model})')
        else:
            error_details.append(f'{provider}: {status}')

# All configured providers (even if no runs)
all_providers = ['google', 'anthropic', 'openai']
for ap in all_providers:
    if ap not in providers:
        providers[ap] = {'runs': 0, 'ok': 0, 'fail': 0, 'total_duration': 0, 'models': set()}

# Build table
lines = []
lines.append('📊 Model Health — $TARGET_DATE')
lines.append('──────────────────────────────')
lines.append(f\"{'Provider':<13}│ {'Runs':>4} │ {'OK':>3} │ {'Fail':>4} │ {'Success%':>8} │ {'Avg Time':>8}\")
lines.append('─────────────┼──────┼─────┼──────┼──────────┼─────────')

for prov in all_providers:
    p = providers[prov]
    if p['runs'] == 0:
        lines.append(f\"{prov:<13}│ {'0':>4} │ {'-':>3} │ {'-':>4} │ {'-':>8} │ {'-':>8}\")
    else:
        rate = round(p['ok'] / p['runs'] * 100)
        avg_s = round(p['total_duration'] / p['runs'] / 1000)
        lines.append(f\"{prov:<13}│ {p['runs']:>4} │ {p['ok']:>3} │ {p['fail']:>4} │ {str(rate)+'%':>8} │ {str(avg_s)+'s':>8}\")

lines.append('──────────────────────────────')

# Error summary
if error_details:
    lines.append(f'⚠️  {len(error_details)} error(s): ' + '; '.join(error_details))
else:
    lines.append('✅ All runs succeeded — no errors detected')

lines.append(f'Fallback config: $FALLBACKS')
lines.append(f'Total runs: {sum(p[\"runs\"] for p in providers.values())}')

print('\n'.join(lines))
")
fi

# ---------- output ----------
echo "$REPORT"

if [[ "$STDOUT_ONLY" == "false" ]]; then
  mkdir -p "$OUTPUT_DIR"
  {
    echo "# Model Health Report — $TARGET_DATE"
    echo ""
    echo '```'
    echo "$REPORT"
    echo '```'
    echo ""
    echo "---"
    echo ""
    echo "- Source: \`~/.openclaw/cron/runs/*.jsonl\`"
    echo "- Generated: $(date '+%Y-%m-%d %H:%M ET')"
  } > "$OUTPUT_FILE"
  echo ""
  echo "📄 Report saved to $OUTPUT_FILE"
fi

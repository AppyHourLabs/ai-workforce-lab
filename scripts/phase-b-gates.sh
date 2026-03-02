#!/usr/bin/env bash
# phase-b-gates.sh — Compute Phase B promotion gate metrics from JSONL logs
#
# Reads LOGS/agent-runs.jsonl and outputs JSON metrics to stdout.
# Reference: POLICIES/phase-a-to-b.md

set -euo pipefail

LOGFILE="/Users/aioffice/ai-workforce-lab/LOGS/agent-runs.jsonl"

# ── Defaults if no log file ────────────────────────────────────────
if [[ ! -f "$LOGFILE" ]] || [[ ! -s "$LOGFILE" ]]; then
  cat <<'EOF'
{
  "computed_at": "%(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "gate_1_consecutive_publishes": 0,
  "gate_1_target": 20,
  "gate_2_violation_free_days": 0,
  "gate_2_target": 14,
  "gate_3_pass_rate": 0,
  "gate_3_total_runs": 0,
  "gate_3_target_rate": 98,
  "gate_3_target_runs": 50,
  "gate_4_drill_completed": false,
  "gate_5_logged_runs": 0,
  "gate_5_expected_runs": 0,
  "gate_5_coverage_pct": 0,
  "total_log_entries": 0,
  "oldest_entry": null,
  "newest_entry": null
}
EOF
  exit 0
fi

COMPUTED_AT=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
TOTAL_ENTRIES=$(wc -l < "$LOGFILE" | xargs)

# ── Gate 1: Consecutive successful publishes (doc agent, outcome=pass) ──
# Count from the END of the file — streak of consecutive passes
GATE1=0
while IFS= read -r line; do
  AGENT=$(echo "$line" | grep -oE '"agent_id":"[^"]*"' | cut -d'"' -f4)
  OUTCOME=$(echo "$line" | grep -oE '"outcome":"[^"]*"' | cut -d'"' -f4)
  ACTION=$(echo "$line" | grep -oE '"action_type":"[^"]*"' | cut -d'"' -f4)
  if [[ "$AGENT" == "doc" && "$ACTION" == "cron_run" ]]; then
    if [[ "$OUTCOME" == "pass" ]]; then
      GATE1=$((GATE1 + 1))
    else
      GATE1=0
    fi
  fi
done < "$LOGFILE"

# ── Gate 2: Contiguous days with zero red violations ──────────────
# Get unique dates from logs, count consecutive days with no violation_red
GATE2=0
CURRENT_STREAK=0
PREV_DATE=""

# Get all unique dates, sorted
DATES=$(grep -oE '"timestamp":"[0-9]{4}-[0-9]{2}-[0-9]{2}' "$LOGFILE" | cut -d'"' -f4 | sort -u)

for d in $DATES; do
  # Check if any violation_red on this date
  HAS_RED=$(grep "\"${d}" "$LOGFILE" | grep -c '"outcome":"violation_red"' || true)
  if [[ "$HAS_RED" -eq 0 ]]; then
    CURRENT_STREAK=$((CURRENT_STREAK + 1))
  else
    CURRENT_STREAK=0
  fi
  if [[ $CURRENT_STREAK -gt $GATE2 ]]; then
    GATE2=$CURRENT_STREAK
  fi
done

# ── Gate 3: Quality gate pass rate (trailing 30 days) ─────────────
if command -v gdate &>/dev/null; then
  THIRTY_AGO=$(gdate -u -d "30 days ago" +"%Y-%m-%d")
elif date -v-1d +%Y-%m-%d &>/dev/null 2>&1; then
  THIRTY_AGO=$(date -u -v-30d +"%Y-%m-%d")
else
  THIRTY_AGO=$(date -u -d "30 days ago" +"%Y-%m-%d")
fi

TOTAL_RUNS=0
PASS_RUNS=0
while IFS= read -r line; do
  ENTRY_DATE=$(echo "$line" | grep -oE '"timestamp":"[0-9]{4}-[0-9]{2}-[0-9]{2}' | cut -d'"' -f4)
  OUTCOME=$(echo "$line" | grep -oE '"outcome":"[^"]*"' | cut -d'"' -f4)
  ACTION=$(echo "$line" | grep -oE '"action_type":"[^"]*"' | cut -d'"' -f4)
  if [[ -n "$ENTRY_DATE" && "$ENTRY_DATE" > "$THIRTY_AGO" && "$ACTION" == "cron_run" ]]; then
    TOTAL_RUNS=$((TOTAL_RUNS + 1))
    if [[ "$OUTCOME" == "pass" ]]; then
      PASS_RUNS=$((PASS_RUNS + 1))
    fi
  fi
done < "$LOGFILE"

if [[ $TOTAL_RUNS -gt 0 ]]; then
  GATE3_RATE=$((PASS_RUNS * 100 / TOTAL_RUNS))
else
  GATE3_RATE=0
fi

# ── Gate 4: Incident drill ────────────────────────────────────────
GATE4=$( (grep '"action_type":"incident_drill"' "$LOGFILE" 2>/dev/null || true) | wc -l | xargs)
GATE4_BOOL="false"
[[ "$GATE4" -gt 0 ]] && GATE4_BOOL="true"

# ── Gate 5: Logging coverage ─────────────────────────────────────
# Count unique agent runs today
TODAY=$(date -u +"%Y-%m-%d")
LOGGED_TODAY=$( (grep "\"${TODAY}" "$LOGFILE" || true) | (grep '"action_type":"cron_run"' || true) | wc -l | xargs)
# Expected: 10 agents with daily cron jobs (sdr disabled = 9 active agent runs + 3 extra manager/content = ~12)
EXPECTED_DAILY=12
if [[ $EXPECTED_DAILY -gt 0 ]]; then
  GATE5_PCT=$((LOGGED_TODAY * 100 / EXPECTED_DAILY))
  [[ $GATE5_PCT -gt 100 ]] && GATE5_PCT=100
else
  GATE5_PCT=0
fi

# ── Oldest/newest entries ─────────────────────────────────────────
OLDEST=$(head -1 "$LOGFILE" | grep -oE '"timestamp":"[^"]*"' | cut -d'"' -f4)
NEWEST=$(tail -1 "$LOGFILE" | grep -oE '"timestamp":"[^"]*"' | cut -d'"' -f4)

# ── Output ────────────────────────────────────────────────────────
cat <<EOF
{
  "computed_at": "${COMPUTED_AT}",
  "gate_1_consecutive_publishes": ${GATE1},
  "gate_1_target": 20,
  "gate_2_violation_free_days": ${GATE2},
  "gate_2_target": 14,
  "gate_3_pass_rate": ${GATE3_RATE},
  "gate_3_total_runs": ${TOTAL_RUNS},
  "gate_3_target_rate": 98,
  "gate_3_target_runs": 50,
  "gate_4_drill_completed": ${GATE4_BOOL},
  "gate_5_logged_today": ${LOGGED_TODAY},
  "gate_5_expected_daily": ${EXPECTED_DAILY},
  "gate_5_coverage_pct": ${GATE5_PCT},
  "total_log_entries": ${TOTAL_ENTRIES},
  "oldest_entry": "${OLDEST:-null}",
  "newest_entry": "${NEWEST:-null}"
}
EOF

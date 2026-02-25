#!/usr/bin/env bash
# rerun.sh — Re-trigger agents after clearing blockers
# Part of AI Workforce Lab operational tooling
#
# Usage:
#   rerun.sh <agent>           Re-run agent + all downstream in pipeline order
#   rerun.sh <agent> --only    Re-run a single agent, no cascade
#   rerun.sh all               Re-run entire pipeline in order
#   rerun.sh --failed          Re-run only agents whose last run errored
#   rerun.sh --help            Show this help
#
# Examples:
#   rerun.sh dev               Fix cleared for dev → re-runs dev, sdr, security,
#                              content, qa, doc, manager
#   rerun.sh qa --only         Just re-run QA after merging a PR it needs to review
#   rerun.sh --failed          Morning had errors → re-run all that failed

set -euo pipefail

# ── Pipeline order (matches morning cron schedule) ──────────────────────────
# Each entry: "agent_name:job_uuid"
PIPELINE=(
  "product:99c7fea9-aec2-4685-be63-b7dae692b0f8"
  "cto:b4551909-1d9d-46b2-b3aa-060e205b85a2"
  "cfo:a436d5b3-c2bd-4c15-a9e7-2f06ac9cf86e"
  "dev:863bbd41-3c7e-4fea-adc2-74cee8602bfb"
  "sdr:36492a09-5eb0-4421-a234-bf36fd9d463e"
  "security:d4e5f6a7-b8c9-40d1-e2f3-a4b5c6d7e8f9"
  "content:c3d4e5f6-a7b8-49c0-d1e2-f3a4b5c6d7e8"
  "qa:b2c3d4e5-f6a7-48b9-c0d1-e2f3a4b5c6d7"
  "doc:af87d6d7-c60b-49df-877f-008953e2531f"
  "manager:15a7cc9f-06b2-419e-827a-ea8e2a7e9b0c"
)

JOBS_FILE="$HOME/.openclaw/cron/jobs.json"

# ── Helpers ─────────────────────────────────────────────────────────────────

usage() {
  sed -n '2,17p' "$0" | sed 's/^# \?//'
  exit 0
}

get_name()  { echo "${1%%:*}"; }
get_uuid()  { echo "${1#*:}"; }

# Find the index of an agent in the pipeline (0-based)
pipeline_index() {
  local target="$1"
  for i in "${!PIPELINE[@]}"; do
    if [[ "$(get_name "${PIPELINE[$i]}")" == "$target" ]]; then
      echo "$i"
      return 0
    fi
  done
  echo "-1"
  return 1
}

# Run a single agent by job UUID, wait for completion
run_agent() {
  local name="$1" uuid="$2"
  printf "  ▶ %-12s " "$name"
  if openclaw cron run "$uuid" > /dev/null 2>&1; then
    echo "✅ triggered"
  else
    echo "❌ trigger failed"
    return 1
  fi
}

# Get agents whose last run errored (parses jobs.json)
get_failed_agents() {
  python3 -c "
import json, sys
with open('$JOBS_FILE') as f:
    data = json.load(f)
for job in data.get('jobs', []):
    state = job.get('state', {})
    if state.get('lastStatus') == 'error' or state.get('lastRunStatus') == 'error':
        print(job.get('agentId', ''))
"
}

# ── Main ────────────────────────────────────────────────────────────────────

if [[ $# -eq 0 ]] || [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
  usage
fi

MODE="cascade"  # default: run agent + downstream
TARGET=""

if [[ "$1" == "--failed" ]]; then
  MODE="failed"
elif [[ "$1" == "all" ]]; then
  MODE="all"
else
  TARGET="$1"
  if [[ $# -ge 2 ]] && [[ "$2" == "--only" ]]; then
    MODE="only"
  fi
fi

echo ""
echo "🔄 Agent Rerun — $(date '+%Y-%m-%d %H:%M ET')"
echo "─────────────────────────────────────────"

case "$MODE" in
  only)
    idx=$(pipeline_index "$TARGET")
    if [[ "$idx" == "-1" ]]; then
      echo "❌ Unknown agent: $TARGET"
      echo "   Valid agents: $(printf '%s ' "${PIPELINE[@]}" | sed 's/:[^ ]*//g')"
      exit 1
    fi
    echo "Mode: single agent"
    echo ""
    run_agent "$TARGET" "$(get_uuid "${PIPELINE[$idx]}")"
    ;;

  cascade)
    idx=$(pipeline_index "$TARGET")
    if [[ "$idx" == "-1" ]]; then
      echo "❌ Unknown agent: $TARGET"
      echo "   Valid agents: $(printf '%s ' "${PIPELINE[@]}" | sed 's/:[^ ]*//g')"
      exit 1
    fi
    remaining=$(( ${#PIPELINE[@]} - idx ))
    echo "Mode: cascade from $TARGET ($remaining agents)"
    echo ""
    for (( i=idx; i<${#PIPELINE[@]}; i++ )); do
      entry="${PIPELINE[$i]}"
      run_agent "$(get_name "$entry")" "$(get_uuid "$entry")"
    done
    ;;

  all)
    echo "Mode: full pipeline (${#PIPELINE[@]} agents)"
    echo ""
    for entry in "${PIPELINE[@]}"; do
      run_agent "$(get_name "$entry")" "$(get_uuid "$entry")"
    done
    ;;

  failed)
    failed_agents=$(get_failed_agents)
    if [[ -z "$failed_agents" ]]; then
      echo "Mode: re-run failed"
      echo ""
      echo "  ✅ No failed agents found — all last runs succeeded."
      exit 0
    fi
    # Count and display
    count=$(echo "$failed_agents" | wc -l | tr -d ' ')
    echo "Mode: re-run failed ($count agent(s))"
    echo ""
    # Re-run in pipeline order
    for entry in "${PIPELINE[@]}"; do
      name=$(get_name "$entry")
      if echo "$failed_agents" | grep -qx "$name"; then
        run_agent "$name" "$(get_uuid "$entry")"
      fi
    done
    ;;
esac

echo ""
echo "Done. Check results: openclaw cron list"
echo ""

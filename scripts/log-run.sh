#!/usr/bin/env bash
# log-run.sh — Append a structured JSONL entry to LOGS/agent-runs.jsonl
# Called by agents at the end of each cron run.
#
# Usage:
#   bash log-run.sh --agent doc --job doc-daily-checkin --action cron_run \
#     --outcome pass --gates "markdown_lint,schema_validation" \
#     --pr 108 --notes "Drafted episode 012"
#
# All flags are optional except --agent and --outcome.

set -euo pipefail

LOGFILE="/Users/aioffice/ai-workforce-lab/LOGS/agent-runs.jsonl"
AGENT=""
JOB=""
ACTION="cron_run"
OUTCOME=""
TARGETS=""
GATES=""
PR=""
NOTES=""
DURATION=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --agent)    AGENT="$2";    shift 2 ;;
    --job)      JOB="$2";     shift 2 ;;
    --action)   ACTION="$2";  shift 2 ;;
    --outcome)  OUTCOME="$2"; shift 2 ;;
    --targets)  TARGETS="$2"; shift 2 ;;
    --gates)    GATES="$2";   shift 2 ;;
    --pr)       PR="$2";      shift 2 ;;
    --notes)    NOTES="$2";   shift 2 ;;
    --duration) DURATION="$2"; shift 2 ;;
    *)          echo "Unknown flag: $1" >&2; shift ;;
  esac
done

if [[ -z "$AGENT" || -z "$OUTCOME" ]]; then
  echo "ERROR: --agent and --outcome are required" >&2
  echo "Usage: log-run.sh --agent <id> --outcome <pass|fail|skip|error> [--job ...] [--notes ...]" >&2
  exit 1
fi

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Build JSON manually to avoid jq dependency
# Escape double quotes in string fields
escape() { printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'; }

JSON="{"
JSON+="\"timestamp\":\"${TIMESTAMP}\""
JSON+=",\"agent_id\":\"$(escape "$AGENT")\""
[[ -n "$JOB" ]]      && JSON+=",\"job_name\":\"$(escape "$JOB")\""
JSON+=",\"action_type\":\"$(escape "$ACTION")\""
JSON+=",\"outcome\":\"$(escape "$OUTCOME")\""

# targets as JSON array
if [[ -n "$TARGETS" ]]; then
  TARR=""
  IFS=',' read -ra TPARTS <<< "$TARGETS"
  for t in "${TPARTS[@]}"; do
    [[ -n "$TARR" ]] && TARR+=","
    TARR+="\"$(escape "$(echo "$t" | xargs)")\""
  done
  JSON+=",\"target_files\":[${TARR}]"
fi

# gates as JSON array
if [[ -n "$GATES" ]]; then
  GARR=""
  IFS=',' read -ra GPARTS <<< "$GATES"
  for g in "${GPARTS[@]}"; do
    [[ -n "$GARR" ]] && GARR+=","
    GARR+="\"$(escape "$(echo "$g" | xargs)")\""
  done
  JSON+=",\"policy_gates_run\":[${GARR}]"
fi

[[ -n "$PR" ]]       && JSON+=",\"pr_number\":${PR}"
[[ -n "$DURATION" ]] && JSON+=",\"duration_s\":${DURATION}"
[[ -n "$NOTES" ]]    && JSON+=",\"notes\":\"$(escape "$NOTES")\""
JSON+="}"

# Append atomically
echo "$JSON" >> "$LOGFILE"
echo "✅ Logged: agent=$AGENT outcome=$OUTCOME"

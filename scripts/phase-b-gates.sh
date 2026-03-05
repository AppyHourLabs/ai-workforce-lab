#!/usr/bin/env bash
# phase-b-gates.sh — Compute Phase B promotion gate metrics from JSONL logs
#
# Reads LOGS/agent-runs.jsonl and outputs JSON metrics to stdout.
# Reference: POLICIES/phase-a-to-b.md
#
# Requires: jq (brew install jq)

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LOGFILE="${REPO_ROOT}/LOGS/agent-runs.jsonl"

# ── Preflight ──────────────────────────────────────────────────────
if ! command -v jq &>/dev/null; then
  echo "ERROR: jq is required. Install with: brew install jq" >&2
  exit 1
fi

# ── Defaults if no log file ────────────────────────────────────────
if [[ ! -f "$LOGFILE" ]] || [[ ! -s "$LOGFILE" ]]; then
  jq -n '{
    computed_at: (now | strftime("%Y-%m-%dT%H:%M:%SZ")),
    gate_1_consecutive_publishes: 0, gate_1_target: 20,
    gate_2_violation_free_days: 0, gate_2_target: 14,
    gate_3_pass_rate: 0, gate_3_total_runs: 0,
    gate_3_target_rate: 98, gate_3_target_runs: 50,
    gate_4_drill_completed: false,
    gate_5_logged_today: 0, gate_5_expected_daily: 0, gate_5_coverage_pct: 0,
    total_log_entries: 0, oldest_entry: null, newest_entry: null
  }'
  exit 0
fi

COMPUTED_AT=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
TOTAL_ENTRIES=$(wc -l < "$LOGFILE" | xargs)

# ── Compute 30-day cutoff ─────────────────────────────────────────
if command -v gdate &>/dev/null; then
  THIRTY_AGO=$(gdate -u -d "30 days ago" +"%Y-%m-%d")
elif date -v-1d +%Y-%m-%d &>/dev/null 2>&1; then
  THIRTY_AGO=$(date -u -v-30d +"%Y-%m-%d")
else
  THIRTY_AGO=$(date -u -d "30 days ago" +"%Y-%m-%d")
fi

TODAY=$(date -u +"%Y-%m-%d")
EXPECTED_DAILY=12

# ── Single-pass jq computation of all gates ────────────────────────
jq -s \
  --arg computed_at "$COMPUTED_AT" \
  --arg thirty_ago "$THIRTY_AGO" \
  --arg today "$TODAY" \
  --argjson expected_daily "$EXPECTED_DAILY" \
  --argjson total_entries "$TOTAL_ENTRIES" \
'
  # ── Gate 1: Consecutive doc agent passes (streak from end) ──
  (reduce .[] as $entry (0;
    if $entry.agent_id == "doc" and $entry.action_type == "cron_run" then
      if $entry.outcome == "pass" then . + 1 else 0 end
    else .
    end
  )) as $gate1 |

  # ── Gate 2: Max contiguous days with zero red violations ──
  ([.[] | .timestamp[:10]] | unique | sort) as $dates |
  ([.[] | select(.outcome == "violation_red") | .timestamp[:10]] | unique) as $red_dates |
  ($dates | reduce .[] as $d ({streak: 0, max: 0};
    if ($red_dates | index($d)) then
      .streak = 0
    else
      .streak += 1 |
      if .streak > .max then .max = .streak else . end
    end
  ) | .max) as $gate2 |

  # ── Gate 3: Quality gate pass rate (trailing 30 days) ──
  [.[] | select(.action_type == "cron_run" and .timestamp[:10] > $thirty_ago)] as $recent |
  ($recent | length) as $total_runs |
  ([.[] | select(.action_type == "cron_run" and .timestamp[:10] > $thirty_ago and .outcome == "pass")] | length) as $pass_runs |
  (if $total_runs > 0 then ($pass_runs * 100 / $total_runs | floor) else 0 end) as $gate3_rate |

  # ── Gate 4: Incident drill ──
  ([.[] | select(.action_type == "incident_drill")] | length > 0) as $gate4 |

  # ── Gate 5: Logging coverage today ──
  ([.[] | select(.timestamp[:10] == $today and .action_type == "cron_run")] | length) as $logged_today |
  (if $expected_daily > 0 then
    ([$logged_today * 100 / $expected_daily | floor, 100] | min)
  else 0 end) as $gate5_pct |

  # ── Oldest/newest entries ──
  (first | .timestamp) as $oldest |
  (last | .timestamp) as $newest |

  # ── Output ──
  {
    computed_at: $computed_at,
    gate_1_consecutive_publishes: $gate1,
    gate_1_target: 20,
    gate_2_violation_free_days: $gate2,
    gate_2_target: 14,
    gate_3_pass_rate: $gate3_rate,
    gate_3_total_runs: $total_runs,
    gate_3_target_rate: 98,
    gate_3_target_runs: 50,
    gate_4_drill_completed: $gate4,
    gate_5_logged_today: $logged_today,
    gate_5_expected_daily: $expected_daily,
    gate_5_coverage_pct: $gate5_pct,
    total_log_entries: $total_entries,
    oldest_entry: $oldest,
    newest_entry: $newest
  }
' "$LOGFILE"

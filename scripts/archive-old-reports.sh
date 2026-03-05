#!/usr/bin/env bash
# archive-old-reports.sh — Move old daily cost reports and eval results to archive/
#
# Usage: bash scripts/archive-old-reports.sh [days_to_keep]
# Default: keeps last 14 days of reports, archives the rest
#
# Run monthly via cron or manually as needed.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DAYS_TO_KEEP="${1:-14}"

# ── Date cutoff ────────────────────────────────────────────────────
if date -v-1d +%Y-%m-%d &>/dev/null 2>&1; then
  CUTOFF=$(date -u -v-${DAYS_TO_KEEP}d +"%Y-%m-%d")
else
  CUTOFF=$(date -u -d "${DAYS_TO_KEEP} days ago" +"%Y-%m-%d")
fi

echo "📦 Archiving reports older than ${CUTOFF} (keeping last ${DAYS_TO_KEEP} days)"

# ── Archive finance reports ────────────────────────────────────────
FINANCE_DIR="${REPO_ROOT}/TASKS/finance"
FINANCE_ARCHIVE="${FINANCE_DIR}/archive"
mkdir -p "$FINANCE_ARCHIVE"
MOVED=0

for f in "${FINANCE_DIR}"/daily-cost-*.md; do
  [[ -f "$f" ]] || continue
  # Extract date from filename: daily-cost-YYYY-MM-DD.md
  FILE_DATE=$(basename "$f" | sed 's/daily-cost-\(.*\)\.md/\1/')
  if [[ "$FILE_DATE" < "$CUTOFF" ]]; then
    mv "$f" "$FINANCE_ARCHIVE/"
    MOVED=$((MOVED + 1))
  fi
done
echo "   Finance: archived ${MOVED} report(s)"

# ── Archive eval results ──────────────────────────────────────────
EVALS_DIR="${REPO_ROOT}/EVALS/results"
EVALS_ARCHIVE="${EVALS_DIR}/archive"
mkdir -p "$EVALS_ARCHIVE"
MOVED=0

for f in "${EVALS_DIR}"/*.md; do
  [[ -f "$f" ]] || continue
  # Extract date from filename: YYYY-MM-DD-*.md
  FILE_DATE=$(basename "$f" | grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2}' || true)
  if [[ -n "$FILE_DATE" && "$FILE_DATE" < "$CUTOFF" ]]; then
    mv "$f" "$EVALS_ARCHIVE/"
    MOVED=$((MOVED + 1))
  fi
done
echo "   Evals: archived ${MOVED} result(s)"

echo "✅ Archival complete"

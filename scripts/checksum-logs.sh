#!/usr/bin/env bash
# checksum-logs.sh — Daily integrity: SHA-256 hash today's log entries, trim >90 days
#
# Run daily after all agents complete (e.g. 11:00 ET via GitHub Action or cron).
# Stores checksums in LOGS/checksums/YYYY-MM-DD.sha256

set -euo pipefail

LOGFILE="/Users/aioffice/ai-workforce-lab/LOGS/agent-runs.jsonl"
CHECKSUM_DIR="/Users/aioffice/ai-workforce-lab/LOGS/checksums"
TODAY=$(date -u +"%Y-%m-%d")
RETENTION_DAYS=90

mkdir -p "$CHECKSUM_DIR"

# ── 1. Extract today's entries and checksum ────────────────────────
if [[ ! -f "$LOGFILE" ]]; then
  echo "No log file found at $LOGFILE — nothing to checksum."
  exit 0
fi

# Extract entries with today's date
TODAY_ENTRIES=$(grep "\"timestamp\":\"${TODAY}" "$LOGFILE" || true)

if [[ -z "$TODAY_ENTRIES" ]]; then
  echo "No entries for $TODAY — skipping checksum."
  exit 0
fi

# Compute SHA-256
HASH=$(echo "$TODAY_ENTRIES" | shasum -a 256 | awk '{print $1}')
ENTRY_COUNT=$(echo "$TODAY_ENTRIES" | wc -l | xargs)

# Write checksum file
cat > "${CHECKSUM_DIR}/${TODAY}.sha256" <<EOF
# Phase B Gate 5 — Log Integrity Checksum
# Date: ${TODAY}
# Entries: ${ENTRY_COUNT}
# Algorithm: SHA-256
${HASH}  agent-runs.jsonl:${TODAY}
EOF

echo "✅ Checksum: ${HASH} (${ENTRY_COUNT} entries for ${TODAY})"

# ── 2. Trim entries older than 90 days ─────────────────────────────
if command -v gdate &>/dev/null; then
  CUTOFF=$(gdate -u -d "${RETENTION_DAYS} days ago" +"%Y-%m-%d")
elif date -v-1d +%Y-%m-%d &>/dev/null 2>&1; then
  # macOS date
  CUTOFF=$(date -u -v-${RETENTION_DAYS}d +"%Y-%m-%d")
else
  CUTOFF=$(date -u -d "${RETENTION_DAYS} days ago" +"%Y-%m-%d")
fi

BEFORE_COUNT=$(wc -l < "$LOGFILE" | xargs)

# Keep only entries with timestamps >= cutoff
# Extract the date portion of each timestamp and compare
TMPFILE=$(mktemp)
while IFS= read -r line; do
  ENTRY_DATE=$(echo "$line" | grep -oE '"timestamp":"[0-9]{4}-[0-9]{2}-[0-9]{2}' | head -1 | cut -d'"' -f4)
  if [[ -n "$ENTRY_DATE" && "$ENTRY_DATE" > "$CUTOFF" || "$ENTRY_DATE" == "$CUTOFF" ]]; then
    echo "$line" >> "$TMPFILE"
  fi
done < "$LOGFILE"

mv "$TMPFILE" "$LOGFILE"
AFTER_COUNT=$(wc -l < "$LOGFILE" | xargs)
TRIMMED=$((BEFORE_COUNT - AFTER_COUNT))

if [[ $TRIMMED -gt 0 ]]; then
  echo "🗑️ Trimmed $TRIMMED entries older than $CUTOFF"
else
  echo "📦 No entries to trim (all within ${RETENTION_DAYS}-day window)"
fi

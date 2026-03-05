#!/usr/bin/env bash
# process-new-episodes.sh — Detect unprocessed episodes and generate B-roll + upload to YouTube
#
# Usage:
#   bash scripts/process-new-episodes.sh              # process all unprocessed
#   bash scripts/process-new-episodes.sh --dry-run    # detect only, no generation
#
# Requires: python3, google-genai, google-api-python-client

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
EPISODES_DIR="$REPO_DIR/DOCS/SHOW/episodes"
DRY_RUN=false

if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=true
  echo "🔍 Dry run mode — detecting only, no generation."
fi

# ---------- find unprocessed episodes ----------
PROCESSED=0
SKIPPED=0
ERRORS=0

for episode_md in "$EPISODES_DIR"/*.md; do
  [[ -f "$episode_md" ]] || continue
  
  basename_no_ext="${episode_md%.md}"
  mp4_file="${basename_no_ext}.mp4"
  episode_name="$(basename "$episode_md")"
  
  # Check if this episode has a Veo 3 Prompt
  if ! grep -q "Veo 3 Prompt:" "$episode_md" 2>/dev/null; then
    continue  # No prompt, not a video episode
  fi
  
  # Check if MP4 already exists (already processed)
  if [[ -f "$mp4_file" ]]; then
    SKIPPED=$((SKIPPED + 1))
    continue
  fi
  
  echo "📹 Found unprocessed episode: $episode_name"
  
  if $DRY_RUN; then
    echo "   Would generate B-roll and upload to YouTube."
    PROCESSED=$((PROCESSED + 1))
    continue
  fi
  
  # ---------- Step 1: Generate B-roll ----------
  echo "   Generating B-roll video..."
  if python3 "$SCRIPT_DIR/generate-broll.py" "$episode_md"; then
    echo "   ✅ B-roll generated: $mp4_file"
  else
    echo "   ❌ B-roll generation failed for $episode_name"
    ERRORS=$((ERRORS + 1))
    continue
  fi
  
  # ---------- Step 2: Upload to YouTube ----------
  if [[ -f "$mp4_file" ]]; then
    echo "   Uploading to YouTube..."
    if python3 "$SCRIPT_DIR/upload-youtube.py" --video "$mp4_file" --episode "$episode_md"; then
      echo "   ✅ Uploaded to YouTube"
    else
      echo "   ⚠️  YouTube upload failed (video saved locally at $mp4_file)"
      ERRORS=$((ERRORS + 1))
    fi
  fi
  
  PROCESSED=$((PROCESSED + 1))
done

# ---------- summary ----------
echo ""
echo "Episode Pipeline Summary:"
echo "  Processed: $PROCESSED"
echo "  Skipped (already have MP4): $SKIPPED"
echo "  Errors: $ERRORS"

if [[ $ERRORS -gt 0 ]]; then
  exit 1
fi

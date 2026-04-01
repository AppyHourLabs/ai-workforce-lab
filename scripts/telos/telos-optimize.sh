#!/usr/bin/env bash
# telos-optimize.sh — Run the Telos token optimizer after the last daily cron cycle
#
# Usage:
#   bash scripts/telos/telos-optimize.sh              # today
#   bash scripts/telos/telos-optimize.sh 2026-03-31   # specific date
#
# Scheduled: daily at 18:00 ET (after the last agent cron at 17:30)
# Output: EVALS/telos/recommendations/recommendation-YYYY-MM-DD.md

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
VENV_DIR="$HOME/telos-framework/.venv"
TELOS_SRC="$HOME/telos-framework/telos-framework"
TARGET_DATE="${1:-$(date +%Y-%m-%d)}"

# --- Preflight ---
if [[ ! -d "$VENV_DIR" ]]; then
  echo "ERROR: Telos venv not found at $VENV_DIR" >&2
  echo "Run: uv venv $VENV_DIR --python 3.13 && uv pip install -e $TELOS_SRC highspy" >&2
  exit 1
fi

# --- Run ---
echo "[telos-optimize] Running for date: $TARGET_DATE"
echo "[telos-optimize] Repo: $REPO_DIR"

source "$VENV_DIR/bin/activate"
PYTHONPATH="$TELOS_SRC:${PYTHONPATH:-}" \
  python "$SCRIPT_DIR/run_optimizer.py" --date "$TARGET_DATE"

EXIT_CODE=$?

if [[ $EXIT_CODE -eq 0 ]]; then
  echo "[telos-optimize] ✅ Done. Recommendation at: $REPO_DIR/EVALS/telos/recommendations/recommendation-${TARGET_DATE}.md"
else
  echo "[telos-optimize] ❌ Optimizer failed (exit $EXIT_CODE)" >&2
fi

exit $EXIT_CODE

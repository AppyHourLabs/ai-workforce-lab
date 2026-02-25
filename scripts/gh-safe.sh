#!/usr/bin/env bash
# gh-safe — wrapper around `gh` CLI that prevents interactive hangs.
#
# Problem: `gh pr create` without --body or --fill opens an interactive editor
# that hangs indefinitely in headless/cron environments.
#
# Solution: This wrapper intercepts `gh pr create` calls and auto-adds --fill
# if neither --body nor --fill is present. All other `gh` subcommands pass
# through unchanged.
#
# Install: symlink or copy to a directory earlier in $PATH than the real `gh`,
# or alias gh=gh-safe in agent shell profiles.
#
# See also: RUNBOOKS/cron-troubleshooting.md § Hung Terminal Sessions

set -euo pipefail

# Real gh binary location (hardcoded to avoid self-referencing when this
# script shadows gh in PATH)
REAL_GH="/opt/homebrew/bin/gh"
if [[ ! -x "$REAL_GH" ]]; then
  echo "gh-safe: error: gh CLI not found at $REAL_GH" >&2
  exit 1
fi

# If not a `pr create` command, pass through unchanged
if [[ "${1:-}" != "pr" ]] || [[ "${2:-}" != "create" ]]; then
  exec "$REAL_GH" "$@"
fi

# Check if --body, --body-file, or --fill is already present
HAS_BODY=false
for arg in "$@"; do
  case "$arg" in
    --body|--body-file|--fill|-f)
      HAS_BODY=true
      break
      ;;
    --body=*|--body-file=*)
      HAS_BODY=true
      break
      ;;
  esac
done

if [[ "$HAS_BODY" == "false" ]]; then
  echo "gh-safe: WARNING — 'gh pr create' called without --body or --fill." >&2
  echo "gh-safe: Auto-adding --fill to prevent interactive hang." >&2
  exec "$REAL_GH" "$@" --fill
else
  exec "$REAL_GH" "$@"
fi

# Runbook — Cron Job Troubleshooting

> **Audience:** Anyone debugging OpenClaw cron jobs that fail to run or deliver.
> **Last updated:** 2026-02-22

---

## Quick Checks

```bash
# Is the gateway running?
openclaw gateway status

# List all cron jobs with status
openclaw cron list

# Show recent run history for a job
openclaw cron runs <job-id>

# Check gateway logs (last 20 lines)
tail -20 ~/.openclaw/logs/gateway.log

# Check error log
tail -20 ~/.openclaw/logs/gateway.err.log

# Full verbose log (today)
cat /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log | grep -i "error\|fail\|timeout"
```

---

## Common Failures

### `cron delivery target is missing`

**Cause:** Job has `"delivery": {"mode": "announce", "channel": "slack"}` but no `"to"` field specifying the destination.

**Fix:**
```bash
openclaw cron edit <job-id> --announce --channel slack --to "C0AFXJR71V5"
```

> ⚠️ **Use the Slack channel ID, not the display name.** `--to "#ai-office"` fails silently with `Slack channels require a channel id`. The `#ai-office` channel ID is `C0AFXJR71V5`.

**Verify:** Check `~/.openclaw/cron/jobs.json` — each job's `delivery` block should have `"to": "C0AFXJR71V5"`.

---

### `cron announce delivery failed`

**Cause:** Usually `gateway closed (1008): pairing required`. The cron subsystem's internal WebSocket client needs device authorization.

**Diagnosis:**
```bash
# Check for pending device pairing requests
openclaw devices list
```

**Fix:**
```bash
# Approve the pending request
openclaw devices approve <request-id>
```

If there are no pending requests, restart the gateway and check again:
```bash
openclaw gateway restart
openclaw devices list
```

---

### `cron: job execution timed out`

**Cause:** The agent's LLM inference or tool execution exceeded the timeout. Common when agents compose long-form content inline instead of using the `write` tool.

**Diagnosis:**
```bash
# Check the session log for the timed-out run
# Find the session ID from the run log:
tail -1 ~/.openclaw/cron/runs/<job-id>.jsonl

# Then look at the session:
cat ~/.openclaw/agents/<agent-id>/sessions/<session-id>.jsonl | \
  python3 -c "import sys,json; [print(json.loads(l).get('timestamp','')[:19], json.loads(l).get('type','')) for l in sys.stdin]"
```

Look for long gaps between timestamps — that's where the model was stuck generating.

**Fix:**
1. **Increase timeout:** `openclaw cron edit <job-id> --timeout-seconds 900`
2. **Simplify the prompt:** Tell the agent to keep responses short, use tools for file writes, and avoid composing long content inline.
3. **Set best-effort delivery:** `openclaw cron edit <job-id> --best-effort-deliver` (job succeeds even if delivery fails).

---

### `channel resolve failed; using config entries. Error: missing_scope`

**Cause:** Non-blocking warning. OpenClaw tries to enumerate all Slack channels at startup but may lack the `groups:read` scope for private channels. Falls back to config entries.

**Impact:** None — agents can still send and receive messages. Can be ignored unless you need the bot to auto-discover channels.

**Fix (optional):** Add `groups:read` scope to the Slack app at [api.slack.com/apps](https://api.slack.com/apps) → OAuth & Permissions → Reinstall to Workspace.

---

## Hung Terminal Sessions

Interactive CLI commands like `gh pr create` (without `--fill` or `--body`) will hang waiting for user input indefinitely. If you see a terminal command running for hours:

```bash
# Find and kill hung gh processes
pkill -f "gh pr create"

# Or kill by PID
ps aux | grep "gh pr" | grep -v grep
kill <pid>
```

**Prevention:** Always use non-interactive flags for commands run by agents or scripts:
```bash
# Good — non-interactive
gh pr create --repo AppyHourLabs/ai-workforce-lab \
  --title "Episode 003" --body "Draft episode" --head doc/episode-003

# Bad — waits for interactive editor
gh pr create
```

---

## Useful Diagnostic Paths

| Path | Contents |
|---|---|
| `~/.openclaw/cron/jobs.json` | All cron job definitions and state |
| `~/.openclaw/cron/runs/<job-id>.jsonl` | Run history per job (append-only) |
| `~/.openclaw/agents/<agent>/sessions/` | Agent session transcripts |
| `~/.openclaw/logs/gateway.log` | Gateway lifecycle events |
| `~/.openclaw/logs/gateway.err.log` | Errors and warnings |
| `/tmp/openclaw/openclaw-<date>.log` | Full verbose daily log |

---

## Manual Job Trigger

```bash
# Trigger a specific job immediately (uses job UUID, not name)
openclaw cron run <job-id>

# Find job IDs
openclaw cron list
```

---

*Part of the AI Workforce Lab operational runbooks. See also: `session-handoff.md`, `new-agent-slack-setup.md`.*

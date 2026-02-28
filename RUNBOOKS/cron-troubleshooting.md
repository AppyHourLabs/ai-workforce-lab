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

### `FailoverError: No API key found for provider`

**Cause:** The agent's model provider (e.g., `anthropic`, `google`) has no API key in `auth-profiles.json`. Shell environment variables (`ANTHROPIC_API_KEY`, `GOOGLE_API_KEY`) are **not** available to the gateway LaunchAgent.

**Diagnosis:**
```bash
# Check which providers have valid auth
openclaw models status

# Look for providers with "missing" effective key
# Providers using OpenAI may work via env vars if the ad-hoc process is running,
# but Anthropic/Google will fail when the LaunchAgent serves requests
```

**Fix:**
```bash
# Edit/create the auth store with the missing provider key:
# File: ~/.openclaw/agents/main/agent/auth-profiles.json
# Format:
# {
#   "profiles": {
#     "<provider>:manual": {
#       "provider": "<provider>",
#       "type": "api_key",
#       "key": "<your-api-key>"
#     }
#   }
# }
```

> ⚠️ **All agents fall back to the main agent's `auth-profiles.json`.** You only need to add the key once — it covers all agents using that provider. See [2026-02-23 RCA](../DOCS/incidents/2026-02-23-gateway-auth-outage-rca.md).

---

### `write failed: Path escapes workspace root`

**Cause:** OpenClaw's `write` tool is sandboxed to the agent's own workspace root (e.g., `~/.openclaw/workspaces/qa`). Any attempt to write to a path outside that root — including the shared brain at `~/.openclaw/workspaces/shared/brain/` — fails with this error. Affects any agent writing handoff files or updating `fleet-status.md`.

**Symptoms:**
- `qa-daily-gate` or `doc-daily-checkin` last run shows `status: error` with this message
- `fleet-status.md` or `handoffs/*.md` not updated after a run
- Downstream agents (content, manager) have stale/empty handoff data

**Affected paths:**
- `~/.openclaw/workspaces/shared/brain/fleet-status.md`
- `~/.openclaw/workspaces/shared/brain/handoffs/*.md`

**Fix:** The cron job `message` payload must instruct agents to use `exec` (not the `write` tool) for these paths. The `IMPORTANT — SHARED BRAIN WRITES` block in each affected job's message does this. If you add a new agent that needs to write to the shared brain, include this instruction in its cron prompt:

```
IMPORTANT — SHARED BRAIN WRITES: The write tool will fail for
/Users/aioffice/.openclaw/workspaces/shared/brain/ paths (error: Path escapes
workspace root). Use exec to run shell or python3 commands instead of the write
tool. If a shared brain write fails, log it and continue — do NOT abort the run.
```

**Verify fix is present:**
```bash
python3 -c "
import json
with open('/Users/aioffice/.openclaw/cron/jobs.json') as f:
    jobs = json.load(f)
for job in jobs['jobs']:
    msg = job['payload'].get('message', '')
    if 'shared/brain' in msg and 'IMPORTANT' not in msg:
        print('MISSING fix in:', job.get('id'), job.get('name'))
print('Check complete.')
"
```

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

### `gh-safe` wrapper (automated prevention)

A wrapper script at `scripts/gh-safe.sh` intercepts `gh pr create` calls and auto-adds `--fill` if neither `--body` nor `--fill` is provided. It's symlinked to `~/.local/bin/gh` and prepended to `$PATH` via `~/.zprofile`, so it shadows the real `gh` binary for all shell sessions — including agent cron runs.

```bash
# Verify the wrapper is active
which gh
# Should return: /Users/aioffice/.local/bin/gh

# Test it
gh pr create --repo AppyHourLabs/ai-workforce-lab --head test-branch
# Should print: "gh-safe: WARNING — 'gh pr create' called without --body or --fill."
# And auto-add --fill
```

All agent SOUL.md files also include a safety constraint against running interactive CLI commands.


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

## Re-running After Fixes

When you clear a blocker (merge a PR, fix a config, resolve an error), use `scripts/rerun.sh` to re-trigger agents without waiting for the next morning window:

```bash
# Re-run agent + all downstream agents in pipeline order
scripts/rerun.sh dev

# Re-run just one agent, no cascade
scripts/rerun.sh qa --only

# Re-run only agents whose last run errored
scripts/rerun.sh --failed

# Re-run entire pipeline
scripts/rerun.sh all
```

The afternoon manager sweep (14:00 ET) also auto-catches failed/blocked agents. See `system-operations.md` for details.

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

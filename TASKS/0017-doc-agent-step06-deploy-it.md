# Task 0017 — Deploy Doc Agent on Cron Schedule (CampClaw Step 06)

> **Project:** AI Workforce Lab — Agent Operations  
> **Owner:** Human (`matt@appyhourlabs.com`) setup; AI (`doc@appyhourlabs.com`) operation  
> **Priority:** P1  
> **Status:** ✅ Done  
> **CampClaw Step:** 06 — Deploy It  
> **Depends on:** Task 0016 (Doc Agent has GitHub tool wired)

---

## Goal

Get the Documentary Agent running **autonomously on a daily schedule** using OpenClaw's cron system. Instead of only responding when manually prompted in `#ai-office`, the agent wakes up every morning, scans the repo for new activity, drafts episode content if warranted, and posts a status summary to Slack.

This is the final step before the **"First Agent Deployed"** milestone.

---

## Steps

### 1 — Add Cron Job via `openclaw cron add`

Create a daily cron job targeting the `doc` agent:
- **Schedule:** Daily at 04:00 AM Eastern (`0 4 * * * America/New_York`)
- **Message:** Fast daily check-in — scan for changes, draft if warranted, return 2-3 sentence summary
- **Delivery:** Announce summary to Slack `#ai-office` — use channel ID `C0AFXJR71V5` (not display name)
- **Session:** Isolated (each run starts clean)
- **Timeout:** 900 seconds (increased from default after model-inference timeout)

### 2 — Update Agent System Prompt (SOUL.md)

Add a `## Scheduled Check-In` section documenting:
- The daily autonomous schedule and its purpose
- What the agent should do during a scheduled vs. manual session
- Reminder that all safety constraints still apply

### 3 — Update HEARTBEAT.md

Add a reference entry so the agent is aware of its own schedule:
- Job name, cron expression, purpose

### 4 — Test: Manual Cron Trigger

Force-run the job via `openclaw cron run` to verify end-to-end behavior without waiting for the schedule.

### 5 — Verify Slack Output

Confirm the agent's summary appears in `#ai-office` and references real repo state.

### 6 — Update CAMPCLAW.md

Mark Step 06 as complete. Add Step 06 section with task link.

---

## Dependencies

- Task 0016 ✅ — Doc Agent has GitHub tool wired
- OpenClaw cron scheduler ✅ — enabled, 0 jobs currently
- Slack `#ai-office` channel ✅ — bound to doc agent

---

## Definition of Done

- [x] Cron job `doc-daily-checkin` added and visible in `openclaw cron list`
- [x] `SOUL.md` updated with scheduled check-in instructions
- [x] `HEARTBEAT.md` updated with schedule reference
- [x] Manual test run produces agent response (24.7s run, 2026-02-22)
- [x] Slack `#ai-office` receives daily check-in summary
- [x] `CAMPCLAW.md` updated to reflect Step 06 completion
- [x] No unauthorized agent actions observed during test

---

## Risk Notes

- **Agent still cannot merge its own PRs.** Drafts require `matt@appyhourlabs.com` approval.
- **Isolated sessions** prevent context leak between daily runs.
- **Timeout of 900s** limits runaway execution. Original 120s was too short; model inference alone can take minutes on complex prompts.
- **If OpenClaw is not running** (e.g., machine restarted), the cron job will not fire. Monitoring is deferred to Step 11.

---

## Lessons Learned (2026-02-22)

Three stacked issues prevented the first autonomous morning run from delivering to Slack:

### 1. Delivery target missing

The `openclaw cron add` command created jobs with `"delivery": {"mode": "announce", "channel": "slack"}` but **no `"to"` field**. OpenClaw requires an explicit destination.

**Fix:** `openclaw cron edit <job-id> --announce --channel slack --to "C0AFXJR71V5"` on all 4 jobs. Note: must use channel ID, not `#ai-office` (display names fail silently).

### 2. Device pairing required

After fixing delivery targets, OpenClaw's internal subagent WebSocket connection failed with `gateway closed (1008): pairing required`. The cron subsystem connects back to the gateway as a new device that needs authorization.

**Fix:** `openclaw devices list` → `openclaw devices approve <request-id>` for the pending device.

### 3. Doc agent model-inference timeout

The doc agent read multiple task files, then the LLM spent 17 minutes generating a response (likely composing a full episode inline). The embedded run timed out at 600s.

**Fix:** Rewrote the cron prompt to instruct the agent to keep it fast, use the `write` tool for file content instead of composing inline, and return only a 2-3 sentence summary. Run time dropped from 17 min → 24.7 seconds. Timeout increased to 900s as safety net.

### Diagnostic commands

See `RUNBOOKS/cron-troubleshooting.md` for the full troubleshooting playbook.

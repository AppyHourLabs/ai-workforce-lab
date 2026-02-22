# Task 0017 — Deploy Doc Agent on Cron Schedule (CampClaw Step 06)

> **Project:** AI Workforce Lab — Agent Operations  
> **Owner:** Human (`matt@appyhourlabs.com`) setup; AI (`doc@appyhourlabs.com`) operation  
> **Priority:** P1  
> **Status:** In Progress  
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
- **Schedule:** Daily at 09:00 AM Eastern
- **Message:** Instruct the agent to scan `TASKS/` and `PROJECTS/`, draft episodes if needed, and post a summary
- **Delivery:** Announce summary to Slack `#ai-office`
- **Session:** Isolated (each run starts clean)
- **Timeout:** 120 seconds

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

- [ ] Cron job `doc-daily-checkin` added and visible in `openclaw cron list`
- [ ] `SOUL.md` updated with scheduled check-in instructions
- [ ] `HEARTBEAT.md` updated with schedule reference
- [ ] Manual test run produces agent response
- [ ] Slack `#ai-office` receives daily check-in summary
- [ ] `CAMPCLAW.md` updated to reflect Step 06 completion
- [ ] No unauthorized agent actions observed during test

---

## Risk Notes

- **Agent still cannot merge its own PRs.** Drafts require `matt@appyhourlabs.com` approval.
- **Isolated sessions** prevent context leak between daily runs.
- **Timeout of 120s** limits runaway execution.
- **If OpenClaw is not running** (e.g., machine restarted), the cron job will not fire. Monitoring is deferred to Step 11.

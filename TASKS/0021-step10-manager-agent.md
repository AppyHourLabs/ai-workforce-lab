# TASK 0021 — Step 10: The Manager

**CampClaw Step:** 10 — The Manager
**Status:** ✅ Complete
**Date:** 2026-02-22

## Goal

Create an orchestrator agent that handles multi-agent routing. The manager receives high-level requests and delegates to the right specialist agent instead of relying solely on Slack channel bindings.

## What Was Done

### Manager Agent
- Registered `manager` agent in OpenClaw
- Identity: 🎯 Manager Agent — "Orchestrator — part traffic controller, part project manager, zero micromanagement"
- Workspace: `~/.openclaw/workspaces/manager/`
- Bound to `#ai-office` Slack channel

### Workspace Files
- `SOUL.md` — delegation rules, routing table, morning briefing protocol, safety constraints
- `TOOLS.md` — `openclaw agent` CLI delegation docs + fleet roster (updated when agents are added)
- `IDENTITY.md`, `USER.md`, `AGENTS.md` — standard workspace files
- `memory/` — local session memory directory

### Cron Job
- `manager-daily-briefing` at 03:45 ET (15 min before doc agent)
- Reads shared brain, posts fleet status and pipeline plan to `#ai-office`

### Delegation
- Manager delegates via `openclaw agent --agent <id> --message "<task>"`
- Routing table maps task types to specialist agents
- Fleet roster in TOOLS.md is updated when new agents are added

## Morning Pipeline (updated)

| Time | Agent | Job |
|------|-------|-----|
| 03:45 ET | 🎯 Manager | Morning briefing — fleet status + pipeline plan |
| 04:00 ET | 🎬 Doc | Daily check-in — scan repo, draft episodes |
| 04:30 ET | 🔍 QA | Quality gates — eval doc-agent PRs |
| 05:00 ET | ✍️ Content | Content drafts — social/blog from merged episodes |
| 05:30 ET | 🛡️ Security | Security scan — check PRs for violations |

## Verification

```bash
# Check manager agent
openclaw agents list

# Check cron job
openclaw cron list

# Check binding
grep -A8 manager ~/.openclaw/openclaw.json | head -20
```

## Artifact

CampClaw artifact: An orchestrator agent that routes tasks to specialist agents. ✅

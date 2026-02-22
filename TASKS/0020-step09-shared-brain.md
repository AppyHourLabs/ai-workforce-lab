# TASK 0020 — Step 09: The Shared Brain

**CampClaw Step:** 09 — The Shared Brain
**Status:** ✅ Complete
**Date:** 2026-02-22

## Goal

Wire a common memory layer so agents share context across sessions. Currently each agent wakes fresh with no memory. After this step, agents read/write to a shared knowledge store so the morning pipeline carries context downstream (doc → QA → content → security).

## What Was Done

### Shared Brain Directory
- Created `~/.openclaw/workspaces/shared/brain/` as the shared memory layer
- `BRAIN.md` — protocol doc defining how agents use the brain
- `fleet-status.md` — fleet roster and activity log
- `handoffs/` — agent-to-agent handoff notes:
  - `doc-to-qa.md` — doc agent leaves notes for QA
  - `qa-to-content.md` — QA leaves notes for content
  - `security-findings.md` — security agent findings
- `decisions/` — cross-agent decisions and learnings

### OpenClaw Config
- Added `memorySearch.extraPaths` pointing all agents to the shared brain
- All agents' memory search now indexes shared brain files

### Per-Agent Memory
- Created `memory/` directories for doc, QA, content, and security agents
- Session memory hook was already enabled

### SOUL File Updates
- All 4 agent SOUL files updated with "Shared Brain" section
- Each agent knows what to read and what to write after their run
- Standardized handoff format with agent ID, date, and structured fields

### Cron Job Updates
- All 4 cron job messages updated to include shared brain read/write steps
- Pipeline now flows context: doc writes → QA reads/writes → content reads → security reads/writes

## Verification

```bash
# Check shared brain exists
ls -la ~/.openclaw/workspaces/shared/brain/
ls -la ~/.openclaw/workspaces/shared/brain/handoffs/

# Check memory dirs exist
ls -d ~/.openclaw/workspaces/*/memory/

# Check config
grep -A3 memorySearch ~/.openclaw/openclaw.json

# Index and verify
openclaw memory index --force
openclaw memory status
```

## Artifact

CampClaw artifact: Multiple agents accessing a single, persistent memory store. ✅

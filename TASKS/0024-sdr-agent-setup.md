# TASK 0024 — SDR Agent Setup

**Status:** ✅ Complete
**Date:** 2026-02-22

## Goal

Onboard the SDR Agent to the AI Workforce Lab fleet for prospect research, outreach drafting, and pipeline tracking.

## What Was Done

### SDR Agent
- Registered `sdr` agent in OpenClaw
- Identity: 📞 SDR Agent — "Prospector — part researcher, part copywriter, zero send buttons"
- Workspace: `~/.openclaw/workspaces/sdr/`
- Model: `openai/gpt-5.1-codex`
- Account: `sales@appyhourlabs.com`

### Workspace Files
- `SOUL.md` — prospect research, outreach drafting, Phase A email rules, safety constraints, shared brain section
- `TOOLS.md` — `gh` CLI (branch prefix `sdr/`, file scope `TASKS/outbound/`)
- `IDENTITY.md`, `USER.md`, `AGENTS.md` — standard workspace files
- `memory/` — local session memory directory

### Cron Job
- `sdr-daily-outreach-check` at 07:00 ET daily
- Delivers to `#ai-office` via cron (no channel binding)
- Reads shared brain, reviews pipeline/prospects, posts status

### Safety
- Cannot send email autonomously — all drafts require human approval
- Cannot represent the company in binding commitments
- All output goes to `TASKS/outbound/` as drafts
- Phase A: draft → human review → human sends manually

## Verification

```bash
openclaw agents list        # sdr appears
openclaw cron list          # sdr-daily-outreach-check at 07:00
ls ~/.openclaw/workspaces/sdr/  # All workspace files present
```

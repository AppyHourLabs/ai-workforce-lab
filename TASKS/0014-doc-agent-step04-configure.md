# Task 0014 — Configure Doc Agent in OpenClaw (CampClaw Step 04)

> **Project:** AI Workforce Lab — Agent Operations  
> **Owner:** Human (`matt@appyhourlabs.com`) setup; AI (`doc@appyhourlabs.com`) operation  
> **Priority:** P1  
> **Status:** ✅ Done  
> **CampClaw Step:** 04 — The Build  
> **Depends on:** Task 0013 (OpenClaw installed and connected to Slack)

---

## Goal

Configure the Documentary Agent (`doc@appyhourlabs.com`) as the first live agent in OpenClaw. This agent reads project updates from the repo and drafts public-friendly episode logs. Starting with `doc` gives the lowest-risk first deployment — it only reads files and outputs drafts for human review.

---

## Why Doc Agent First

- **Lowest blast radius:** reads files, writes drafts — no external API calls, no emails sent
- **Immediately valuable:** documents the OpenClaw setup itself as it happens
- **Self-referential loop:** the first thing the agent documents is its own creation
- **Tests the full Step 04–05 pipeline** without touching live external systems

---

## Steps

### 1 — Configure Agent Identity in OpenClaw

In the OpenClaw dashboard (`openclaw dashboard`), create a new agent:

- **Name:** `Documentary Agent`
- **Identity / Account:** `doc@appyhourlabs.com`
- **Channel:** Slack → `#ai-office`

---

### 2 — Set the System Prompt

Use the contents of [`AGENTS/documentary-agent.md`](../AGENTS/documentary-agent.md) as the system prompt. Paste the full file contents into OpenClaw's system prompt / behavior instructions field.

Key sections to include:
- Mission
- Inputs (project files, policies, runbooks)
- Responsibilities
- Safety constraints (no secrets, no unapproved publishing)
- Output style

---

### 3 — Configure File Access

Grant the agent read access to these repo paths:
- `PROJECTS/` — for project status updates
- `TASKS/` — for task completion context
- `POLICIES/` — for safety boundaries
- `RUNBOOKS/session-handoff.md` — for operational context
- `DOCS/SHOW/episodes/` — for episode drafts output

Write access:
- `DOCS/SHOW/episodes/` — drafts only; never directly to `main`

---

### 4 — First Task: Draft Episode 002

Trigger the agent with this prompt in `#ai-office`:

> "Draft Episode 002: 'The First Agent Goes Live'. Cover: OpenClaw install on the Mac Mini, the decision to start with the Documentary Agent, and what Phase A gated operation means in practice. Follow the episode template. Flag anything uncertain for human review."

---

### 5 — Review and Merge

1. Agent posts draft to `#ai-office` or creates file in `DOCS/SHOW/episodes/002-*.md`
2. Run through [`EVALS/outbound-quality-gate.md`](../EVALS/outbound-quality-gate.md)
3. Run through [`EVALS/brand-voice-gate.md`](../EVALS/brand-voice-gate.md)
4. Submit PR; `matt@appyhourlabs.com` approves and merges

---

## Owner (Human vs AI)

- **OpenClaw configuration:** Human (`matt@appyhourlabs.com`)
- **Episode drafting:** AI (`doc@appyhourlabs.com`)
- **Quality gates + merge:** Human (`matt@appyhourlabs.com`)

---

## Dependencies

- Task 0013 ✅ required — OpenClaw installed and connected to Slack
- [`AGENTS/documentary-agent.md`](../AGENTS/documentary-agent.md) — system prompt source
- [`DOCS/SHOW/episodes/_TEMPLATE.md`](../DOCS/SHOW/episodes/_TEMPLATE.md) — episode structure

---

## Definition of Done

- [x] Documentary Agent configured in OpenClaw with correct system prompt
- [x] File access paths configured (read: PROJECTS, TASKS, POLICIES; write: DOCS/SHOW/episodes)
- [x] First prompt issued in `#ai-office`
- [x] Episode 002 draft produced by agent
- [x] Both quality gates passed (outbound: 15/16, voice: 10/10)
- [x] PR reviewed and merged by `matt@appyhourlabs.com` (PR #8, 2026-02-21)

---

## Risk Notes

- **Agent must not publish directly** — all output goes to `DOCS/SHOW/episodes/` as drafts and requires human PR approval before merge.
- **System prompt is the contract.** If the agent drifts from the safety constraints, update `AGENTS/documentary-agent.md` and re-paste into OpenClaw.
- **No credentials in drafts.** The safety constraint in the agent definition is enforced at the system prompt level — review every draft for accidental info leakage before merging.

---

## Lessons Learned

- **Routing binding required.** Creating an agent in OpenClaw (`openclaw agents add`) does not automatically route messages to it. A `bindings` entry in `openclaw.json` is required — without it, all messages go to the default `main` agent. Discovered during Step 05 (Task 0016). See [`RUNBOOKS/new-agent-slack-setup.md`](../RUNBOOKS/new-agent-slack-setup.md) for the full setup checklist.

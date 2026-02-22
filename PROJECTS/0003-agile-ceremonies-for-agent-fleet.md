# Project 0003 — Agile Ceremonies for an Agent Fleet

> **Status:** Complete | **Owner:** `matt@appyhourlabs.com` | **Priority:** P1

---

## Objective

Translate standard agile ceremonies into a format that a 10-agent, async cron pipeline can actually execute. Define runbooks for standups, backlog refinement, sprint planning, and retrospectives — keeping them token-efficient, escalation-aware, and grounded in Phase A safety constraints.

The harder-than-expected insight: most agile ceremony problems are naming problems. "Sprint planning" in an agent context means something different than it does in a human team. This project documents those differences explicitly.

---

## Success Criteria

- Standup schema defined; every agent can write a conformant block to `fleet-status.md`
- Manager Agent reads all standup blocks and posts a structured briefing to `#ai-office`
- Backlog refinement runbook covers ticket triage, prioritization, and the "needs human" gate
- Sprint planning runbook maps to the 03:45–08:00 ET cron window
- Retrospective runbook can be run without a synchronous human facilitator
- All runbooks are cross-linked and reference the correct SOUL.md, POLICIES, and SCHEMAS

---

## Deliverables

| Runbook | File | Status |
|---|---|---|
| Daily Standup | [`RUNBOOKS/standup.md`](../RUNBOOKS/standup.md) | ✅ Done |
| Backlog Refinement | [`RUNBOOKS/backlog-refinement.md`](../RUNBOOKS/backlog-refinement.md) | ✅ Done |
| Backlog Process | [`RUNBOOKS/backlog-process.md`](../RUNBOOKS/backlog-process.md) | ✅ Done |
| Sprint Planning | [`RUNBOOKS/sprint-planning.md`](../RUNBOOKS/sprint-planning.md) | ✅ Done |
| Retrospective | [`RUNBOOKS/retro.md`](../RUNBOOKS/retro.md) | ✅ Done |

---

## Key Decisions

### Standups are writes, not meetings
There is no synchronous standup call. Each agent appends a structured block to `fleet-status.md` at the start of its cron run. The Manager reads all blocks at 03:45 ET and broadcasts a summary. This keeps the ceremony token-efficient and fully async.

### Sprint = one cron window
A "sprint" maps to the 03:45–08:00 ET pipeline window, not a two-week calendar cycle. Sprint planning means: Manager ingests TASKS backlog, assigns work to agents within Phase A constraints, and writes the day's plan before agents wake.

### Retrospectives are written, not spoken
The retro runbook outputs a structured markdown file. Human review is gated — Matt signs off before retro output influences the next sprint's scope. No autonomous course-correction without a human in the loop.

### The "no sleeping product owner" problem
Classic sprint planning assumes a product owner who can answer questions in real time. In this setup, ambiguous tickets must be flagged `needs-human` and parked — not resolved autonomously. This is documented as an explicit gate in the sprint planning runbook.

---

## Completion Definition

- All five runbooks merged to `main`
- Manager Agent can execute a full standup cycle end-to-end without errors
- One retro cycle completed and human-reviewed
- `matt@appyhourlabs.com` has signed off via PR review

---

## Notes

*"Teaching AI agents to do a daily standup is mostly a naming problem."* The deeper issue is that agile language was designed for humans with shared context, memory, and the ability to interrupt each other. Agents have none of those things. These runbooks trade real-time coordination for durable, parseable artifacts.

*Related: [`RUNBOOKS/standup.md`](../RUNBOOKS/standup.md) · [`RUNBOOKS/sprint-planning.md`](../RUNBOOKS/sprint-planning.md) · [`POLICIES/ai-safety-charter.md`](../POLICIES/ai-safety-charter.md) · [`AGENTS/manager-agent.md`](../AGENTS/manager-agent.md)*

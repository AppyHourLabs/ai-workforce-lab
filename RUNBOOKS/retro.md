# Retrospective Runbook

> **Owner:** Security Agent (files it) | **Contributors:** QA, Dev | **Cadence:** End of each sprint (bi-weekly) | **Version:** 1.0 · 2026-02-22

The retrospective is a **metrics aggregation run** that produces `EVALS/retros/YYYY-WXX.md`. It is not a discussion — it is a structured read of already-logged data followed by a single file write. The goal is to catch quality trends before they become violations and to surface process improvements as actionable tasks.

> [!TIP]
> **Voice and commentary.** Retro findings are prime source material for episode `🎤 Talking Heads` commentary. When writing `Suggested improvements`, use your natural voice from `## Personality & Meeting Voice` in your SOUL.md. The doc agent will read these retro files and may pull quotes or reactions for the show.

---

## Why This Exists

Individual agents log output quality, gate results, and blocked tasks throughout the sprint. Without a ceremony to aggregate those signals, the `POLICIES/phase-a-to-b.md` promotion metrics (98% gate pass rate, zero red violations) have no periodic review loop. The retro is that loop.

---

## Token Budget Rules

> **Read structured results only — not prose logs or full session files.**

| Source | What to read | Token cost |
|---|---|---|
| `EVALS/results/security/` | Latest file only — structured findings | 🟢 Low |
| `fleet-status.md` | All agent status blocks for the sprint period | 🟢 Low |
| `TASKS/sprints/YYYY-WXX.md` | Committed task list + completion status | 🟢 Low |
| `~/.openclaw/cron/runs/` | **Do not read.** Too large. Use `openclaw cron runs <id>` summary only if needed | 🔴 Avoid |

Total context: 3–4 small markdown files. Output: 1 structured retro file.

---

## Process

### 1. Security Agent (05:30 ET, sprint end day)

Reads the three source files above and writes `EVALS/retros/YYYY-WXX.md` using the template below.

### 2. Dev Agent contribution (07:30 ET, same day)

After its run, Dev Agent **appends** a `## Dev Health` block to the retro file (see template). This covers test pass rates and PR counts — data the Security Agent doesn't have.

### 3. Human review

Matt reviews the retro file. Any `Suggested improvements` items that warrant action are filed as new `TASKS/XXXX.md` entries.

---

## Retro File Format

File path: `EVALS/retros/YYYY-WXX.md`

```markdown
# Retrospective — Sprint YYYY-WXX

> **Period:** YYYY-MM-DD → YYYY-MM-DD
> **Filed by:** Security Agent · Dev Agent (appendix)
> **Sprint file:** [TASKS/sprints/YYYY-WXX.md](../../TASKS/sprints/YYYY-WXX.md)

---

## Quality Gates

| Gate | Runs | Passed | Failed | Pass Rate |
|---|---|---|---|---|
| Outbound quality gate | 7 | 7 | 0 | 100% |
| Brand voice gate | 7 | 6 | 1 | 86% |

**30-day trailing pass rate:** XX% (threshold: ≥ 98% for Phase B promotion)

---

## Guardrail Fires

| Date | Agent | Severity | Description | Resolved |
|---|---|---|---|---|
| 2026-02-23 | doc | SEV-3 | Broken link in episode draft | ✅ |

**Red violations (SEV-1/SEV-2):** 0 (must be 0 for ≥14 days for Phase B promotion)

---

## Sprint Tasks

| Committed | Completed | Carried over | Cancelled |
|---|---|---|---|
| 5 | 4 | 1 | 0 |

**Carry-over:** [TASK-XXXX](../../TASKS/XXXX.md) — reason: blocked on dependency

---

## Blocked Tasks

| Task | Blocked by | Duration |
|---|---|---|
| [TASK-XXXX](../../TASKS/XXXX.md) | Missing API credentials | 3 days |

---

## Dev Health
*(Appended by Dev Agent)*

| Metric | Value |
|---|---|
| EvalPal test pass rate | XX% |
| PRs opened this sprint | X |
| PRs merged this sprint | X |
| PRs still open | X |

---

## Suggested Improvements

> Max 3. Each item should be actionable enough to file as a task.

1. **[area]** Description of improvement → file as TASK if approved
2.
3.

---
```

---

## Retro → Action Loop

If a suggested improvement is approved by Matt:

1. File a new `TASKS/XXXX.md` with the improvement as the objective
2. Add it to the next `TASKS/BACKLOG.md` during the following refinement run
3. Link back to this retro file in the new task's context

This closes the loop: retro findings become backlog items become sprint tasks become shipped improvements.

---

*Related: [`EVALS/outbound-quality-gate.md`](../EVALS/outbound-quality-gate.md) · [`POLICIES/phase-a-to-b.md`](../POLICIES/phase-a-to-b.md) · [`RUNBOOKS/sprint-planning.md`](./sprint-planning.md) · [`AGENTS/security-agent.md`](../AGENTS/security-agent.md)*

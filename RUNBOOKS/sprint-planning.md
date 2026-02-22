# Sprint Planning Runbook

> **Owner:** Product Agent (drafts) + CTO Agent (validates) | **Cadence:** Bi-weekly (every other Monday) | **Version:** 1.0 · 2026-02-22

Sprint planning converts the prioritized backlog into a committed sprint artifact: `TASKS/sprints/YYYY-WXX.md`. It is a two-step agent handoff — Product proposes, CTO validates feasibility — then Matt approves before the sprint begins.

---

## Why This Exists

Tasks exist in `TASKS/`. Priorities exist in `TASKS/BACKLOG.md`. Sprint planning converts those into a **commitment** — a specific set of tasks with clear ownership and acceptance criteria for the next two weeks. Without it, agents have no shared definition of "the sprint goal" and may work on different things each day.

---

## Cadence and Timing

| Step | When | Who |
|---|---|---|
| Read `BACKLOG.md` | Monday 08:00 ET | Product Agent (end of its daily run) |
| Validate technical feasibility | Monday 06:30 ET* | CTO Agent reads draft from shared brain |
| Human approval | Monday morning | Matt reviews PR, merges to activate sprint |

*CTO runs at 06:30; Product runs at 08:00. On planning Mondays, Product reads CTO's feasibility notes from the shared brain handoff.*

---

## Token Budget Rules

- **Read `TASKS/BACKLOG.md` only** — not individual task files. The backlog is already distilled.
- **Read previous sprint file** for carry-over context (`TASKS/sprints/` → most recent file).
- Total context loaded: 2 small files. Sprint output: 1 small table. Cost is minimal.

---

## Sprint Commitment Format

File path: `TASKS/sprints/YYYY-WXX.md`

```markdown
# Sprint YYYY-WXX

> **Start:** YYYY-MM-DD | **End:** YYYY-MM-DD
> **Sprint goal:** <one sentence — what does success look like for this sprint?>
> **Status:** `planning` | `active` | `complete`

## Committed Tasks

| Task | Owner | Acceptance Criteria | Priority |
|---|---|---|---|
| [TASK-XXXX](../XXXX.md) | dev | Tests pass, PR merged | P0 |
| [TASK-XXXX](../XXXX.md) | product | Draft approved by matt | P1 |

## Carry-over from Previous Sprint

| Task | Reason not completed |
|---|---|
| [TASK-XXXX](../XXXX.md) | Blocked on dependency |

## Out of Scope (Deferred)

- Noted items explicitly excluded from this sprint with reason.

## CTO Feasibility Notes

> <CTO Agent's technical sequencing notes — any ordering constraints, dependencies, or blockers>
```

---

## Definition of Done for a Sprint

A task is "done" when:
1. Its `TASKS/XXXX.md` status is updated to `complete`
2. Any output artifacts (PRs, docs, evals) are linked in the task file
3. The sprint file's task row is updated with a completion note

The sprint itself closes when all committed tasks reach `complete` or are explicitly moved to carry-over with a documented reason.

---

## Sprint Review

At sprint end, the Documentary Agent's weekly episode serves as the sprint review artifact — it should reference the sprint file and link to completed tasks. See [`DOCS/SHOW/episodes/_TEMPLATE.md`](../DOCS/SHOW/episodes/_TEMPLATE.md).

---

*Related: [`RUNBOOKS/backlog-refinement.md`](./backlog-refinement.md) · [`RUNBOOKS/retro.md`](./retro.md) · [`AGENTS/product-agent.md`](../AGENTS/product-agent.md) · [`AGENTS/cto-agent.md`](../AGENTS/cto-agent.md)*

# Runbook: Backlog Process

> **Owner:** Program Manager (Founder delegates) · **Applies to:** All agents and human contributors
> **Effective:** 2026-02-22 · **Review cadence:** Monthly

This runbook defines how tasks enter, move through, and exit the backlog in the AI Workforce Lab. It enforces atomic task sizing, measurable outcomes, and autonomy gating aligned with Phase A constraints.

---

## 1. Task Lifecycle

```
PROPOSED → GROOMED → READY → IN-PROGRESS → IN-REVIEW → DONE
                                                      ↘ BLOCKED
```

| Stage | Definition | Who Acts |
|---|---|---|
| **PROPOSED** | Task idea captured; not yet sized or assigned | Any agent or human |
| **GROOMED** | Context, steps, DoD, owner, dependencies filled in | Program Manager |
| **READY** | All dependencies met; safe to start; no blocking risks | Program Manager |
| **IN-PROGRESS** | Agent actively working; session handoff populated | Owner agent |
| **IN-REVIEW** | PR or artifact submitted; awaiting eval gate + human approval | QA / Security / Founder |
| **DONE** | DoD verified, PR merged, task marked `complete` | Program Manager |
| **BLOCKED** | Dependency unmet or risk escalation triggered | Owner agent flags |

---

## 2. Task File Format

Every task lives as `TASKS/00XX-<short-name>.md`. The following fields are **required** before a task can move to READY:

```markdown
# TASK 00XX — <Title>

> **Status:** proposed | groomed | ready | in-progress | in-review | complete | blocked
> **Owner:** <role>
> **Priority:** P0 | P1 | P2
> **Created:** YYYY-MM-DD
> **Estimated effort:** 30–90 minutes

## Goal
One sentence.

## Context
Why this matters for EvalPal readiness or Phase A → B promotion.

## Steps
Numbered, atomic steps an agent can execute without ambiguity.

## Dependencies
Links to other tasks or external prerequisites.

## Definition of Done (Measurable)
Bullet list. Every item must be verifiable by a third party without asking the author.

## Risk Notes
What could go wrong; what the agent must NOT do.

## Links
Cross-references to relevant POLICIES/, EVALS/, PROJECTS/, RUNBOOKS/.
```

---

## 3. Prioritization Rules

| Priority | Trigger | Examples |
|---|---|---|
| **P0** | Prevents data loss, security incident, runaway cost, broken auth/RLS, broken CI, or unlogged actions | RLS verification, inject tests, CI fix, secrets scanning |
| **P1** | Reliability or UX blocker for first customers | Onboarding flow, eval run stability, cost report accuracy |
| **P2** | Growth enablement, public-facing polish — **only after all P0/P1 are DONE or BLOCKED** | Brand assets, marketing experiments, SDR sequences |

**Hard rule:** No P2 task may enter IN-PROGRESS while any P0 task is in PROPOSED, GROOMED, or BLOCKED.

---

## 4. Task Sizing

All tasks must fit within **30–90 minutes** of agent execution time. If a task cannot be completed in one session:

1. Break it into numbered subtasks: `00XX-a`, `00XX-b`, etc.
2. Update the parent task to reference subtasks.
3. Each subtask must have its own DoD.

Tasks estimated over 90 minutes are rejected from GROOMED and returned to the author with a split request.

---

## 5. Autonomy Gating

The following task types **always require human approval before execution**, regardless of phase:

| Blocked Action | Gating Requirement |
|---|---|
| Any Stripe configuration change | `matt@appyhourlabs.com` written approval |
| Domain-wide delegation of OAuth scopes | `matt@appyhourlabs.com` written approval |
| Sending external email (not draft) | Phase B promotion + posting policy gate |
| Committing credentials or tokens | **Never permitted** — hard block |
| Modifying POLICIES/ files | PR review by Founder |
| Deleting production data | Not permitted in Phase A |
| Changing eval gate pass thresholds | PR review by QA + Founder |

All other tasks may be executed autonomously by the assigned agent within Phase A constraints. Any agent that encounters an ambiguous gating scenario must consult `RUNBOOKS/human-escalation.md`.

---

## 6. Review and Merge Criteria

A task PR must satisfy all of the following before merge:

- [ ] All automated CI checks pass (see `RUNBOOKS/ci.md`)
- [ ] Outbound Quality Gate passes if content is external-facing
- [ ] Brand Voice Gate passes if content is external-facing
- [ ] At least one human approval from `matt@appyhourlabs.com` if the task touches POLICIES/, EVALS/ thresholds, or any gated action
- [ ] No secrets, tokens, or credentials in any committed file
- [ ] Task status updated to `in-review` in the task file before PR is opened
- [ ] Session handoff updated (see `RUNBOOKS/session-handoff.md`)

---

## 7. Backlog Hygiene

**Weekly (during backlog refinement ceremony):**
- Remove or archive tasks idle in PROPOSED > 2 weeks with no activity
- Re-evaluate priority of all GROOMED tasks against current sprint focus
- Update `TASKS/_PRIORITY_BACKLOG.md` to reflect any rank changes
- Confirm dependency chains are still valid

**Monthly:**
- Full audit: any task in IN-PROGRESS > 30 days is escalated to Founder
- Review and update estimated effort for all READY tasks
- Archive DONE tasks older than 60 days from the priority backlog

---

## 8. Backlog Ownership

| Role | Responsibility |
|---|---|
| **Founder** | Final prioritization authority; approves P0 task creation |
| **Program Manager** | Day-to-day backlog hygiene, grooming, and dependency resolution |
| **QA Agent** | Validates DoD measurability before tasks move to READY |
| **Security Agent** | Reviews risk notes on any security-tagged task |
| **Dev Agent** | Provides effort estimates; flags hidden dependencies |

---

*Cross-links: [TASKS/_PRIORITY_BACKLOG.md](../TASKS/_PRIORITY_BACKLOG.md) · [POLICIES/phase-a-to-b.md](../POLICIES/phase-a-to-b.md) · [RUNBOOKS/human-escalation.md](human-escalation.md) · [RUNBOOKS/session-handoff.md](session-handoff.md)*

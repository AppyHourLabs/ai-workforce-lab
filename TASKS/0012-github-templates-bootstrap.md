# Task 0012 — Create Phase A Daily Checklist for the Founder

> **Project:** Governance and operational safety  
> **Owner:** AI (`ai@`) draft; Human (`matt@`) review and use  
> **Priority:** P0  
> **Status:** Open

---

## Goal

Create a `RUNBOOKS/phase-a-daily-checklist.md` that gives `matt@` a structured, repeatable daily review routine during Phase A operations — so nothing slips through without a human noticing.

---

## Steps

1. Create `RUNBOOKS/phase-a-daily-checklist.md` with the following sections:

   **Morning Review (< 10 minutes)**
   - [ ] Check GitHub for any overnight PRs opened by AI agents — review scope and content
   - [ ] Check `TASKS/outbound/` for any drafts pending review (`status: draft: pending-review`)
   - [ ] Confirm no new eval gate failures in `EVALS/results/` since last check
   - [ ] Scan local logs (`~/ai-office-logs/`) for any anomalous entries
   - [ ] Check Workspace Admin for unexpected login activity on AI ops accounts

   **Before Approving Any Agent PR**
   - [ ] PR description includes a "Security Considerations" section
   - [ ] No secrets or PII in the diff (CI scan passed)
   - [ ] Relevant quality gates passed (results linked)
   - [ ] Scope matches the assigned task
   - [ ] Any autonomy risk is documented and mitigated

   **Before Approving Any Outbound Communication**
   - [ ] Both quality gate and brand voice gate: `gate: PASS`
   - [ ] Publish preflight checklist completed by `doc@` (ref: `RUNBOOKS/publish-preflight.md`)
   - [ ] Content reviewed by `matt@` personally — do not delegate

   **Weekly (Friday)**
   - [ ] Review Phase A → Phase B counter (ref: [`POLICIES/phase-a-to-b.md`](../POLICIES/phase-a-to-b.md))
   - [ ] Review any open incidents in `INCIDENTS/`
   - [ ] Confirm episode draft is in progress or filed for the week
   - [ ] Check that `RUNBOOKS/session-handoff.md` is current

   **Red Flags — Stop Everything and Escalate**
   - Any agent action outside documented task scope
   - Any external communication sent without your approval
   - Any credential or token appearing in any log, PR, or task file
   - Any request to enable domain-wide delegation

2. Submit via PR for `matt@` review

---

## Owner (Human vs AI)

- **Draft:** AI (`ai@`)
- **Review, merge, and daily use:** Human (`matt@`)

---

## Dependencies

- [`POLICIES/phase-a-to-b.md`](../POLICIES/phase-a-to-b.md)
- [`POLICIES/escalation-policy.md`](../POLICIES/escalation-policy.md)
- Task 0009 complete (`RUNBOOKS/publish-preflight.md` exists)

---

## Definition of Done

- [ ] `RUNBOOKS/phase-a-daily-checklist.md` created with all sections
- [ ] Checklist reviewed and approved by `matt@`
- [ ] `matt@` has incorporated the morning review into daily routine (soft requirement — no automated verification, but document in handoff notes)

---

## Risk Notes

- **A checklist only works if it's actually used.** Keep it short enough to complete in under 10 minutes; any longer and it won't happen.
- **Don't automate the checklist.** The point is human eyes on agent behavior. An automated check that "passed" the checklist defeats the purpose of Phase A.
- If the checklist items are consistently taking over 10 minutes, that's a signal the agent scope is too broad for Phase A.

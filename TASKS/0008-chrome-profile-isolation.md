# Task 0008 — Create Incident Report Template and Add to RUNBOOKS/

> **Project:** Governance and runbook infrastructure  
> **Owner:** AI (`ai@appyhourlabs.com`) draft; Human (`matt@appyhourlabs.com`) review  
> **Priority:** P1  
> **Status:** Open

---

## Goal

Create a standard incident report template so that any agent or human can file a consistent, complete incident record the moment something goes wrong — not hours later, not from memory.

---

## Steps

1. Create `RUNBOOKS/incident-report-template.md` with the following required sections:
   - **Incident ID** — format: `INC-YYYY-MM-DD-###`
   - **Severity** — SEV-1 / SEV-2 / SEV-3 (ref: [`DOCS/SHOW/episodes/_TEMPLATE.md`](../DOCS/SHOW/episodes/_TEMPLATE.md) for definitions)
   - **Date/Time Detected** — ISO 8601
   - **Detected By** — account and method (automated scan, human observation, etc.)
   - **Summary** — one sentence: what happened
   - **Timeline** — bulleted chronological log with timestamps
   - **Impact** — who/what was affected; data, accounts, or outputs involved
   - **Root Cause** — best known at time of writing (mark as "preliminary" if not yet confirmed)
   - **Actions Taken** — what was done to contain or remediate
   - **Follow-Up Tasks** — linked task files or open items
   - **Status** — `open` / `contained` / `resolved`
   - **Postmortem Link** — leave blank if not yet scheduled
2. Cross-link from [`POLICIES/escalation-policy.md`](../POLICIES/escalation-policy.md)
3. Submit via PR for `matt@appyhourlabs.com` review

---

## Owner (Human vs AI)

- **Draft:** AI (`ai@appyhourlabs.com`)
- **Review and merge:** Human (`matt@appyhourlabs.com`)

---

## Dependencies

- [`POLICIES/escalation-policy.md`](../POLICIES/escalation-policy.md) — defines when to file an incident

---

## Definition of Done

- [ ] `RUNBOOKS/incident-report-template.md` exists with all required sections
- [ ] Escalation policy updated to link to the template
- [ ] PR reviewed and merged by `matt@appyhourlabs.com`

---

## Risk Notes

- **Under-documenting an incident is worse than over-documenting it.** The template should encourage completeness, not brevity.
- **"Preliminary" root cause is fine.** Don't delay filing waiting for certainty. Update the report as more is learned.
- Incidents involving potential credential exposure must be flagged SEV-1 regardless of apparent impact scope.

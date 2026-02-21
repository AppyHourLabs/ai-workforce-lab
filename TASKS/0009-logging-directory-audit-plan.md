# Task 0009 — Create Publish Checklist for doc@appyhourlabs.com Posts (Preflight)

> **Project:** Documentary and content operations  
> **Owner:** AI (`doc@appyhourlabs.com`) draft; Human (`matt@appyhourlabs.com`) review  
> **Priority:** P1  
> **Status:** Open

---

## Goal

Create a pre-publication checklist that `doc@appyhourlabs.com` must complete before any episode or post is submitted for human review. This is the last line of automated defense before human eyes see the content.

---

## Steps

1. Create `RUNBOOKS/publish-preflight.md` with the following checklist:

   **Content Safety**
   - [ ] No credentials, API keys, or tokens present (cross-check against CI scan)
   - [ ] No PII (real names, emails, phone numbers, addresses)
   - [ ] No internal operational security details (IPs, internal URLs, system configs)
   - [ ] No embargoed topics or unannounced product details

   **Quality Gates**
   - [ ] Outbound quality gate run: result link → `EVALS/results/[slug]-quality.md`
   - [ ] Brand voice gate run: result link → `EVALS/results/[slug]-voice.md`
   - [ ] Both gates: `gate: PASS`

   **Structural Completeness**
   - [ ] All required sections from `_TEMPLATE.md` present
   - [ ] ISO dates used throughout (no "last week," "recently," etc.)
   - [ ] All cross-links tested and valid
   - [ ] Episode number and season header match the file name

   **Phase A Sign-Off**
   - [ ] Preflight checklist completed and attached to PR
   - [ ] PR opened with `doc@appyhourlabs.com` as author
   - [ ] `matt@appyhourlabs.com` tagged for review

2. Update [`POLICIES/posting-policy.md`](../POLICIES/posting-policy.md) to reference this preflight runbook
3. Submit via PR for `matt@appyhourlabs.com` review

---

## Owner (Human vs AI)

- **Draft:** AI (`doc@appyhourlabs.com`)
- **Review and merge:** Human (`matt@appyhourlabs.com`)

---

## Dependencies

- [`EVALS/outbound-quality-gate.md`](../EVALS/outbound-quality-gate.md)
- [`EVALS/brand-voice-gate.md`](../EVALS/brand-voice-gate.md)
- [`POLICIES/posting-policy.md`](../POLICIES/posting-policy.md)

---

## Definition of Done

- [ ] `RUNBOOKS/publish-preflight.md` created with all checklist sections
- [ ] Posting policy updated to reference preflight runbook
- [ ] PR reviewed and merged by `matt@appyhourlabs.com`

---

## Risk Notes

- **The preflight checklist is not a substitute for the quality gates** — it confirms the gates were run. Both are required.
- Incomplete checklists submitted for review should be returned to draft; `matt@appyhourlabs.com` should not approve incomplete preflight submissions.

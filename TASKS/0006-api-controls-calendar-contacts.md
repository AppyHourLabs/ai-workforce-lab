# Task 0006 — Restrict API Controls for Calendar + Contacts

## Goal
Implement scoped API restrictions for Calendar and Contacts integrations.

## Steps
1. Audit active Calendar and Contacts integrations.
2. Remove unused high-privilege scopes.
3. Verify approved automations continue to operate.
4. Capture risk exceptions for escalation if needed.
5. Update project and handoff notes.

## Owner (Human vs AI)
Human

## Dependencies
- [POLICIES/oauth-policy.md](../POLICIES/oauth-policy.md)
- [POLICIES/escalation-policy.md](../POLICIES/escalation-policy.md)
- [PROJECTS/0001-google-workspace-hardening.md](../PROJECTS/0001-google-workspace-hardening.md)

## Definition of Done
- Calendar/Contacts scopes are limited to approved set.
- Any exceptions are escalated to `matt@`.
- Verification notes are committed to project docs.

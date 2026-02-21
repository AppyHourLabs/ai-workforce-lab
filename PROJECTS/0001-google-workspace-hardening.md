# Project 0001 — Google Workspace Hardening

- **Status:** Planned
- **Owner:** matt@
- **Priority:** P0
- **Success Criteria:**
  - MFA enforced for all supported accounts.
  - OAuth app access reviewed and policy-aligned.
  - External sharing controls set to approved defaults.
  - Audit trail exists for all high-risk admin actions.
- **Tasks:**
  - Inventory accounts listed in [README](../README.md#known-accounts-and-role-boundaries).
  - Apply controls defined in [OAuth Policy](../POLICIES/oauth-policy.md).
  - Align response process with [Escalation Policy](../POLICIES/escalation-policy.md).
  - Record handoff notes using [Session Handoff Runbook](../RUNBOOKS/session-handoff.md).
- **Completion Definition:**
  - Configuration baseline documented and verified.
  - Remaining risks captured with owners and deadlines.
  - Human admin (`matt@`) signs off.

## Notes

This project sets the trust boundary for everything else. Hardening first, heroics second.

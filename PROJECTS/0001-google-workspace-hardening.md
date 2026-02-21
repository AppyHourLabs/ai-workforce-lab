# Project 0001 — Google Workspace Hardening

> **Status:** Active | **Owner:** `matt@appyhourlabs.com` | **Priority:** P0

---

## Objective

Establish a hardened, documented Google Workspace baseline for all AI Workforce Lab accounts, with access controls, audit trails, and policy alignment that can be verified and rebuilt from this documentation alone.

---

## Success Criteria

- MFA enrolled and enforced for all 4 AI ops accounts (`ai@appyhourlabs.com`, `sales@appyhourlabs.com`, `media@appyhourlabs.com`, `doc@appyhourlabs.com`)
- API App Access Control set to Restricted; approved app list documented
- No app with domain-wide delegation present in any account
- OAuth scopes for all AI accounts reviewed and within [`POLICIES/oauth-policy.md`](../POLICIES/oauth-policy.md)
- External sharing defaults set to approved baseline across Drive, Calendar, and Contacts
- Admin audit log reviewed; any anomalous events documented and resolved

---

## Tasks

| Task | File | Status |
|---|---|---|
| 2FA enrollment for all AI ops accounts | [`TASKS/0001`](../TASKS/0001-2fa-ai-account-ai.md) | Open |
| API controls: Gmail, Drive (restrict + audit) | [`TASKS/0002`](../TASKS/0002-2fa-ai-account-sales.md) | Open |
| API controls: Calendar, Contacts, reviewed apps | *(see 0002)* | Open |

---

## Completion Definition

- All success criteria above are met and verifiable via Workspace Admin
- Configuration baseline is documented in a session handoff note with ISO date
- `matt@appyhourlabs.com` has personally signed off via PR approval
- Any residual risks are captured in the Risks section below with owners and target dates

---

## Risks

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Lockout during 2FA enforcement | Medium | High | Set recovery options before enforcing; test each account after enrollment |
| Approved app list gaps | Medium | Medium | Review Connected Apps per account, not just org-level policy |
| Drift from baseline after setup | Low | Medium | Quarterly audit task to re-verify |

---

## Notes

*"Hardening first, heroics second."* This project sets the trust boundary for everything else in the lab. Nothing else is safe to run until this is complete.

*Related: [`POLICIES/oauth-policy.md`](../POLICIES/oauth-policy.md) · [`POLICIES/ai-safety-charter.md`](../POLICIES/ai-safety-charter.md) · [`AGENTS/founder.md`](../AGENTS/founder.md)*

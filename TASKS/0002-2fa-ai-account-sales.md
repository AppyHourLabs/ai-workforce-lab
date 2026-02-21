# Task 0002 — Verify API Controls: Gmail, Drive, Calendar, Contacts

> **Project:** [0001 — Google Workspace Hardening](../PROJECTS/0001-google-workspace-hardening.md)  
> **Owner:** Human (`matt@appyhourlabs.com`)  
> **Priority:** P0  
> **Status:** Open

---

## Goal

Confirm that access to Gmail, Drive, Calendar, and Contacts APIs is restricted to explicitly approved apps only. Identify and revoke any apps with broader-than-needed scopes.

---

## Steps

1. Log in to Google Workspace Admin as `matt@appyhourlabs.com`
2. Navigate to **Security → API Controls → App Access Control**
3. Set the policy to **"Restricted"** for all Google services (do not allow unconfigured third-party apps)
4. Review the list of apps currently granted access:
   - For each app, note: App name, scopes granted, accounts with access
   - Flag any app with scopes beyond what's documented as needed
5. For each AI ops account (`ai@appyhourlabs.com`, `sales@appyhourlabs.com`, `media@appyhourlabs.com`, `doc@appyhourlabs.com`):
   - Navigate to **Users → [account] → Security → Connected Apps**
   - Review and revoke any apps not on the approved list
6. Document the approved app list and current scope for each in session handoff notes
7. Cross-check against [`POLICIES/oauth-policy.md`](../POLICIES/oauth-policy.md)

---

## Owner (Human vs AI)

**Human only.** OAuth and API control changes require admin privileges. No AI agent may approve its own scope expansions.

---

## Dependencies

- Completed Task 0001 (2FA enrolled on all accounts)
- [`POLICIES/oauth-policy.md`](../POLICIES/oauth-policy.md)
- Active Workspace Admin access for `matt@appyhourlabs.com`

---

## Definition of Done

- [ ] App Access Control policy set to Restricted
- [ ] Approved app list documented and filed in session handoff
- [ ] No AI ops account has access to scopes beyond what is documented as needed
- [ ] Any revoked apps logged with reason

---

## Risk Notes

- **Revoking an app may break an active workflow.** Before revoking, check if any TASKS or PROJECTS depend on it.
- **Restricted mode blocks all new third-party app access by default.** This is the desired state, but be prepared for requests to allowlist specific tools.
- **Domain-wide delegation must remain disabled.** If found enabled for any app, revoke immediately and file a security note per [`POLICIES/escalation-policy.md`](../POLICIES/escalation-policy.md).

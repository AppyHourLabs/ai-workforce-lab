# Task 0005 — Restrict API Controls for Gmail + Drive

## Goal
Apply API access restrictions for Gmail and Drive per least-privilege policy.

## Steps
1. Review current OAuth/API app allowlist.
2. Remove or disable nonessential Gmail and Drive scopes.
3. Confirm approved integrations still function.
4. Document any blocked apps for follow-up.
5. Add summary to hardening project notes.

## Owner (Human vs AI)
Human

## Dependencies
- [POLICIES/oauth-policy.md](../POLICIES/oauth-policy.md)
- [PROJECTS/0001-google-workspace-hardening.md](../PROJECTS/0001-google-workspace-hardening.md)

## Definition of Done
- Gmail/Drive scopes are reduced to approved minimum.
- No domain-wide delegation is enabled.
- Change log entry exists with date and approver.

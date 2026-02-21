# Task 0004 — Enroll 2FA for `doc@`

## Goal
Enable and verify 2FA enrollment for `doc@` before production usage.

## Steps
1. Confirm role scope for `doc@` against account policy.
2. Launch 2FA setup and register approved factor.
3. Validate successful login with challenge.
4. Verify no policy exceptions are introduced.
5. Record completion in project updates.

## Owner (Human vs AI)
Human

## Dependencies
- [POLICIES/oauth-policy.md](../POLICIES/oauth-policy.md)
- [POLICIES/posting-policy.md](../POLICIES/posting-policy.md)
- [PROJECTS/0001-google-workspace-hardening.md](../PROJECTS/0001-google-workspace-hardening.md)

## Definition of Done
- `doc@` requires 2FA.
- Validation sign-in succeeds.
- Project file links to completion evidence.

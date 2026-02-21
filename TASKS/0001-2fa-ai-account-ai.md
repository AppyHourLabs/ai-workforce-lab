# Task 0001 — Enroll 2FA for `ai@`

## Goal
Enable 2FA enrollment for `ai@` using approved authenticator flow.

## Steps
1. Confirm `ai@` access is available to authorized operator.
2. Open account security settings and start 2FA enrollment.
3. Pair approved authenticator method.
4. Validate sign-in with 2FA challenge.
5. Record completion details in session handoff notes.

## Owner (Human vs AI)
Human

## Dependencies
- [PROJECTS/0001-google-workspace-hardening.md](../PROJECTS/0001-google-workspace-hardening.md)
- [POLICIES/oauth-policy.md](../POLICIES/oauth-policy.md)
- [RUNBOOKS/session-handoff.md](../RUNBOOKS/session-handoff.md)

## Definition of Done
- `ai@` requires 2FA at sign-in.
- Verification check succeeds.
- Handoff note includes date and verifier.

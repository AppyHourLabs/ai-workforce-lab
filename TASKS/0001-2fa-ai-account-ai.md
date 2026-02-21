# Task 0001 — Finish 2FA Enrollment for All AI Ops Accounts

> **Project:** [0001 — Google Workspace Hardening](../PROJECTS/0001-google-workspace-hardening.md)  
> **Owner:** Human (`matt@appyhourlabs.com`)  
> **Priority:** P0  
> **Status:** Open

---

## Goal

Ensure all four AI ops accounts (`ai@appyhourlabs.com`, `sales@appyhourlabs.com`, `media@appyhourlabs.com`, `doc@appyhourlabs.com`) have 2FA enforced. No AI account should be accessible with a password alone.

---

## Steps

1. Log in to Google Workspace Admin as `matt@appyhourlabs.com`
2. Navigate to **Security → 2-Step Verification** and confirm org-wide enforcement is enabled
3. For each account (`ai@appyhourlabs.com`, `sales@appyhourlabs.com`, `media@appyhourlabs.com`, `doc@appyhourlabs.com`):
   - Confirm 2FA is enrolled and active (not just required)
   - Verify enrollment via **Users → [account] → Security**
   - Record enrollment method (authenticator app preferred; SMS is a fallback, not the goal)
4. Attempt test sign-in on each account to validate the 2FA challenge fires
5. Record completion in session handoff using [`RUNBOOKS/session-handoff.md`](../RUNBOOKS/session-handoff.md)

---

## Owner (Human vs AI)

**Human only.** `matt@appyhourlabs.com` must perform or directly supervise this task. No AI agent has sufficient access scope for account security changes.

---

## Dependencies

- Active Google Workspace org with admin access for `matt@appyhourlabs.com`
- Authenticator app available on a trusted device
- [`POLICIES/oauth-policy.md`](../POLICIES/oauth-policy.md) — confirms AI accounts must use minimal access

---

## Definition of Done

- [ ] All 4 AI ops accounts show 2FA enrolled and enforced in Workspace Admin
- [ ] Test sign-in on each account triggers 2FA challenge
- [ ] Completion recorded in session handoff with date and verifying admin

---

## Risk Notes

- **If an account has no recovery method:** you may be locked out during enforcement. Set recovery options *before* enforcing 2FA.
- **SMS as sole 2FA method** is a downgrade risk. Prefer TOTP authenticator.
- **Shared device risk:** ensure the authenticator device is not the same device an AI agent has access to.

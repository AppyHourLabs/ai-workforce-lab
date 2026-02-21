# Task 0005 — Create Separate Chrome Profiles for AI Ops Accounts

> **Project:** [0002 — Mac Mini AI Office Setup](../PROJECTS/0002-mac-mini-ai-office-setup.md)  
> **Owner:** Human (`matt@appyhourlabs.com`)  
> **Priority:** P1  
> **Status:** Open

---

## Goal

Create isolated Chrome browser profiles for each AI ops account (`ai@appyhourlabs.com`, `sales@appyhourlabs.com`, `media@appyhourlabs.com`, `doc@appyhourlabs.com`) so that cookies, sessions, and credentials do not bleed between accounts. Confirm separation is working.

---

## Steps

1. Open Chrome on the Mac Mini (under `aioffice` macOS user)
2. Click the profile icon (top-right of browser window) → **Add**
3. **For each account** (`ai@appyhourlabs.com`, `sales@appyhourlabs.com`, `media@appyhourlabs.com`, `doc@appyhourlabs.com`):
   - Create a new profile named after the account (e.g., "ai-ops", "sales-ops", "media-ops", "doc-ops")
   - Assign a distinct avatar or color for visual identification
   - Sign in to the corresponding Google account
   - Confirm the account name appears in the profile switcher
4. Open each profile and verify:
   - Google Workspace shows the correct account
   - No cross-profile session leakage (sign in to `ai@appyhourlabs.com` profile, confirm `sales@appyhourlabs.com` profile does not see that session)
5. Set each profile to **not** sync browsing history to Google (check **Settings → Sync → Manage what you sync**)
6. Document the profile setup in session handoff notes

---

## Owner (Human vs AI)

**Human only.** Signing into Google accounts requires 2FA (Task 0001 dependency) and human presence.

---

## Dependencies

- Task 0001 complete (2FA enrolled on all AI ops accounts)
- Task 0004 complete (Chrome installed)
- [`POLICIES/oauth-policy.md`](../POLICIES/oauth-policy.md) — confirms account isolation requirement

---

## Definition of Done

- [ ] 4 Chrome profiles created: `ai@appyhourlabs.com`, `sales@appyhourlabs.com`, `media@appyhourlabs.com`, `doc@appyhourlabs.com`
- [ ] Each profile signed in to correct Google account
- [ ] Cross-profile session isolation verified (sign-in to one doesn't affect another)
- [ ] Profiles named and colored distinctly
- [ ] Sync settings reviewed and minimized

---

## Risk Notes

- **Profile ≠ total isolation.** Chrome profiles share the same macOS keychain. For stronger isolation, consider separate macOS users per agent in future phases.
- **"Guest" mode is not acceptable** for agent accounts — sessions don't persist.
- **Incognito mode is not acceptable** — defeats the purpose of persistent agent sessions.
- If Chrome prompts to "save password," decline. Passwords are managed via the approved secrets approach, not the browser.

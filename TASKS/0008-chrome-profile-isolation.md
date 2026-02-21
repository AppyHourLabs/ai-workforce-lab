# Task 0008 — Configure Chrome Profile Isolation

## Goal
Create isolated Chrome profiles for `ai@`, `sales@`, `media@`, and `doc@` workflows.

## Steps
1. Create four named Chrome profiles (`ai`, `sales`, `media`, `doc`).
2. Disable profile sync unless explicitly approved.
3. Apply profile-specific bookmarks/start pages per role.
4. Verify no cross-profile cookie/session leakage.
5. Document profile usage rules.

## Owner (Human vs AI)
Human

## Dependencies
- [PROJECTS/0002-mac-mini-ai-office-setup.md](../PROJECTS/0002-mac-mini-ai-office-setup.md)
- [POLICIES/posting-policy.md](../POLICIES/posting-policy.md)
- [POLICIES/oauth-policy.md](../POLICIES/oauth-policy.md)

## Definition of Done
- Four isolated profiles exist and are named.
- Test confirms profile session separation.
- Usage guidance is linked in project notes.

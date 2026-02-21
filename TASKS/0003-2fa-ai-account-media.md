# Task 0003 — Create AI Office macOS Standard User and Harden Settings

> **Project:** [0002 — Mac Mini AI Office Setup](../PROJECTS/0002-mac-mini-ai-office-setup.md)  
> **Owner:** Human (`matt@`)  
> **Priority:** P0  
> **Status:** Open

---

## Goal

Create a non-admin macOS standard user account (`aioffice`) for running agent workflows on the Mac Mini. Apply baseline security hardening: FileVault, firewall, and remote sharing disabled.

---

## Steps

### User Creation
1. Open **System Settings → Users & Groups**
2. Create a new Standard (non-admin) user: username `aioffice`, display name "AI Office"
3. Set a strong password; store in 1Password or equivalent (not in this repo)
4. Do not grant admin rights

### FileVault
5. Open **System Settings → Privacy & Security → FileVault**
6. Enable FileVault disk encryption
7. Store the recovery key securely (not on the Mac Mini itself); document where it is stored in handoff notes (location only, not the key)

### Firewall
8. Open **System Settings → Network → Firewall**
9. Enable the firewall
10. Set to block all incoming connections except those explicitly required

### Disable Remote Sharing Services
11. Open **System Settings → General → Sharing**
12. Disable all sharing services: Remote Login (SSH), Remote Management, Screen Sharing, File Sharing, AirDrop
13. Verify each is off

### Final Check
14. Log in as `aioffice` user and confirm:
    - No admin prompts available
    - FileVault is active
    - Firewall is running
    - No sharing services are accessible

---

## Owner (Human vs AI)

**Human only.** Physical machine configuration requires `matt@` presence at the device.

---

## Dependencies

- Physical access to Mac Mini
- No dependency on Task 0001/0002, but should be completed before any agent pipelines are run

---

## Definition of Done

- [ ] `aioffice` standard user created, no admin rights
- [ ] FileVault enabled; recovery key stored securely (location noted in handoff)
- [ ] Firewall enabled and configured
- [ ] All remote sharing services disabled
- [ ] Login as `aioffice` verified

---

## Risk Notes

- **FileVault recovery key loss = permanent data loss.** Store the key before rebooting.
- **SSH disabled** means no remote terminal access to the Mac Mini. If remote access is needed later, re-evaluate through [`POLICIES/oauth-policy.md`](../POLICIES/oauth-policy.md) and document the decision.
- **Standard user can't install software.** Switch to admin account for tooling installs (Task 0004), then return to `aioffice` for agent operations.

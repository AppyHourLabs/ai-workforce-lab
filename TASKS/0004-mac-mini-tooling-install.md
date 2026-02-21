# Task 0004 — Install Tooling on AI Office Mac Mini

> **Project:** [0002 — Mac Mini AI Office Setup](../PROJECTS/0002-mac-mini-ai-office-setup.md)  
> **Owner:** Human (`matt@appyhourlabs.com`) for install; AI (`ai@appyhourlabs.com`) for verification  
> **Priority:** P1  
> **Status:** Done

---

## Goal

Install the standard AI Office toolchain: Homebrew, Git, Node 20, Docker, Chrome, and Slack. All installs performed under admin account; agent operations run under `aioffice` standard user.

---

## Steps

### Prerequisites
1. Complete Task 0003 (standard user and hardening) first
2. Log in as admin account (not `aioffice`) for all installs

### Homebrew
3. Install Homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
4. Run `brew doctor` and resolve any warnings

### Git
5. `brew install git`
6. Configure: `git config --global user.name "AI Office"` and a non-personal email
7. Confirm: `git --version`

### Node 20
8. `brew install node@20`
9. Confirm: `node --version` (expect `v20.x.x`)

### Docker
10. Download Docker Desktop for Mac from docker.com (Apple Silicon or Intel, match the hardware)
11. Install and start Docker Desktop
12. Confirm: `docker --version` and `docker ps`

### Google Chrome
13. Download Chrome from google.com/chrome
14. Install to `/Applications`
15. Do not sign in to any account at the system Chrome level — individual profiles are configured in Task 0005

### Slack
16. Download Slack from slack.com/downloads/mac
17. Install to `/Applications`
18. Sign in as `matt@appyhourlabs.com` workspace only at this stage

### Verify as `aioffice` user
19. Switch to `aioffice` user
20. Confirm all tools are accessible: `brew`, `git`, `node`, `docker`, `chrome`, `slack`

---

## Owner (Human vs AI)

- **Install steps:** Human (`matt@appyhourlabs.com`) — requires admin
- **Verification step 19–20:** AI (`ai@appyhourlabs.com`) may assist by running verification commands

---

## Dependencies

- Task 0003 complete (hardened Mac Mini with `aioffice` user)
- Internet access on Mac Mini
- Homebrew compatible macOS version

---

## Definition of Done

- [x] All 6 tools installed and accessible
- [x] `git --version`, `node --version`, `docker --version` return expected versions
- [x] Chrome installed with no accounts signed in at the system level
- [x] Slack installed and workspace accessible
- [x] Verification passed under `aioffice` user account

---

## Risk Notes

- **Docker Desktop requires kernel extensions** on older macOS. Check compatibility before installing.
- **Node version:** use `node@20` explicitly via `brew install node@20`. The default `brew install node` may install a later version, which could cause compatibility issues with agent tooling.
- **Chrome profiles** are not configured here — that's Task 0005. Don't sign into Chrome accounts in this task.

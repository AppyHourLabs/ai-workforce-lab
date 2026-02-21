# CampClaw Path — AI Workforce Lab

> **Program:** [Claw Camp](https://campclaw.ai/my-path) · "Thirteen projects from security briefing to agent team. Each one ends with something real."
> **Account:** AppyhourLabs · *Last synced: 2026-02-21*

---

## Progress Overview

| Step | Title | Status | Repo Artifact |
|---|---|---|---|
| **00** | The Security Briefing | ✅ Complete | [PROJECT 0001](PROJECTS/0001-google-workspace-hardening.md) — 2FA, OAuth scope audit, API controls |
| **01** | The Build Partner | ✅ Complete | Antigravity (AI coding partner) + repo as shared context |
| **02** | The Job Description | ✅ Complete | [`AGENTS/`](AGENTS/) — role definitions for all AI ops accounts |
| **03** | The Setup | 🔵 Active | [PROJECT 0002](PROJECTS/0002-mac-mini-ai-office-setup.md) — Mac Mini hardened; OpenClaw install next |
| **04** | The Build | ⏳ Next | Configure first agent with identity docs and behavior instructions |
| **05** | The Wiring | 🔒 Locked | Connect agent to real-world tools (Gmail, Drive, etc.) |
| **06** | Deploy It | 🔒 Locked | First autonomous agent running on a schedule |
| — | **MILESTONE** | 🏁 | **FIRST AGENT DEPLOYED. NOW EXPAND.** |
| **07** | The Work Audit | 🔒 Locked | Identify 3–5 additional agent-ready jobs |
| **08** | The Second Agent | 🔒 Locked | Second working agent for a different job |
| **09** | Repeat | 🔒 Locked | Fleet of agents covering multiple roles |
| **10** | The Connections | 🔒 Locked | Agents wired together, sharing context |
| **11** | The System | 🔒 Locked | Full operation documented — monitoring & management |
| **12** | The Playbook | 🔒 Locked | Personalized AI workforce playbook |

---

## Step 03 — The Setup (Active)

**CampClaw Artifact:** A working OpenClaw instance connected to a messaging app (Slack or Discord).

**Repo Tasks:**

| Task | File | Status |
|---|---|---|
| Create `aioffice` macOS user + harden settings | [TASKS/0003](TASKS/0003-mac-mini-os-hardening.md) | Open |
| Install toolchain (brew, git, node, docker, chrome, slack) | [TASKS/0004](TASKS/0004-mac-mini-tooling-install.md) | Open |
| Create Chrome profiles for AI ops accounts | [TASKS/0005](TASKS/0005-mac-mini-chrome-profiles.md) | Open |
| Create local logging directory + conventions | [TASKS/0006](TASKS/0006-mac-mini-logging-setup.md) | Open |
| Install OpenClaw (not connected) | [TASKS/0010](TASKS/0010-openclaw-initial-install-not-connected.md) | Open |

**Step 03 Complete When:** OpenClaw is installed and connected to Slack or Discord.

---

## Step 04 — The Build (Next Up)

**CampClaw Artifact:** A fully configured agent with identity docs and behavior instructions.

**Repo Artifacts to Create:**
- Agent system prompt / behavior instructions (`AGENTS/`)
- Identity document per agent role
- Behavior instructions linked to [`POLICIES/ai-safety-charter.md`](POLICIES/ai-safety-charter.md)

---

## Local Docs

Full detail archived locally — no need to go back to the browser:

- [DOCS/CAMPCLAW/path.md](DOCS/CAMPCLAW/path.md) — all 13 steps with descriptions, artifacts, and repo cross-links
- [DOCS/CAMPCLAW/resources.md](DOCS/CAMPCLAW/resources.md) — community resources with lab reading queue

---

## Check-In

Weekly check-ins at [campclaw.ai/check-in](https://campclaw.ai/check-in).

| Question | This Week's Answer |
|---|---|
| What did you build? | Repo scaffolded; all accounts updated to `@appyhourlabs.com`; PR merged from main |
| Are you blocked? | Mac Mini physical setup pending (`matt@appyhourlabs.com` presence required) |
| Goal for next week? | Complete Step 03: finish Mac Mini hardening + OpenClaw install + connect to Slack |

---

*Synced from [campclaw.ai/my-path](https://campclaw.ai/my-path) · Update this file after each weekly check-in.*

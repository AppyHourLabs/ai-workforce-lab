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
| **03** | The Setup | ✅ Complete | [PROJECT 0002](PROJECTS/0002-mac-mini-ai-office-setup.md) — Mac Mini hardened; OpenClaw installed and connected to Slack |
| **04** | The Build | 🔵 Active | [TASK 0014](TASKS/0014-doc-agent-step04-configure.md) — Doc Agent configured; Episode 002 drafted |
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
| Create `aioffice` macOS user + harden settings | [TASKS/0003](TASKS/0003-mac-mini-os-hardening.md) | ✅ Done |
| Install toolchain (brew, git, node, docker, chrome, slack) | [TASKS/0004](TASKS/0004-mac-mini-tooling-install.md) | ✅ Done |
| Create Chrome profiles for AI ops accounts | [TASKS/0005](TASKS/0005-mac-mini-chrome-profiles.md) | ✅ Done |
| Create local logging directory + conventions | [TASKS/0006](TASKS/0006-mac-mini-logging-setup.md) | ✅ Done |
| Install OpenClaw + connect to Slack | [TASKS/0013](TASKS/0013-openclaw-install-slack-connect.md) | ✅ Done |

**Step 03 Complete When:** OpenClaw is installed and connected to Slack or Discord.

---

## Step 04 — The Build (Next Up)

**CampClaw Artifact:** A fully configured agent with identity docs and behavior instructions.

**First Agent:** Documentary Agent (`doc@appyhourlabs.com`) — lowest risk, self-documenting setup.

| Task | File | Status |
|---|---|---|
| Configure doc agent in OpenClaw (system prompt, file access, first run) | [TASKS/0014](TASKS/0014-doc-agent-step04-configure.md) | 🔵 Active |

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
| What did you build? | Step 03 complete (OpenClaw installed + Slack connected); Step 04 in progress (Doc Agent configured, Episode 002 drafted + quality gates passed) |
| Are you blocked? | PR review for Episode 002 (`matt@appyhourlabs.com` approval needed) |
| Goal for next week? | Complete Step 04 (merge Episode 002); begin Step 05 (The Wiring — connect agent to tools) |

---

*Synced from [campclaw.ai/my-path](https://campclaw.ai/my-path) · Update this file after each weekly check-in.*

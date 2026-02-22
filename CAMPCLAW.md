# CampClaw Path — AI Workforce Lab

> **Program:** [Claw Camp](https://campclaw.ai/my-path) · "Thirteen projects from security briefing to agent team. Each one ends with something real."
> **Account:** AppyhourLabs · *Last synced: 2026-02-22*

---

## Progress Overview

| Step | Title | Status | Repo Artifact |
|---|---|---|---|
| **00** | The Security Briefing | ✅ Complete | [PROJECT 0001](PROJECTS/0001-google-workspace-hardening.md) — 2FA, OAuth scope audit, API controls |
| **01** | The Build Partner | ✅ Complete | Antigravity (AI coding partner) + repo as shared context |
| **02** | The Job Description | ✅ Complete | [`AGENTS/`](AGENTS/) — role definitions for all AI ops accounts |
| **03** | The Setup | ✅ Complete | [PROJECT 0002](PROJECTS/0002-mac-mini-ai-office-setup.md) — Mac Mini hardened; OpenClaw installed and connected to Slack |
| **04** | The Build | ✅ Complete | [TASK 0014](TASKS/0014-doc-agent-step04-configure.md) — Doc Agent configured; Episode 002 merged |
| **05** | The Wiring | ✅ Complete | [TASK 0016](TASKS/0016-doc-agent-github-tool-wiring.md) — GitHub tool wired to Doc Agent |
| **06** | Deploy It | ✅ Complete | [TASK 0017](TASKS/0017-doc-agent-step06-deploy-it.md) — Daily cron schedule deployed |
| — | **MILESTONE** | 🏁 | **FIRST AGENT DEPLOYED. NOW EXPAND.** |
| **07** | The Work Audit | ✅ Complete | [TASK 0018](TASKS/0018-step07-work-audit.md) — Work audit: 3 agent-ready jobs identified |
| **08** | The Second Agent | ✅ Complete | QA, Content, and Security agents deployed |
| **09** | The Shared Brain | ✅ Complete | [TASK 0020](TASKS/0020-step09-shared-brain.md) — Shared memory layer wired across fleet |
| **10** | The Manager | ✅ Complete | [TASK 0021](TASKS/0021-step10-manager-agent.md) — Manager agent delegates to specialists |
| — | **Fleet Expansion** | ✅ Complete | TASKs [0022](TASKS/0022-cfo-agent-setup.md), [0023](TASKS/0023-cto-agent-setup.md), [0024](TASKS/0024-sdr-agent-setup.md) — CFO, CTO, SDR onboarded |
| **11** | The System | ✅ Complete | [TASK 0025](TASKS/0025-step11-the-system.md) — [DOCS/system-operations.md](DOCS/system-operations.md) |
| **12** | The Playbook | ✅ Complete | [TASK 0026](TASKS/0026-step12-the-playbook.md) — [DOCS/ai-workforce-playbook.md](DOCS/ai-workforce-playbook.md) |

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
| Configure doc agent in OpenClaw (system prompt, file access, first run) | [TASKS/0014](TASKS/0014-doc-agent-step04-configure.md) | ✅ Done |

---

## Step 05 — The Wiring (Complete)

**CampClaw Artifact:** An agent capable of interacting with the outside world (API or browser).

**First Tool:** GitHub via `gh` CLI — Doc Agent can create branches, commit episode drafts, and open PRs.

| Task | File | Status |
|---|---|---|
| Wire GitHub tool to Doc Agent (SOUL.md, TOOLS.md, routing, test) | [TASKS/0016](TASKS/0016-doc-agent-github-tool-wiring.md) | ✅ Done |

**Step 05 Complete:** 2026-02-21. Doc Agent responds in `#ai-office` via Slack and has GitHub tool access.

---

## Step 06 — Deploy It (Complete)

**CampClaw Artifact:** First autonomous agent running on a schedule.

**Deployment:** Doc Agent runs daily at 04:00 AM ET via OpenClaw cron. Scans the repo, drafts episodes if warranted, and posts a summary to `#ai-office`.

| Task | File | Status |
|---|---|---|
| Deploy doc agent on daily cron schedule | [TASKS/0017](TASKS/0017-doc-agent-step06-deploy-it.md) | ✅ Done |

**Step 06 Complete:** 2026-02-21. Doc Agent runs autonomously on a daily schedule.

---

## Step 07 — The Work Audit (Active)

**CampClaw Artifact:** A scored evaluation of all AGENTS/ roles identifying the next 3–5 agent builds.

| Task | File | Status |
|---|---|---|
| Audit all agent roles and recommend build order | [TASKS/0018](TASKS/0018-step07-work-audit.md) | ✅ Done |

**Recommended Build Order:**
1. **QA Agent** (25/25) — eval gate runner; perfect complement to doc agent
2. **Content Agent** (22/25) — social/blog drafts from episode content
3. **Security Agent** (21/25) — PR policy compliance scanning

See [TASK 0018](TASKS/0018-step07-work-audit.md) for full scoring and rationale.

**Step 07 Complete:** 2026-02-21. Three agent-ready jobs identified and prioritized.

---

## Step 08 — The Second Agent (Active)

**CampClaw Artifact:** Additional working agents for different jobs.

**Agents Built:** QA, Content, and Security — all configured in OpenClaw with workspaces, Slack bindings, and daily cron schedules.

| Agent | Schedule | Job |
|---|---|---|
| 🔍 QA Agent | 04:30 ET | Run quality + brand voice gates on doc-agent drafts |
| ✍️ Content Agent | 05:00 ET | Draft social/blog content from merged episodes |
| 🛡️ Security Agent | 05:30 ET | Scan open PRs for guardrail violations |

**Step 08 Complete:** 2026-02-21. Three agents deployed in OpenClaw with staggered cron schedules.

---

## Step 09 — The Shared Brain (Complete)

**CampClaw Artifact:** Multiple agents accessing a single, persistent memory store.

**Implementation:** Shared brain directory at `~/.openclaw/workspaces/shared/brain/` with fleet-wide memory search via `memorySearch.extraPaths`. Agents write handoff notes (doc→QA→content) so the morning pipeline carries context downstream.

| Component | Description |
|---|---|
| Shared brain | `~/.openclaw/workspaces/shared/brain/` — BRAIN.md, fleet-status.md, handoffs/ |
| Memory config | `memorySearch.extraPaths` in openclaw.json — all agents index shared brain |
| SOUL updates | All 4 agents have Shared Brain section with read/write instructions |
| Cron updates | All 4 cron jobs include shared brain handoff steps |
| Per-agent memory | `memory/` dirs created for all agents |

**Step 09 Complete:** 2026-02-22. Shared brain wired — agents share context across sessions.

---

## Step 10 — The Manager (Complete)

**CampClaw Artifact:** An orchestrator agent that routes tasks to specialist agents.

**Implementation:** Manager Agent (🎯) registered in OpenClaw with delegation via `openclaw agent --agent <id>`. Runs at 03:45 ET — first in the morning pipeline — posting fleet briefings before specialists run.

| Component | Description |
|---|---|
| Agent | `manager` — 🎯 Manager Agent |
| Schedule | 03:45 ET daily (before doc at 04:00) |
| Delegation | `openclaw agent --agent <id> --message "<task>"` |
| Fleet roster | Maintained in manager's TOOLS.md |
| Onboarding | [RUNBOOKS/new-agent-onboarding.md](RUNBOOKS/new-agent-onboarding.md) |

**Morning Pipeline (updated):**

| Time | Agent | Job |
|---|---|---|
| 03:45 ET | 🎯 Manager | Fleet briefing |
| 04:00 ET | 🎬 Doc | Repo scan + episode drafts |
| 04:30 ET | 🔍 QA | Quality + brand voice gates |
| 05:00 ET | ✍️ Content | Social/blog drafts |
| 05:30 ET | 🛡️ Security | PR security scans |
| 06:00 ET | 💰 CFO | Budget/cost/token efficiency |
| 06:30 ET | 🏗️ CTO | Architecture/SDLC review |
| 07:00 ET | 📞 SDR | Prospect/outreach check |
| 07:30 ET | 💻 Dev | Code, test, PR on assigned projects |
| 08:00 ET | 🎨 Product | Backlog refinement, sprint planning |

**Step 10 Complete:** 2026-02-22. Manager agent deployed.

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
| What did you build? | Steps 00–12 complete. 10 agents deployed (manager, doc, QA, content, security, CFO, CTO, SDR, dev, product) on staggered daily crons (03:45–08:00 ET). Shared brain wired — agents share context via handoff notes. Manager agent orchestrates fleet. Gateway watchdog cron monitors health every 10 min. Agile ceremony runbooks added. |
| Are you blocked? | X API developer setup needed for automated social posting (deferred). |
| Goal for next week? | Step 11 (The System) + Step 12 (The Playbook). Social posting deferred. |

---

*Synced from [campclaw.ai/my-path](https://campclaw.ai/my-path) · Update this file after each weekly check-in.*

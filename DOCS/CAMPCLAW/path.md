# CampClaw — My Path
> **Program:** [Claw Camp](https://campclaw.ai) · 13 projects from security briefing to agent team
> **Source:** campclaw.ai/my-path · *Archived locally: 2026-02-21*

---

## Progress

| # | Title | Status |
|---|---|---|
| 00 | The Security Briefing | ✅ Complete |
| 01 | The Build Partner | ✅ Complete |
| 02 | The Job Description | ✅ Complete |
| 03 | The Mac Mini | 🔵 Active |
| 04 | The SSH Tunnel | 🔒 Locked |
| 05 | The First Logic | 🔒 Locked |
| 06 | The First Tool | 🔒 Locked |
| — | **MILESTONE: First Agent Deployed. Now Expand.** | 🏁 |
| 07 | The Documentation | 🔒 Locked |
| 08 | The Knowledge Base | 🔒 Locked |
| 09 | The Shared Brain | 🔒 Locked |
| 10 | The Manager | 🔒 Locked |
| 11 | The Salesman | 🔒 Locked |
| 12 | The Daily Standup | 🔒 Locked |

---

## Project Details

### ✅ 00 — The Security Briefing
**Artifact:** Understanding of security resources & risks. A dedicated machine and clean admin accounts.

**What this is:** Your foundation. Before you run an agent, you understand what can go wrong and have set up a clean, controlled environment.
- Dedicated machine (Mac Mini or equivalent)
- Clean admin account separate from daily-use accounts
- 2FA on all accounts the agent will touch
- Understand the risk model before granting any access

**Repo:** [PROJECT 0001 — Google Workspace Hardening](../../PROJECTS/0001-google-workspace-hardening.md)

---

### ✅ 01 — The Build Partner
**Artifact:** A configured AI coach (Claude/ChatGPT) seeded with your context.

**What this is:** You set up a dedicated AI assistant — not for the agent itself, but as your build partner. You give it context: "I'm building my first agent team using OpenClaw." This becomes your sounding board throughout the journey.
- Create a dedicated project/workspace in Claude or ChatGPT
- Seed it with your goal, your stack, and your constraints
- Use it to sanity-check decisions as you build

**Repo:** Antigravity (this AI coding partner) serves this role for the Lab.

---

### ✅ 02 — The Job Description
**Artifact:** A clear, one-page job description — your North Star for what the agent will do.

**What this is:** You write down exactly what the agent's job is before you build anything. Repeatable tasks with clear inputs and outputs. This prevents scope creep and gives you a measurable definition of done.
- List 3–5 repeatable tasks with clear inputs/outputs
- Identify which tasks are highest value
- Write the "job description" as if hiring a human

**Repo:** [`AGENTS/`](../../AGENTS/) — all agent role definitions

---

### 🔵 03 — The Mac Mini *(Active)*
**Artifact:** A locally running computer dedicated to your agent. OpenClaw installed and connected to a messaging app (Slack or Discord).

**What this is:** The physical infrastructure. A dedicated machine that runs your agent's processes — not your daily laptop. This gives you a fixed, auditable, always-on environment.

**Steps:**
1. Acquire and set up a Mac Mini (or equivalent dedicated machine)
2. Create a non-admin OS user (`aioffice`) for agent operations
3. Enable FileVault + firewall; disable all remote sharing
4. Install toolchain: Homebrew, Git, Node 20, Docker, Chrome, Slack
5. Create isolated Chrome profiles for each AI ops account
6. Install OpenClaw
7. Connect OpenClaw to Slack or Discord

**Repo Tasks:**
- [TASK 0003 — OS Hardening](../../TASKS/0003-mac-mini-os-hardening.md)
- [TASK 0004 — Toolchain Install](../../TASKS/0004-mac-mini-tooling-install.md)
- [TASK 0005 — Chrome Profiles](../../TASKS/0005-mac-mini-chrome-profiles.md)
- [TASK 0006 — Logging Setup](../../TASKS/0006-mac-mini-logging-setup.md)
- [TASK 0010 — OpenClaw Install](../../TASKS/0010-openclaw-initial-install-not-connected.md)

**Done when:** OpenClaw is running on the Mac Mini and posting/receiving messages in Slack or Discord.

---

### 🔒 04 — The SSH Tunnel
**Artifact:** Secure remote access to your agent's hardware.

**What this is:** You set up SSH so you can securely reach the Mac Mini remotely without enabling broad remote access. This is the foundation for running the agent headlessly.
- Configure SSH key-based authentication
- Restrict SSH access to known IPs or VPN
- Verify remote terminal access works without a GUI

---

### 🔒 05 — The First Logic
**Artifact:** Your agent performing its first automated decision-making.

**What this is:** The agent does something that requires a decision — not just a script, but a conditional response based on input. First real intelligence in the loop.
- Write a simple workflow with an if/then branch
- Test with real input
- Log the decision and outcome

---

### 🔒 06 — The First Tool
**Artifact:** An agent capable of interacting with the outside world (API or browser).

**What this is:** The agent gains hands. It can call an external API, read a webpage, or interact with a third-party service. This is the step where it becomes genuinely useful.
- Identify one external tool/API the agent needs
- Wire it in through OpenClaw's tool system
- Test end-to-end with a real task

---

> ### 🏁 MILESTONE: First Agent Deployed. Now Expand.
> *You've deployed a working agent. It has a job, a machine, logic, and tools. Everything from here is about building the team.*

---

### 🔒 07 — The Documentation
**Artifact:** A structured system for documenting agent capabilities.

**What this is:** Before you scale, you document. What does the agent know? What can it do? What are its limits? This becomes the source of truth as the team grows.

---

### 🔒 08 — The Knowledge Base
**Artifact:** A RAG-enabled agent that knows your specific business data.

**What this is:** The agent gets memory of your specific context — docs, notes, SOPs — not just its training data. Retrieval-augmented generation (RAG) lets it answer questions specific to your operation.

---

### 🔒 09 — The Shared Brain
**Artifact:** Multiple agents accessing a single, persistent memory store.

**What this is:** When you have more than one agent, they need shared context. This step wires a common memory layer so agents don't duplicate work or contradict each other.

---

### 🔒 10 — The Manager
**Artifact:** An orchestral agent that routes tasks to specialist agents.

**What this is:** A coordinator agent that receives high-level requests and delegates to the right specialist. The beginning of real multi-agent coordination.

---

### 🔒 11 — The Salesman
**Artifact:** An agent capable of handling outbound or inbound leads.

**What this is:** An agent with real-world communication scope — it can reach out or respond to external contacts. Requires Phase B autonomy controls and careful scope definition.

---

### 🔒 12 — The Daily Standup
**Artifact:** A team of agents reporting their progress in a coordinated loop.

**What this is:** The full team checks in daily. Agents report what they did, what's blocked, what's next. This is your AI workforce operating as a coherent unit.

---

## Weekly Check-In

Log check-ins at [campclaw.ai/check-in](https://campclaw.ai/check-in) and mirror them here.

| Date | What did you build? | Blocked? | Goal for next week |
|---|---|---|---|
| 2026-02-21 | Repo scaffolded; accounts updated to @appyhourlabs.com; PR merged | Mac Mini physical setup (needs `matt@appyhourlabs.com` on-device) | Complete Step 03: OS hardening + OpenClaw install + Slack connection |

---

*Source: [campclaw.ai/my-path](https://campclaw.ai/my-path) · Update after each weekly check-in*

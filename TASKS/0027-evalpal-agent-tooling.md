# TASK 0027 — EvalPal Agent Tooling Setup

> **Status:** `complete`
> **Owner:** `matt@appyhourlabs.com`
> **Created:** 2026-02-22
> **Objective:** Configure agents to work on the EvalPal codebase and create new Dev and Product agents for development and product direction.

---

## Context

With the AI Workforce Lab fleet complete (Steps 00–12), the next phase is directing agents toward the primary product: EvalPal (`evalpal.dev`). This task sets up the tooling so agents can read, test, review, and contribute to the EvalPal codebase.

## What Was Done

### New Agents Created

| Agent | ID | Schedule | Role |
|---|---|---|---|
| 💻 Dev | `dev` | 07:30 ET | Full-stack development — code, test, PR |
| 🎨 Product | `product` | 08:00 ET | Product strategy, branding, UX, feature prioritization |

Both agents use a **project registry pattern** — their TOOLS.md lists active projects, so they can work on any codebase (not just EvalPal).

### Existing Agents Updated

| Agent | Change |
|---|---|
| 🏗️ CTO | Added EvalPal to project registry — can read codebase, write ADRs, run checks |
| 🔍 QA | Added EvalPal to project registry — can run tests, review PRs, report quality |
| 🛡️ Security | Added EvalPal to project registry — can scan PRs, run `npm audit`, check for secrets |

All agents updated to support multi-project assignments via `TOOLS.md` Project Registry.

### Infrastructure

- EvalPal repo cloned to `/Users/aioffice/EvalPal`
- npm dependencies installed
- `gh` CLI access to `MatthewEngman/EvalPal` verified
- Manager fleet roster updated (10 agents, 03:45–08:00 ET)

## Updated Morning Pipeline

| Time | Agent | Job |
|---|---|---|
| 03:45 ET | 🎯 Manager | Fleet briefing |
| 04:00 ET | 🎬 Doc | Repo scan + episode drafts |
| 04:30 ET | 🔍 QA | Quality + brand voice gates; EvalPal test runs |
| 05:00 ET | ✍️ Content | Social/blog drafts |
| 05:30 ET | 🛡️ Security | PR security scans (both repos) |
| 06:00 ET | 💰 CFO | Financial analysis |
| 06:30 ET | 🔧 CTO | Architecture review; EvalPal technical direction |
| 07:00 ET | 📞 SDR | Prospect research |
| 07:30 ET | 💻 Dev | EvalPal test health, issue triage, coding |
| 08:00 ET | 🎨 Product | Product direction, branding, feature priorities |

---

*Links: [CAMPCLAW.md](../CAMPCLAW.md) · [AGENTS/dev-agent.md](../AGENTS/dev-agent.md) · [AGENTS/product-agent.md](../AGENTS/product-agent.md)*

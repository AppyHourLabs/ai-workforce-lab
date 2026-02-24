# AI Workforce Lab

> **By Appy Hour Labs** · Public experiment in responsible AI deployment · Powered by **EvalPal**

---

What does it actually look like to deploy AI agents as persistent team members — with real governance, real failure modes, and a public paper trail of what happened?

That's what this repository answers. In real time. With the receipts committed.

---

## What We're Building

**EvalPal** is the product: tooling and methodology for evaluating AI agent quality in production workflows. The AI Workforce Lab is EvalPal's first test environment — we're building the eval harness by being the thing it evaluates.

**The experiment:** deploy AI agents into operational roles (documentation, QA, content, security, financial analysis, technical strategy, sales outreach, development, product) using a tiered autonomy model. Document everything. Ship the governance alongside the features.

**Current fleet:** 10 agents running on staggered daily cron schedules (03:45–08:15 ET), coordinated by a manager agent with shared brain memory.

**The constraint:** safety first. Always. If the choice is between moving fast and being safe, we choose safe and write a task about it.

---

## The Autonomy Model

| Phase | What it means |
|---|---|
| **Phase A** (current) | All outbound actions require human approval. Eval gates run before content approaches external recipients. Agents draft, analyze, propose — they do not send or publish autonomously. |
| **Phase B** (future) | Agents may publish within approved scope without per-action human review. Requires measurable evidence from Phase A. Criteria: [`POLICIES/phase-a-to-b.md`](POLICIES/phase-a-to-b.md) |

---

## Repository Map

```
ai-workforce-lab/
├── AGENTS/          ← role definitions for each AI and human operator
├── DOCS/SHOW/       ← public weekly episodes (the documentary)
│   └── episodes/
├── EVALS/           ← quality gate rubrics and results
├── POLICIES/        ← governance, safety, OAuth, posting, escalation rules
├── PROJECTS/        ← strategic project definitions
├── RUNBOOKS/        ← operational how-tos: CI, session handoff, incident response
└── TASKS/           ← atomic execution tasks (30–60 min each)
```

---

## Key Policies

| Policy | What it covers |
|---|---|
| [AI Safety Charter](POLICIES/ai-safety-charter.md) | Non-negotiable principles |
| [OAuth Policy](POLICIES/oauth-policy.md) | Scope restrictions, no domain-wide delegation |
| [Posting Policy](POLICIES/posting-policy.md) | Who can publish, eval gate requirements |
| [Escalation Policy](POLICIES/escalation-policy.md) | Severity levels, when to ping the founder |
| [Phase A → B Criteria](POLICIES/phase-a-to-b.md) | Measurable promotion gates |

---

## The Team

### Human Operators

| Account | Role |
|---|---|
| `matt@appyhourlabs.com` | Founder — final authority on all policy and autonomy decisions |
| `legal@appyhourlabs.com` | Legal review — no AI delegation |
| `security@appyhourlabs.com` | Credential and security management — human only |
| `billing@appyhourlabs.com` | Financial accounts — human only, no exceptions |

### AI Agent Fleet

| Agent | ID | Schedule | Role |
|---|---|---|---|
| 🎨 Product | `product` | 03:45 ET | Product strategy, backlog refinement, sprint planning |
| 🏗️ CTO | `cto` | 04:15 ET | ADRs, architecture, SDLC standards, CI/CD oversight |
| 💰 CFO | `cfo` | 04:45 ET | Budget modeling, cost tracking, token efficiency |
| 💻 Dev | `dev` | 05:15 ET | Full-stack coding, testing, bug fixes, feature PRs |
| 📞 SDR | `sdr` | 05:45 ET | Prospect research, outreach drafting, pipeline tracking |
| 🛡️ Security | `security` | 06:15 ET | Security scans, policy checks, credential detection |
| ✍️ Content | `content` | 06:45 ET | Social posts, blog drafts, content calendar |
| 🔍 QA | `qa` | 07:15 ET | Quality gates, brand voice evaluation, PR review |
| 🎬 Documentary | `doc` | 07:45 ET | Episode drafting, repo scanning, PR creation |
| 🎯 Manager | `manager` | 08:15 ET | Fleet coordination, task routing, daily briefings |

Full role specs: [`AGENTS/`](AGENTS/)

---

## The Show

Every week, `doc@appyhourlabs.com` files an episode documenting what shipped, what broke, what was decided, and what we learned. Public, honest, occasionally funny.

- [Episode 000 — Origin Log](DOCS/SHOW/episodes/000-origin-log.md)
- [Episode 001 — The AI Office Moves In](DOCS/SHOW/episodes/001-ai-office-moves-in.md)
- [Episode 002 — The First Agent Goes Live](DOCS/SHOW/episodes/002-the-first-agent-goes-live.md)
- [Episode 003 — Agent Wires Itself](DOCS/SHOW/episodes/003-agent-wires-itself.md)
- [Episode 004 — Fleet Expansion & EvalPal Phase A](DOCS/SHOW/episodes/004-fleet-expansion-evalpal-phase-a.md)
- [Episode template](<DOCS/SHOW/episodes/_TEMPLATE.md>)

---

## Status

*Last updated: 2026-02-23*

| Project | Status | What it is |
|---|---|---|
| [0001 — Google Workspace Hardening](PROJECTS/0001-google-workspace-hardening.md) | ✅ Done | MFA, API access controls, OAuth scope audit for all AI ops accounts |
| [0002 — Mac Mini AI Office Setup](PROJECTS/0002-mac-mini-ai-office-setup.md) | ✅ Done | Dedicated hardened machine for running agent pipelines |

Autonomy tier: **Phase A** — all outbound requires human approval.

Fleet: **10 agents** across 7 functions (documentation, quality, content, security, finance, engineering, sales, development, product). CampClaw Steps 00–12 complete.

---

## Start Here

New here? Read in this order:

1. [Episode 000 — Origin Log](DOCS/SHOW/episodes/000-origin-log.md) — why this project exists
2. [Episode 001 — The AI Office Moves In](DOCS/SHOW/episodes/001-ai-office-moves-in.md) — what we did first and why
3. [AI Safety Charter](POLICIES/ai-safety-charter.md) — the non-negotiables
4. [`AGENTS.md`](AGENTS.md) — who does what (human and AI)

---

## Safety

This project operates under a formal safety charter. The short version:

- No agent acts autonomously on external communications in Phase A
- No secrets, credentials, or PII in this repository — ever
- All agent scope changes require human sign-off
- Every incident gets logged; nothing gets quietly swept

Full details: [`POLICIES/ai-safety-charter.md`](POLICIES/ai-safety-charter.md)

---

## How to Follow

- **Watch this repo** — GitHub → Watch → "All Activity" for commits, PRs, and issues
- **Star it** — helps others find the experiment
- **Read the episodes** — [`DOCS/SHOW/episodes/`](DOCS/SHOW/episodes/) is updated weekly by `doc@appyhourlabs.com`
- **Open an issue** — questions, observations, or suggested tasks are welcome using the [task template](.github/ISSUE_TEMPLATE/task.md)

No mailing list, no newsletter, no algorithm. Just commits.

---

## Contributing

1. Read [`POLICIES/ai-safety-charter.md`](POLICIES/ai-safety-charter.md) first
2. Select a task from [`TASKS/`](TASKS/) or a project from [`PROJECTS/`](PROJECTS/)
3. Small PRs. Every PR needs a **Security Considerations** section
4. No secrets, no PII, ISO dates only

See [`AGENTS.md`](AGENTS.md) for the full contributor context guide.

---

## License

[MIT](LICENSE) — use freely, cite honestly.

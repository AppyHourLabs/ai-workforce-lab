# DOCS Index — AI Workforce Lab

> Source of truth for the AI Workforce Lab. Maintained by `doc@appyhourlabs.com`; final authority is `matt@appyhourlabs.com`.
> **EvalPal product focus is active as of 2026-02-22.** All agent tasks orient toward EvalPal stability, security, and Phase B readiness.

---

## How doc@appyhourlabs.com Should Use This Repo

Before drafting any episode, `doc@appyhourlabs.com` must review this repo as the authoritative source of record. **Do not rely on session memory alone.** Each episode should be grounded in what is actually committed:

- Check `PROJECTS/` for current project status and completed tasks
- Check `TASKS/` for what was completed, in-progress, or deferred since last episode
- Check `TASKS/_PRIORITY_BACKLOG.md` for the current top-25 ranked backlog
- Check `EVALS/results/` for any gate failures or notable output reviews
- Check `INCIDENTS/` for any incidents that occurred in the period
- Cross-link all factual claims to committed source files — no claims from memory

If a fact cannot be linked to a committed file, it does not belong in an episode as stated fact. Mark it as context or omit it.

Run the publish preflight (`RUNBOOKS/publish-preflight.md`) before submitting any episode draft for review.

---

## Policies

Governance rules that apply to all agents and human operators.

| Document | Purpose |
|---|---|
| [AI Safety Charter](../POLICIES/ai-safety-charter.md) | Non-negotiable safety principles |
| [Posting Policy](../POLICIES/posting-policy.md) | Who may publish what, and how |
| [OAuth Policy](../POLICIES/oauth-policy.md) | Scope restrictions, no domain-wide delegation |
| [Escalation Policy](../POLICIES/escalation-policy.md) | Severity levels, when to stop and notify `matt@appyhourlabs.com` |
| [Phase A → B Criteria](../POLICIES/phase-a-to-b.md) | Measurable gates for autonomy promotion |
| [LLM Usage Policy](../POLICIES/llm-usage-policy.md) | Token budgets, model selection, cost guardrails |

---

## Projects

Active strategic initiatives.

| Project | Status | Description |
|---|---|---|
| [0001 — Google Workspace Hardening](../PROJECTS/0001-google-workspace-hardening.md) | 🔵 Active | MFA, API access controls, OAuth audit |
| [0002 — Mac Mini AI Office Setup](../PROJECTS/0002-mac-mini-ai-office-setup.md) | 🔵 Active | Dedicated hardened machine for agent pipelines |
| EvalPal — Phase A Hardening | 🟠 In Progress | QA, security, cost controls, eval tooling for `evalpal.dev` |

---

## Agents

Role definitions for all operators — human and AI.

| Agent | File | Role | Schedule |
|---|---|---|---|
| `matt@appyhourlabs.com` | [founder.md](../AGENTS/founder.md) | Human super admin — final authority | On-call |
| `ai@appyhourlabs.com` | [cto-agent.md](../AGENTS/cto-agent.md) | Architecture, technical direction | 06:30 ET |
| `doc@appyhourlabs.com` | [documentary-agent.md](../AGENTS/documentary-agent.md) | Weekly episodes and public documentation | 04:00 ET |
| `sales@appyhourlabs.com` | [sdr-agent.md](../AGENTS/sdr-agent.md) | Outreach drafting — Phase A gated | 07:00 ET |
| `media@appyhourlabs.com` | [content-agent.md](../AGENTS/content-agent.md) | Content and distribution — Phase A gated | 05:00 ET |
| Security | [security-agent.md](../AGENTS/security-agent.md) | Risk monitoring and policy compliance | 05:30 ET |
| QA | [qa-agent.md](../AGENTS/qa-agent.md) | Eval gate execution, regression | 04:30 ET |
| CFO | [cfo-agent.md](../AGENTS/cfo-agent.md) | Financial analysis — advisory only | 06:00 ET |
| Dev | [dev-agent.md](../AGENTS/dev-agent.md) | Full-stack development on EvalPal | 07:30 ET |
| Product | [product-agent.md](../AGENTS/product-agent.md) | Product strategy, UX, feature prioritization | 08:00 ET |

---

## Runbooks

Operational procedures for agents and human operators.

| Runbook | Purpose |
|---|---|
| [Session Handoff](../RUNBOOKS/session-handoff.md) | How agents hand off context between sessions |
| [New Agent Onboarding](../RUNBOOKS/new-agent-onboarding.md) | Setup steps for new agents |
| [CI](../RUNBOOKS/ci.md) | CI/CD pipeline operations |
| [Backlog Process](../RUNBOOKS/backlog-process.md) | How tasks are created, prioritized, worked, and closed |
| [Phase A Execution Plan](../RUNBOOKS/phase-a-execution-plan.md) | 30/60/90 day EvalPal hardening roadmap |
| [Backlog Refinement](../RUNBOOKS/backlog-refinement.md) | Agile ceremony — backlog grooming |
| [Sprint Planning](../RUNBOOKS/sprint-planning.md) | Agile ceremony — sprint kickoff |
| [Standup](../RUNBOOKS/standup.md) | Agile ceremony — daily check-in |
| [Retro](../RUNBOOKS/retro.md) | Agile ceremony — sprint retrospective |
| [Human Escalation](../RUNBOOKS/human-escalation.md) | When and how to escalate to `matt@appyhourlabs.com` |
| [Logging Conventions](../RUNBOOKS/logging-conventions.md) | Structured logging format for all agent actions |
| [EvalPal Agent Evals](../RUNBOOKS/evalpal-agent-evals.md) | How to run, track, and improve agent evals via evalpal.dev |
| [EvalPal Issue Tracking](../RUNBOOKS/evalpal-issue-tracking.md) | How agents file, track, and close EvalPal bugs via gh CLI |

---

## Tasks

All atomic work items executed by the agent fleet.

| Resource | Purpose |
|---|---|
| [Priority Backlog](../TASKS/_PRIORITY_BACKLOG.md) | Top 25 ranked tasks — P0/P1/P2 with owner + impact |
| `TASKS/00XX-*.md` | Individual task files — goal, steps, DoD, risks |
| `TASKS/content/` | Content-specific task subtasks |
| `TASKS/sprints/` | Sprint tracking |

---

## Eval Gates

Quality gates that must pass before any AI-authored content goes external.

| Gate | File | When to run |
|---|---|---|
| Outbound Quality Gate | [outbound-quality-gate.md](../EVALS/outbound-quality-gate.md) | All external content |
| Brand Voice Gate | [brand-voice-gate.md](../EVALS/brand-voice-gate.md) | All external content |

Results are filed per-item in `EVALS/results/[slug]-quality.md` and `EVALS/results/[slug]-voice.md`.

### EvalPal Agent Performance Evals

Systematic agent testing via [evalpal.dev](https://evalpal.dev) — dogfooding our own product.

| Resource | File | Purpose |
|---|---|---|
| Agent Eval Definitions | [agent-eval-definitions.md](../EVALS/agent-eval-definitions.md) | 12+ eval definitions across all 10 agents |
| Weekly Scorecard Template | [agent-scorecard-template.md](../EVALS/agent-scorecard-template.md) | Per-agent pass rates, trends, failure patterns |
| Baselines | `EVALS/results/baselines/` | Initial scores for regression comparison |
| Scorecards | `EVALS/results/scorecards/` | Weekly performance reports |
| Regressions | `EVALS/results/regressions/` | Quality drop alerts and investigation notes |

---

## Episodes

Weekly public documentary. Filed by `doc@appyhourlabs.com`, approved by `matt@appyhourlabs.com`.

| Episode | Title |
|---|---|
| [000](SHOW/episodes/000-origin-log.md) | Origin Log |
| [001](SHOW/episodes/001-ai-office-moves-in.md) | The AI Office Moves In |
| [\_TEMPLATE](SHOW/episodes/_TEMPLATE.md) | Episode template |

---

## Schemas

Data contracts for content validation.

| Schema | Purpose |
|---|---|
| [content-schema.json](../SCHEMAS/content-schema.json) | Validates all episode and post frontmatter |

---

*Cross-links: [README.md](../README.md) · [AGENTS.md](../AGENTS.md) · [TASKS/_PRIORITY_BACKLOG.md](../TASKS/_PRIORITY_BACKLOG.md) · [RUNBOOKS/phase-a-execution-plan.md](../RUNBOOKS/phase-a-execution-plan.md)*

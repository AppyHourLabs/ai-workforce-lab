# DOCS Index — AI Workforce Lab

> Source of truth for the AI Workforce Lab. Maintained by `doc@appyhourlabs.com`; final authority is `matt@appyhourlabs.com`.

---

## How doc@appyhourlabs.com Should Use This Repo

Before drafting any episode, `doc@appyhourlabs.com` must review this repo as the authoritative source of record. **Do not rely on session memory alone.** Each episode should be grounded in what is actually committed:

- Check `PROJECTS/` for current project status and completed tasks
- Check `TASKS/` for what was completed, in-progress, or deferred since last episode
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

---

## Projects

Active strategic initiatives.

| Project | Status | Description |
|---|---|---|
| [0001 — Google Workspace Hardening](../PROJECTS/0001-google-workspace-hardening.md) | 🔵 Active | MFA, API access controls, OAuth audit |
| [0002 — Mac Mini AI Office Setup](../PROJECTS/0002-mac-mini-ai-office-setup.md) | 🔵 Active | Dedicated hardened machine for agent pipelines |

---

## Agents

Role definitions for all operators — human and AI.

| Agent | File | Role |
|---|---|---|
| `matt@appyhourlabs.com` | [founder.md](../AGENTS/founder.md) | Human super admin — final authority |
| `ai@appyhourlabs.com` | [cto-agent.md](../AGENTS/cto-agent.md) | General ops and technical tasks |
| `doc@appyhourlabs.com` | [documentary-agent.md](../AGENTS/documentary-agent.md) | Weekly episodes and public documentation |
| `sales@appyhourlabs.com` | [sdr-agent.md](../AGENTS/sdr-agent.md) | Outreach drafting — Phase A gated |
| `media@appyhourlabs.com` | [content-agent.md](../AGENTS/content-agent.md) | Content and distribution — Phase A gated |
| Security | [security-agent.md](../AGENTS/security-agent.md) | Risk monitoring and policy compliance |
| QA | [qa-agent.md](../AGENTS/qa-agent.md) | Eval gate execution |
| CFO | [cfo-agent.md](../AGENTS/cfo-agent.md) | Financial analysis — advisory only |

---

## Episodes

Weekly public documentary. Filed by `doc@appyhourlabs.com`, approved by `matt@appyhourlabs.com`.

| Episode | Title |
|---|---|
| [000](SHOW/episodes/000-origin-log.md) | Origin Log |
| [001](SHOW/episodes/001-ai-office-moves-in.md) | The AI Office Moves In |
| [\_TEMPLATE](SHOW/episodes/_TEMPLATE.md) | Episode template |

---

## Eval Gates

Quality gates that must pass before any AI-authored content goes external.

| Gate | File | When to run |
|---|---|---|
| Outbound Quality Gate | [outbound-quality-gate.md](../EVALS/outbound-quality-gate.md) | All external content |
| Brand Voice Gate | [brand-voice-gate.md](../EVALS/brand-voice-gate.md) | All external content |

Results are filed per-item in `EVALS/results/[slug]-quality.md` and `EVALS/results/[slug]-voice.md`.

---

*Cross-links: [README.md](../README.md) · [AGENTS.md](../AGENTS.md) · [RUNBOOKS/](../RUNBOOKS/)*

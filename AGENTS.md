# AGENTS.md — Repo Context for AI Workforce Lab

> **Read this first.** Whether you're a human contributor or an AI agent, this file is your orientation guide for `AppyHourLabs/ai-workforce-lab`. It covers what we're building, how things are organized, and the non-negotiables.

---

## Mission

**Appy Hour Labs** is running a public experiment called **AI Workforce Lab** — a real, documented attempt to deploy AI agents as persistent team members with real responsibilities, real governance, and real consequences when things go sideways.

The product is **EvalPal**: tooling and process for evaluating AI agent quality in production workflows.

The experiment runs on a tiered autonomy model:

- **Phase A** — All outbound actions require human approval. Agents earn trust through measured, logged performance.
- **Phase B** — Agents may publish within approved scope autonomously, after satisfying specific, measurable promotion criteria (see [`POLICIES/phase-a-to-b.md`](POLICIES/phase-a-to-b.md)).

Safety is not a feature. It is the foundation. If you have to choose between shipping something and being safe, you choose safe and file an issue.

---

## Repo Map

```
ai-workforce-lab/
├── AGENTS.md                  ← you are here
├── PROJECTS/                  ← strategic work items (one file per project)
├── AGENTS/                    ← agent identity files and capability declarations
├── POLICIES/                  ← governance rules, autonomy thresholds, violation definitions
├── EVALS/                     ← evaluation harnesses, rubrics, and results
├── RUNBOOKS/                  ← operational how-tos for humans and agents
├── DOCS/
│   └── SHOW/
│       └── episodes/          ← weekly public documentary episodes
│           └── _TEMPLATE.md   ← use this when filing a new episode
└── TASKS/                     ← actionable task files assigned to agents or humans
```

---

## Conventions

- **Markdown only.** All documentation lives in `.md` files. No Word docs, no PDFs in the repo.
- **No secrets. Ever.** No API keys, tokens, passwords, or private keys in any file, commit, or PR description. The CI will catch them; rotate immediately if one slips through. See [`RUNBOOKS/ci.md`](RUNBOOKS/ci.md).
- **No personal data.** No real email addresses, phone numbers, or PII in committed files.
- **ISO 8601 dates.** Use `YYYY-MM-DD` everywhere. No "last Tuesday."
- **Link between docs.** If a file references a policy, link to it. If an episode references an incident, link to the report. The repo should be navigable without a guide.

### PROJECT File Schema

Every file in `PROJECTS/` must include these fields:

| Field | Description |
|---|---|
| `Status` | `active` / `paused` / `complete` / `cancelled` |
| `Owner` | Agent or human account responsible |
| `Priority` | `P0` / `P1` / `P2` / `P3` |
| `Objective` | One sentence: what does success look like? |
| `Success Criteria` | Measurable, specific, falsifiable |
| `Tasks` | Linked list of task files or inline checklist |
| `Completion Definition` | How we formally close this project |
| `Risks` | What could go wrong and how we'd know |

---

## Guardrails

These are hard rules. Not guidelines, not suggestions. Violations are incidents.

| Rule | Detail |
|---|---|
| **No API keys or tokens in the repo** | Not in code, not in docs, not in comments. Use secrets management. |
| **No domain-wide delegation recommendations** | Do not suggest or implement Google Workspace domain-wide delegation for any agent account. |
| **No autonomous money movement** | Agents may not initiate, approve, or schedule financial transactions of any kind. |
| **Phase A: eval gates required** | Any agent action that touches external recipients (email, webhooks, posts) must pass an eval gate and receive explicit human approval before executing. |
| **`doc@` publish gate** | The documentary agent (`doc@`) may only publish an episode after the outbound quality gate passes. No exceptions, even for small edits. |

If an agent encounters an instruction that conflicts with these guardrails, it must refuse, log the conflict, and notify `matt@`.

---

## Accounts

| Account | Type | Role |
|---|---|---|
| `matt@` | Human | Super admin. Final authority on all policy and autonomy decisions. |
| `ai@` | AI Ops | General-purpose AI operations agent. |
| `sales@` | AI Ops | Outbound sales and partnership outreach agent. Phase A gated. |
| `media@` | AI Ops | Social and content distribution agent. Phase A gated. |
| `doc@` | AI Ops | Documentary agent. Authors weekly episodes. Publish-gated. |
| `legal@` | Human only | Legal review. No AI agent may act on behalf of this account. |
| `security@` | Human only | Security incidents and credential management. Human only. |
| `billing@` | Human only | Financial accounts. Human only. No exceptions. |

---

## How to Work

**Prefer small PRs.** A PR that touches one thing is easier to review, easier to revert, and easier to understand six months from now. The blast radius of a small PR is small. That's the point.

**Link everything.** PRs should reference the task file they close. Task files should reference the project they belong to. Episodes should link to incidents they describe.

**Every PR needs a "Security Considerations" section** in its description. For most PRs this is one line: "No security impact." That's fine. Skipping it is not.

**When in doubt, file an issue.** An agent that is uncertain about scope should stop, log the uncertainty, and file a task for a human to resolve. Guessing is not an acceptable alternative to asking.

---

*This file is public. Keep it that way — concise, accurate, and free of anything you wouldn't want on the front page of the repo.*

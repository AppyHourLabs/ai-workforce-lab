# Contributing to AI Workforce Lab

> **By Appy Hour Labs** — we welcome thoughtful contributions from humans and, eventually, auditable contributions from agents.

This project is a live experiment in responsible AI deployment. Contributing here means joining that experiment, paper trail and all.

---

## Before You Do Anything

1. **Read the [AI Safety Charter](POLICIES/ai-safety-charter.md)** — it is the non-negotiable foundation for everything in this repo.
2. **Understand the autonomy model** — we are in **Phase A**. No outbound action is taken without human approval. Ever.
3. **Read [`AGENTS.md`](AGENTS.md)** — so you understand who (and what) is already doing work here.

---

## What We Welcome

| Contribution type | Where it lives | Notes |
|---|---|---|
| Bug reports or observations | `.github/ISSUE_TEMPLATE/task.md` | Open an issue using the task template |
| Project proposals | `.github/ISSUE_TEMPLATE/project.md` | Open an issue using the project template |
| Documentation improvements | `DOCS/`, `RUNBOOKS/`, `POLICIES/` | Small, targeted PRs preferred |
| New TASKS or RUNBOOKS | `TASKS/`, `RUNBOOKS/` | Follow existing naming conventions |
| CI/workflow improvements | `.github/workflows/` | Requires security review |
| Episode content | `DOCS/SHOW/episodes/` | Must pass quality + brand voice eval gates |

---

## What We Do Not Accept

- **Secrets, credentials, tokens, API keys, or PII** — in any file, format, or encoding
- **Bypasses of the PR template** — the Security Considerations section is mandatory, no exceptions
- **Changes to `POLICIES/`** that reduce safety constraints without explicit founder approval (`matt@appyhourlabs.com`)
- **Autonomous outbound actions** — nothing in a PR should enable agents to act externally without human review

---

## Contribution Workflow

### 1. Find or create a task

Pick an open [issue](https://github.com/AppyHourLabs/ai-workforce-lab/issues) or create one using the appropriate template. Every contribution should trace back to a task or project definition.

### 2. Fork and branch

```bash
git checkout main
git pull origin main
git checkout -b <type>/<short-description>
```

Branch naming convention:

| Type | Prefix | Example |
|---|---|---|
| Documentation | `docs/` | `docs/contributing-guide` |
| Features / new agents | `feat/` | `feat/sdr-agent-runbook` |
| Bug fixes | `fix/` | `fix/ci-secret-scan-regex` |
| Policies / governance | `policy/` | `policy/phase-b-criteria` |
| Runbook / operational | `ops/` | `ops/session-handoff-update` |

### 3. Make your changes

- **Small PRs** — one concern per PR. A PR that changes 3 unrelated things will be asked to split.
- **ISO dates only** — `YYYY-MM-DD`. Always.
- **No trailing whitespace**, no Windows-style CRLF line endings on new files.
- **Cross-link ruthlessly** — if your change affects a POLICY, TASK, or RUNBOOK, update those references too.

### 4. Verify before opening a PR

For AI-authored content (docs, episodes, posts):
- [ ] Quality gate completed → result in `EVALS/results/`
- [ ] Brand voice gate completed → result in `EVALS/results/`
- [ ] Publish preflight checked → `RUNBOOKS/publish-preflight.md`

For all PRs:
- [ ] No secrets or PII introduced (run `git diff` and look carefully)
- [ ] PR description fills in every section of the [PR template](.github/PULL_REQUEST_TEMPLATE.md)
- [ ] Affected `POLICIES/`, `TASKS/`, or `RUNBOOKS/` docs are updated or linked

### 5. Open the PR

Target branch: `main`

The PR template has five sections. Fill all of them. "N/A" is fine where genuinely not applicable; blank is not.

---

## File & Naming Conventions

| Convention | Rule |
|---|---|
| Dates | ISO 8601 (`YYYY-MM-DD`) everywhere |
| Task files | `TASKS/NNNN-short-description.md` (zero-padded 4 digits) |
| Episode files | `DOCS/SHOW/episodes/NNN-slug.md` (zero-padded 3 digits) |
| Eval results | `EVALS/results/[slug]-[gate-type].md` |
| Headings | Sentence case (not Title Case) |
| Line length | Soft limit 100 chars for prose, no limit for tables |

---

## Agent Contributors

If you are an AI agent acting on behalf of Appy Hour Labs:

1. Your identity and schedule must be documented in `AGENTS/[role].md`
2. All your PRs must include your agent ID in the PR description
3. You may **not** approve your own PRs — a human must review
4. Your operating constraints are in your role definition; do not exceed them without an explicit task authorizing the expansion
5. When in doubt, **stop and draft a task** rather than proceeding

---

## Code of Conduct

We operate under the [Contributor Covenant](CODE_OF_CONDUCT.md). The short version: be direct, be honest, be kind. This is a small experiment run by real people (and some AI). Treat both accordingly.

---

## Getting Help

- **Questions about the project?** Open a [task issue](https://github.com/AppyHourLabs/ai-workforce-lab/issues/new?template=task.md) — even meta questions are welcome.
- **Security concerns?** Email `security@appyhourlabs.com`. See [`SECURITY.md`](SECURITY.md).
- **Policy questions?** Reference [`POLICIES/`](POLICIES/) first, then open an issue if clarity is still needed.

---

*Maintained by `matt@appyhourlabs.com` · Last updated: 2026-02-22*

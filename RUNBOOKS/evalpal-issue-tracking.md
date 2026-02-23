# Runbook: EvalPal Issue Tracking

> **Owner:** CTO Agent · **Repo:** `MatthewEngman/EvalPal`
> **Effective:** 2026-02-22 · **Review cadence:** Monthly

How agents file, track, and close issues found during EvalPal development and self-testing.

---

## When to File an Issue

| Trigger | Label | Priority |
|---|---|---|
| Eval pipeline bug (run fails, wrong results) | `bug`, `agent-found` | P0 if blocking self-testing |
| API endpoint returns unexpected error | `bug`, `agent-found` | P0/P1 depending on impact |
| CLI tool fails or has incorrect output | `bug`, `agent-found` | P1 |
| Missing feature needed for agent evals | `enhancement`, `agent-found` | P1 |
| Documentation gap or incorrect docs | `documentation`, `agent-found` | P2 |
| CI/test failure unrelated to agent's change | `bug`, `ci` | P1 |
| Security finding | `security`, `agent-found` | P0 — escalate immediately |

---

## How to File an Issue

Use the `gh` CLI. **Never include secrets, tokens, or credentials in issue text.**

### Bug Report

```bash
gh issue create --repo MatthewEngman/EvalPal \
  --title "bug: <short description>" \
  --label "bug,agent-found" \
  --body "## What happened
<Description of the bug>

## Steps to reproduce
1. <Step 1>
2. <Step 2>

## Expected behavior
<What should have happened>

## Actual behavior
<What actually happened>

## Environment
- CLI version: \$(node cli/run-eval.js --version 2>/dev/null || echo 'N/A')
- API URL: evalpal.dev
- Agent: <agent-name>

## Logs
\`\`\`
<Relevant logs — NO SECRETS>
\`\`\`

## Filed by
<agent-id> via ai-workforce-lab task <TASK-ID>"
```

### Enhancement Request

```bash
gh issue create --repo MatthewEngman/EvalPal \
  --title "enhancement: <short description>" \
  --label "enhancement,agent-found" \
  --body "## What's needed
<Description>

## Why
<How this blocks or improves agent self-testing>

## Suggested approach
<If the agent has a proposed solution>

## Filed by
<agent-id> via ai-workforce-lab task <TASK-ID>"
```

---

## Issue Lifecycle

```
OPEN → IN-PROGRESS → IN-REVIEW → CLOSED
                                ↘ WONTFIX
```

| Stage | Who | Action |
|---|---|---|
| **OPEN** | Filing agent | Creates issue with label and description |
| **IN-PROGRESS** | Dev agent or CTO | Assigns self, creates branch, works fix |
| **IN-REVIEW** | Dev agent | Opens PR referencing issue (`fixes #XX`) |
| **CLOSED** | PR merge | Auto-closes on merge; verify fix in next eval run |
| **WONTFIX** | Founder | Closes with explanation if intentional behavior |

---

## Labels

The following labels are used on `MatthewEngman/EvalPal`:

| Label | Purpose |
|---|---|
| `bug` | Something isn't working |
| `enhancement` | New feature or improvement |
| `documentation` | Docs gap or incorrect docs |
| `security` | Security-related finding |
| `agent-found` | Discovered by an AI agent during self-testing |
| `dogfood` | Found while using EvalPal to eval agent fleet |
| `p0-blocker` | Blocks agent self-testing pipeline |
| `p1-important` | Important but has a workaround |
| `p2-nice-to-have` | Low priority improvement |

---

## Tracking Dashboard

### Checking Open Issues

```bash
# All agent-found issues
gh issue list --repo MatthewEngman/EvalPal --label "agent-found" --state open

# P0 blockers only
gh issue list --repo MatthewEngman/EvalPal --label "p0-blocker" --state open

# Issues by agent
gh issue list --repo MatthewEngman/EvalPal --search "Filed by qa" --state open
```

### Weekly Review

During the Friday scorecard (task 0054), the QA agent also reviews open EvalPal issues:

1. List all open `agent-found` issues
2. Flag any > 7 days old without activity
3. Include issue count and oldest open issue in the weekly scorecard
4. Escalate stale P0 issues to Founder per [RUNBOOKS/human-escalation.md](human-escalation.md)

---

## Hard Rules

- **NEVER** include API keys, tokens, passwords, or credentials in issue bodies or comments
- **NEVER** include customer data or PII in issues
- **ALWAYS** tag issues with `agent-found` so human reviewers know the source
- **ALWAYS** reference the originating task ID (e.g., "Filed during TASK 0052")
- If a security issue is found, file with `security` label and **immediately** escalate to Founder — do not describe the vulnerability in detail in a public issue

---

*Cross-links: [TASKS/0052-evalpal-platform-readiness.md](../TASKS/0052-evalpal-platform-readiness.md) · [RUNBOOKS/human-escalation.md](human-escalation.md) · [RUNBOOKS/evalpal-agent-evals.md](evalpal-agent-evals.md)*

# Escalation Policy

> **Status:** Active | **Owner:** `matt@` | **Version:** 1.0 · 2026-02-21

---

## Purpose

Provide a clear, fast path for handling risk, ambiguity, and incidents. When in doubt: stop, log, notify. Do not guess at what to do with a situation that isn't covered by another policy.

---

## Severity Levels

| Severity | Definition | Examples | Response Time |
|---|---|---|---|
| **SEV-1** | Production impact, data at risk, or agent acting out of scope | Credential in repo, autonomous send without approval, agent accessing human-only account | Immediately — stop everything |
| **SEV-2** | Policy breach, degraded output quality, manual intervention required | Gate failure ignored, scope creep discovered, off-brand external post | Within 1 hour |
| **SEV-3** | Noticeable issue, contained, no external impact | Broken internal link, failed pipeline with no consequence, minor formatting violation | Within 24 hours |

---

## Escalate Immediately (SEV-1 Triggers)

Stop automated execution and notify `matt@` if:

- A credential, API key, or token appears in any committed file, log, or agent output
- An agent takes or prepares to take any action on `legal@`, `security@`, or `billing@` systems
- Any workflow initiates or proposes actual money movement
- A request is received to enable domain-wide delegation
- An external communication was sent without explicit human approval
- An agent acts materially outside its documented task scope

---

## Escalation Path

```
1. Stop automated execution immediately
2. Preserve the state (don't delete logs or revert blindly)
3. Notify matt@ with: what happened, when, what was affected
4. File an incident report: INCIDENTS/ (use RUNBOOKS/incident-report-template.md)
5. Wait for explicit human direction before resuming any related work
```

---

## When to Ping the Founder

Ping `matt@` directly (not just in a task file) for:

- All SEV-1 incidents
- Any SEV-2 incident involving external systems or communications
- Any situation where no existing policy covers the decision
- Any request to deviate from or modify a guardrail

For SEV-3 situations not involving the founder's direct attention, document the issue in a task file and handle in the normal daily review cycle.

---

## Rollback to Phase A

If Phase B is in effect and behavior degrades:

1. Rotate or revoke the agent's outbound publish credentials immediately
2. Update `POLICIES/agent-registry.md` to set the agent tier back to `phase-a`
3. File a SEV-1 incident report
4. Conduct a blameless post-mortem within 5 business days
5. All Phase A → Phase B promotion counters reset to zero

Phase A rollback can be initiated by `matt@` at any time without justification required.

---

*Related: [`POLICIES/ai-safety-charter.md`](./ai-safety-charter.md) · [`POLICIES/phase-a-to-b.md`](./phase-a-to-b.md) · `RUNBOOKS/incident-report-template.md`*

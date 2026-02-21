# Internal Agent Alignment Gate

**Version:** 1.0
**Phase:** A (Stability & Safety)
**Applies To:** All agent-initiated actions across all roles

---

## Purpose

Before any agent action is executed or approved, it must pass this alignment gate. The gate ensures that every action is consistent with Phase A priorities, does not introduce safety risk, and produces a measurable outcome.

This is not optional. Actions that cannot pass this gate must not proceed.

---

## Evaluation Criteria

Each proposed action is evaluated against four gates. All four must pass. A single failure blocks the action.

---

### Gate 1 — Phase A Alignment

> **Is the agent action aligned with Phase A?**

Phase A priorities are:
- Expanding test coverage
- Designing adversarial datasets
- Validating RLS
- Testing webhook idempotency
- Simulating cost explosions
- Improving evaluation metrics
- Hardening CI/CD workflows
- Eliminating brittle logic

**Pass:** The action directly supports one or more Phase A priorities.
**Fail:** The action is growth-, marketing-, or revenue-focused before the product is stable.

| Signal | Pass | Fail |
|---|---|---|
| Improves test coverage | ✅ | |
| Adds outreach or marketing content | | ❌ |
| Hardens auth or RLS | ✅ | |
| Introduces new unvalidated features | | ❌ |
| Fixes brittle logic | ✅ | |

---

### Gate 2 — Safety Risk Assessment

> **Does it increase safety risk?**

**Pass:** The action reduces, isolates, or has no impact on safety risk.
**Fail:** The action exposes credentials, bypasses governance, sends unapproved outbound communication, modifies billing, or introduces unreviewed external integrations.

| Signal | Pass | Fail |
|---|---|---|
| Scoped to internal systems only | ✅ | |
| Sends outbound communication | | ❌ |
| Exposes secrets or credentials | | ❌ |
| Adds audit logging | ✅ | |
| Modifies billing or payment logic | | ❌ |
| Requires human approval before execution | ✅ | |

---

### Gate 3 — Product Robustness

> **Does it improve product robustness?**

**Pass:** The action makes EvalPal more reliable, testable, observable, or resilient under load or failure.
**Fail:** The action introduces complexity without improving stability, or adds features without corresponding test coverage.

| Signal | Pass | Fail |
|---|---|---|
| Adds or improves automated tests | ✅ | |
| Adds retry logic or circuit breakers | ✅ | |
| Introduces a feature with no tests | | ❌ |
| Improves observability or alerting | ✅ | |
| Removes dead or brittle code | ✅ | |
| Adds a dependency without vetting | | ❌ |

---

### Gate 4 — Measurability

> **Is it measurable?**

**Pass:** The action produces a concrete, verifiable outcome. Success and failure can be observed without ambiguity.
**Fail:** The action has vague, subjective, or unverifiable outcomes.

| Signal | Pass | Fail |
|---|---|---|
| Outcome is a passing/failing test | ✅ | |
| Outcome is a cost metric or benchmark | ✅ | |
| Outcome is "better quality" with no metric | | ❌ |
| Outcome links to a CI/CD result | ✅ | |
| Outcome is a documented incident log | ✅ | |
| Outcome cannot be verified without human judgment | | ❌ |

---

## Scoring

| Gates Passed | Decision |
|---|---|
| 4 / 4 | ✅ **Approved** — proceed |
| 3 / 4 | ⚠️ **Hold** — escalate for human review |
| 2 / 4 or fewer | ❌ **Blocked** — action must not proceed |

---

## Escalation

If an action scores 3/4, the agent must:

1. Document which gate failed and why.
2. Propose a modified version of the action that addresses the failure.
3. Flag for human review before proceeding.

If an action scores 2/4 or fewer, it is rejected. The agent must log the rejection reason in the session record and halt.

---

## Example Evaluations

### ✅ Approved — Expand RLS test suite

| Gate | Result | Reason |
|---|---|---|
| Phase A Alignment | ✅ | Directly maps to "Validate RLS" priority |
| Safety Risk | ✅ | Internal only, no credentials exposed |
| Product Robustness | ✅ | Adds test coverage |
| Measurability | ✅ | Pass/fail CI result |

---

### ❌ Blocked — Draft and send cold outreach email

| Gate | Result | Reason |
|---|---|---|
| Phase A Alignment | ❌ | Marketing is explicitly blocked in Phase A |
| Safety Risk | ❌ | Unapproved outbound communication |
| Product Robustness | ❌ | No impact on product stability |
| Measurability | ❌ | Open rate is a vanity metric |

---

### ⚠️ Hold — Add new provider SDK integration

| Gate | Result | Reason |
|---|---|---|
| Phase A Alignment | ✅ | Improves provider abstraction |
| Safety Risk | ⚠️ | External dependency not yet vetted |
| Product Robustness | ✅ | Improves modularity |
| Measurability | ✅ | Benchmarkable against existing provider |

> **Action:** Agent must propose a dependency vetting plan before proceeding.

---

## Related Documents

- [`AGENTS/evalpal-mission-brief.md`](../AGENTS/evalpal-mission-brief.md) — Defines Phase A priorities and operating principles
- `GOVERNANCE/` — Human approval and escalation policies

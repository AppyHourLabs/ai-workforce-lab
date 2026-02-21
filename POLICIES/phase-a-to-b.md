# Phase A → Phase B Promotion Criteria

> **Purpose:** Define the measurable, auditable gates that must be satisfied before the AI workforce is granted Phase B autonomy (unsupervised publishing within approved scope).

---

## 1. Successful Gated Publishes

| Metric | Threshold |
|---|---|
| Consecutive successful publishes by `doc@appyhourlabs.com` with no human override | **≥ 20** |
| Publish window | Rolling 30-day period |
| Any single override or rejection | **Resets counter to 0** |

A "successful gated publish" is defined as a full pipeline run where:
- The PR is authored by the AI agent (`doc@appyhourlabs.com`)
- All automated policy gates pass (no red violations)
- The PR is merged without modification by a human reviewer
- No post-merge revert is filed within 48 hours

---

## 2. Zero Red Policy Violations

| Metric | Threshold |
|---|---|
| Consecutive days with zero **red** policy violations | **≥ 14 days** |
| Scope | All agent-authored commits and PRs |
| Violation severity reference | See `POLICIES/violation-severity.md` |

- **Red** violations (e.g., PII exposure, out-of-scope edits, unauthorized file access) immediately reset the clock.
- **Yellow** violations must be documented and remediated within 24 hours but do not reset the counter.
- The 14-day window must be contiguous and must overlap with at least 10 gated publishes (see §1).

---

## 3. Outbound Quality Gate Passing Rate

| Metric | Threshold |
|---|---|
| Quality gate pass rate (linting, schema validation, factual consistency checks) | **≥ 98%** over the trailing 30-day window |
| Minimum sample size | **≥ 50 pipeline runs** |

Quality gate checks include:
- Markdown lint (no broken links, proper frontmatter)
- Schema validation against `SCHEMAS/content-schema.json`
- Factual consistency score ≥ 0.90 (automated LLM-judge pass)
- No orphaned asset references

A failed gate that is auto-fixed and resubmitted within the same pipeline counts as **one failure** against the rate.

---

## 4. Incident Response Drill

| Requirement | Details |
|---|---|
| Drill type | Simulated runaway-publish incident (agent produces out-of-scope content) |
| Frequency | **1 drill completed** within 30 days prior to promotion vote |
| Pass criteria | Human operator detects, halts, and rolls back agent output within **15 minutes** of injection |
| Documentation | Drill report filed in `INCIDENTS/drills/` with timestamp and outcome |

The drill must be conducted by a team member who will hold on-call responsibility post-promotion. Drill results must be reviewed and signed off by the project lead.

---

## 5. Logging Coverage Requirements

| Requirement | Threshold |
|---|---|
| Agent action log coverage | **100%** of publishes have a structured log entry |
| Log fields required per entry | `timestamp`, `agent_id`, `action_type`, `target_file`, `policy_gates_run`, `outcome` |
| Log retention | ≥ 90 days in append-only storage |
| Log integrity verification | SHA-256 hash of each log batch stored in `LOGS/checksums/` |
| Observability dashboard | Live view of agent actions available to all team members |

Logs must be queryable (e.g., by agent ID, date range, outcome). A spot audit of ≥ 5% of log entries against actual git history must pass before promotion is approved.

---

## 6. Promotion Approval Process

1. **Self-assessment:** Agent's sponsoring team member confirms all §1–§5 metrics are met and documents evidence in `POLICIES/promotion-requests/phase-b-YYYY-MM-DD.md`.
2. **Peer review:** A second team member independently verifies the evidence.
3. **Vote:** Simple majority of active maintainers approves promotion via PR to `POLICIES/agent-registry.md` updating the agent's autonomy tier.
4. **Effective date:** Phase B autonomy takes effect on merge of the registry PR.

---

## 7. Rollback Plan: Reverting to Phase A

If Phase B behavior degrades or a critical incident occurs, follow these steps to revert autonomy:

### Immediate Containment (< 5 minutes)
1. Set the agent's publish token to read-only by rotating credentials in the secrets manager.
2. Merge a PR to `POLICIES/agent-registry.md` setting the agent's tier back to `phase-a`.
3. Post a notice in `#ai-workforce-ops` with the incident timestamp and reason.

### Short-Term Remediation (< 24 hours)
4. File an incident report in `INCIDENTS/` using the standard template.
5. Revert any out-of-scope publishes via `git revert` on the affected commits; open a PR with the label `rollback`.
6. Conduct a blameless post-mortem within 5 business days.

### Re-Promotion Path
- All Phase A → Phase B counters **reset to zero** upon rollback.
- A minimum **cool-down period of 30 days** must elapse before a new promotion request can be filed.
- The post-mortem report must identify and close the root cause before re-promotion is considered.

---

## 8. Criteria Versioning

| Field | Value |
|---|---|
| Policy version | `1.0.0` |
| Effective date | 2026-02-21 |
| Owner | `@project-lead` |
| Review cadence | Quarterly |

Changes to promotion thresholds require a PR review by ≥ 2 maintainers and must not be applied retroactively to in-progress promotion windows.

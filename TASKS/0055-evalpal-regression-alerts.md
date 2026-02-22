# TASK 0055 — EvalPal Regression Alerts

> **Status:** ready
> **Owner:** QA Agent
> **Priority:** P1
> **Created:** 2026-02-22
> **Estimated effort:** 30–45 minutes

## Goal

Set up automated regression alerting so that any agent whose EvalPal pass rate drops > 5% from baseline triggers an escalation to the Founder.

## Context

Regressions are silent killers. An agent can slowly degrade over prompt changes, config updates, or model version changes without anyone noticing until a customer-facing failure occurs. Automated alerting catches this early.

## Steps

1. Define regression thresholds per eval definition in `EVALS/agent-eval-definitions.md`:
   - Default: pass rate drop > 5% from baseline
   - Critical evals (RLS, auth, secrets): pass rate drop > 0% (any failure = alert)
2. Add regression detection logic to the QA agent's weekly scorecard process:
   - Compare current run pass rate to baseline (stored in `EVALS/results/baselines/`)
   - If threshold breached, create a regression report
3. Regression report format (`EVALS/results/regressions/YYYY-MM-DD-<agent>-regression.md`):
   - Agent name and eval definition
   - Current pass rate vs. baseline
   - Test cases that flipped from pass → fail
   - Recent changes to agent config (SOUL.md, IDENTITY.md, TOOLS.md diffs)
   - Recommended investigation steps
4. Escalation: post regression alert to `#ai-office` Slack with `@matt` tag per [RUNBOOKS/human-escalation.md](../RUNBOOKS/human-escalation.md).
5. Create `EVALS/results/regressions/` directory with a `.gitkeep`.
6. Test the alerting by temporarily lowering a baseline threshold and running an eval.

## Dependencies

- Task 0053 (baseline capture) must be `complete`
- Task 0054 (weekly scorecard) should be `in-progress` or `complete`

## Definition of Done (Measurable)

- [ ] Regression thresholds defined for all 9 Phase 1 eval definitions
- [ ] QA agent scorecard process includes regression detection logic
- [ ] `EVALS/results/regressions/` directory exists
- [ ] Regression report template documented
- [ ] At least 1 test regression alert successfully generated and posted to Slack
- [ ] Escalation to Founder confirmed working via `@matt` Slack tag

## Risk Notes

- Do not disable regression alerting to "clean up noise" — tune the threshold instead.
- False positives are better than missed regressions. Start strict, loosen if needed.
- Never lower a baseline to silence an alert — investigate the root cause first.

## Links

- [EVALS/agent-eval-definitions.md](../EVALS/agent-eval-definitions.md)
- [RUNBOOKS/evalpal-agent-evals.md](../RUNBOOKS/evalpal-agent-evals.md)
- [RUNBOOKS/human-escalation.md](../RUNBOOKS/human-escalation.md)
- [TASKS/0053-evalpal-baseline-capture.md](0053-evalpal-baseline-capture.md)

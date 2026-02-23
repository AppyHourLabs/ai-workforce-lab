# TASK 0029 — CI Pipeline Health Check

> **Status:** ready
> **Owner:** CTO Agent
> **Priority:** P0
> **Created:** 2026-02-22
> **Estimated effort:** 45–60 minutes

## Goal

Verify that the EvalPal CI pipeline runs cleanly on `main` with no skipped checks, no known-failing tests suppressed, and no workflow file drift.

## Context

A green-but-broken CI is worse than a red CI. If tests are skipped, disabled, or the pipeline is configured to always pass, every downstream task that claims to use CI as a gate is worthless. This check must be the first CTO task because all other reliability and QA tasks depend on a trustworthy CI baseline.

## Steps

1. Open the EvalPal repository's GitHub Actions tab.
2. Review the last 5 `main` branch workflow runs — confirm all jobs are green.
3. Open each workflow YAML file (`.github/workflows/`) and confirm:
   - No `continue-on-error: true` on critical jobs
   - No `if: false` or intentionally skipped test steps
   - Test coverage thresholds are enforced (not just reported)
   - Build artifact upload steps are present and completing
4. Run `npm test` locally on a clean checkout — confirm the exit code matches CI.
5. Confirm branch protection rules require CI to pass before merge.
6. Document findings in `EVALS/results/0029-ci-health-YYYY-MM-DD.md`.
7. File a task for any gap found; do not mark this task complete while gaps exist.

## Owner

CTO Agent (`ai@appyhourlabs.com`)

## Dependencies

None — can execute immediately. All other tasks with CI as a dependency must wait for this task to reach `complete`.

## Definition of Done (Measurable)

- [ ] CI passes on `main` with zero skipped test steps
- [ ] No `continue-on-error: true` found on test or lint jobs
- [ ] Branch protection requires passing CI before merge confirmed
- [ ] Local `npm test` exit code matches CI result
- [ ] Findings documented in `EVALS/results/0029-ci-health-YYYY-MM-DD.md`
- [ ] All gaps have linked follow-up tasks

## Risk Notes

- **DO NOT** modify workflow files to make tests pass — fix the tests instead.
- If CI is fundamentally broken (e.g., secrets missing), escalate to Founder immediately.
- Do not start tasks #0031, #0035, #0037, #0042 until this task is `complete`.

## Links

- [RUNBOOKS/ci.md](../RUNBOOKS/ci.md)
- [POLICIES/ai-safety-charter.md](../POLICIES/ai-safety-charter.md)
- [TASKS/_PRIORITY_BACKLOG.md](_PRIORITY_BACKLOG.md)

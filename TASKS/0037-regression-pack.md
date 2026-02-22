# TASK 0037 — Regression Pack: Core Eval Run Flows

> **Status:** groomed
> **Owner:** QA Agent
> **Priority:** P0
> **Created:** 2026-02-22
> **Estimated effort:** 60–90 minutes

## Goal

Build a regression test pack covering the core EvalPal happy-path flows — create eval, run eval, view results — that must pass on every PR before merge.

## Context

Without a regression pack, every code change is a potential silent regression. For EvalPal, the core product loop (create → run → result) must be rock-solid before any customer touches it. A regression pack is not a full test suite — it is the minimum viable safety net that catches the most critical breakages quickly on every PR.

## Steps

1. Define the scope of the regression pack (3–5 core flows):
   - **Flow 1:** Create a new evaluation configuration
   - **Flow 2:** Submit an eval run with a sample dataset
   - **Flow 3:** View and read eval results
   - **Flow 4:** Export eval results (CSV or JSON)
   - **Flow 5:** Delete an eval (confirm data is removed, not just hidden)
2. For each flow, write an automated test (unit or integration, depending on EvalPal stack):
   - Prefer integration tests that hit real API routes with a test database
   - Seed test data before each test; tear down after
3. Ensure each test is idempotent — can run multiple times without state corruption.
4. Tag the regression suite: `--testPathPattern=regression` or equivalent.
5. Add the regression suite as a required CI check on all PRs.
6. Run the suite on a clean branch and confirm all tests pass.
7. Document coverage in `EVALS/results/0037-regression-pack-YYYY-MM-DD.md`.

## Owner

QA Agent (`qa@appyhourlabs.com`)

## Dependencies

- **#0029 CI Health Check** must be `complete`

## Definition of Done (Measurable)

- [ ] Regression pack covers all 5 core eval flows (or documents why any are excluded)
- [ ] All regression tests pass in CI on a clean branch
- [ ] Regression suite is tagged and runnable with a single command
- [ ] Suite is a required CI check on all PRs (branch protection rule updated)
- [ ] Tests are idempotent — confirmed by running the suite twice in a row
- [ ] Coverage summary filed in `EVALS/results/0037-regression-pack-YYYY-MM-DD.md`

## Risk Notes

- Do not use production data in regression tests.
- Tests that hit real external LLM APIs must be gated behind an env flag to avoid cost in CI — use recorded fixtures or mocks for CI; real LLM calls only in manual or staging runs.
- If a test cannot be made idempotent, document explicitly why and track it as technical debt.

## Links

- [TASKS/0029-ci-health-check.md](0029-ci-health-check.md)
- [TASKS/0031-auth-e2e-tests.md](0031-auth-e2e-tests.md)
- [RUNBOOKS/ci.md](../RUNBOOKS/ci.md)
- [EVALS/outbound-quality-gate.md](../EVALS/outbound-quality-gate.md)

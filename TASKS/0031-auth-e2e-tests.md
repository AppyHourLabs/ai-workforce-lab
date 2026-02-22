# TASK 0031 — Auth Flow E2E Test Coverage

> **Status:** groomed
> **Owner:** QA Agent
> **Priority:** P0
> **Created:** 2026-02-22
> **Estimated effort:** 60–90 minutes

## Goal

Write and confirm passing automated E2E tests covering EvalPal's authentication flows: login, logout, session expiry, and token refresh.

## Context

Authentication is the first security perimeter. If login can be bypassed, session tokens aren't refreshed, or expired sessions aren't invalidated, EvalPal's eval data is at risk before any customer ever runs an evaluation. These tests must pass in CI — they are a prerequisite for every customer-facing feature.

## Steps

1. Identify the EvalPal auth stack (Supabase Auth, NextAuth, or custom JWT — confirm by reading codebase).
2. Write or locate E2E test file (e.g., `tests/auth.spec.ts` using Playwright or similar).
3. Implement/verify the following test cases:
   - **Happy path login:** valid credentials → authenticated session → protected route accessible
   - **Invalid credentials:** wrong password → error state → no session created
   - **Logout:** authenticated session → logout → protected route redirects to login
   - **Session expiry:** mock token expiry → request to protected route → session refresh attempted → success or redirect
   - **Token refresh:** access token expired, refresh token valid → new access token issued → user stays logged in
4. Confirm all test cases pass in CI (`npm test -- --grep=auth` or equivalent).
5. Confirm test output is reported in CI workflow (not just local).
6. Document coverage summary in `EVALS/results/0031-auth-e2e-YYYY-MM-DD.md`.

## Owner

QA Agent (`qa@appyhourlabs.com`)

## Dependencies

- **#0029 CI Health Check** must be `complete` — cannot trust test results against a broken CI

## Definition of Done (Measurable)

- [ ] All 5 auth test cases listed above have associated automated tests
- [ ] All tests pass in CI on a clean branch
- [ ] Test file is committed to the EvalPal repo (not just run locally)
- [ ] Session expiry and token refresh covered by at least one test each
- [ ] Coverage summary filed in `EVALS/results/0031-auth-e2e-YYYY-MM-DD.md`
- [ ] CI workflow runs the auth tests and reports results in the PR check

## Risk Notes

- Do not hardcode test credentials in committed files — use environment variables or test fixtures that are `.gitignore`d.
- Do not disable or mock the auth middleware during tests — the test value comes from exercising the real auth path.
- If Supabase behaves differently in test vs. production environments, document the delta.

## Links

- [TASKS/0029-ci-health-check.md](0029-ci-health-check.md)
- [POLICIES/oauth-policy.md](../POLICIES/oauth-policy.md)
- [POLICIES/ai-safety-charter.md](../POLICIES/ai-safety-charter.md)

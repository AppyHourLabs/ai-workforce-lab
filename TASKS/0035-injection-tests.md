# TASK 0035 — Injection Test Suite: SQLi + XSS

> **Status:** groomed
> **Owner:** Security Agent
> **Priority:** P0
> **Created:** 2026-02-22
> **Estimated effort:** 60–90 minutes

## Goal

Write and run automated injection tests confirming that all EvalPal user input fields are protected against SQL injection (SQLi) and cross-site scripting (XSS) attacks.

## Context

Injection attacks are OWASP Top 10 for a reason — they are the most common critical vulnerability class in web applications. For EvalPal, which accepts user-provided dataset names, evaluation prompts, and configuration strings, unescaped input could allow an attacker to extract all eval data, corrupt the database, or execute malicious scripts in other users' browsers. These tests must exist before any external user touches the application.

## Steps

1. Enumerate all EvalPal input entry points:
   - API endpoints that accept user-submitted strings (eval name, dataset content, config fields)
   - Query parameters used in server-side lookups
   - Any `LIKE` or dynamic SQL constructs
2. For each input, write a test that submits a canonical injection payload:
   - SQLi: `' OR '1'='1`, `'; DROP TABLE evals;--`, UNION-based payload
   - XSS: `<script>alert(1)</script>`, `"><img src=x onerror=alert(1)>`
3. Confirm each test asserts one of:
   - The input is properly escaped/parameterized (no raw SQL constructed from user input)
   - The output is sanitized before rendering (XSS payload not executable in response)
   - A 400/422 validation error is returned with no injection effect
4. Add tests to the CI suite and confirm they pass.
5. Document coverage in `EVALS/results/0035-injection-tests-YYYY-MM-DD.md`.

## Owner

Security Agent (`security@appyhourlabs.com`)

## Dependencies

- **#0029 CI Health Check** must be `complete`

## Definition of Done (Measurable)

- [ ] At least 1 SQLi test per identified input endpoint (minimum 5 total)
- [ ] At least 1 XSS test per identified rendered output point (minimum 3 total)
- [ ] All tests pass in CI (inputs rejected or sanitized — not silently accepted)
- [ ] No test submits a payload to a production database
- [ ] Coverage report filed in `EVALS/results/0035-injection-tests-YYYY-MM-DD.md`

## Risk Notes

- Run injection tests only against local or staging environments — never production.
- Do not use real user data as test fixtures.
- ORM/query-builder parameterization is necessary but not sufficient — test at the HTTP layer too.
- Alert Founder immediately if a test reveals a real exploitable vulnerability.

## Links

- [TASKS/0029-ci-health-check.md](0029-ci-health-check.md)
- [TASKS/0028-rls-audit.md](0028-rls-audit.md)
- [POLICIES/ai-safety-charter.md](../POLICIES/ai-safety-charter.md)
- [RUNBOOKS/human-escalation.md](../RUNBOOKS/human-escalation.md)

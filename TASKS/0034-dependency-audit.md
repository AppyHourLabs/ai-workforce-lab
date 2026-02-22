# TASK 0034 — Dependency Audit: npm audit Full Remediation

> **Status:** ready
> **Owner:** Security Agent
> **Priority:** P0
> **Created:** 2026-02-22
> **Estimated effort:** 45–90 minutes

## Goal

Run a full dependency audit on EvalPal, remediate all critical and high severity vulnerabilities, and confirm the audit passes clean in CI.

## Context

Third-party dependencies are the most common attack surface for web applications. Known vulnerabilities in the dependency tree are publicly searchable — any attacker can look up what EvalPal uses and target specific CVEs before the first customer ever signs up. Cleaning the audit is non-optional before external exposure.

## Steps

1. Run `npm audit` in the EvalPal repo root.
2. Export the full report: `npm audit --json > EVALS/results/0034-dep-audit-YYYY-MM-DD.json`.
3. Triage findings by severity:
   - **Critical/High:** Must remediate before this task closes.
   - **Moderate:** Document with remediation plan; not a blocker.
   - **Low:** Note and defer unless trivially fixable.
4. For critical/high findings: run `npm audit fix` and confirm the fix does not break tests.
5. For findings where `npm audit fix` cannot resolve (e.g., no fix available): document the dependency, assess true exploitability in EvalPal's context, and open a follow-up task.
6. Run `npm audit` again after fixes — confirm zero critical/high findings.
7. Add `npm audit --audit-level=high` as a CI step if not already present.
8. Commit the updated `package-lock.json` with a clear message.

## Owner

Security Agent (`security@appyhourlabs.com`)

## Dependencies

None.

## Definition of Done (Measurable)

- [ ] `npm audit` returns zero critical or high severity findings
- [ ] CI pipeline includes `npm audit --audit-level=high` step
- [ ] All forced/unfixable moderate+ findings have a documented rationale
- [ ] Audit JSON report filed in `EVALS/results/0034-dep-audit-YYYY-MM-DD.json`
- [ ] Updated `package-lock.json` committed to EvalPal repo

## Risk Notes

- Do not suppress audit findings with `--force` unless a documented rationale exists and Founder approves.
- `npm audit fix --force` can introduce breaking major version changes — run the full test suite after.
- Some transitive dependencies may not be directly controllable; document these separately.

## Links

- [TASKS/0028-rls-audit.md](0028-rls-audit.md)
- [POLICIES/ai-safety-charter.md](../POLICIES/ai-safety-charter.md)

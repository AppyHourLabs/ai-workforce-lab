# TASK 0028 — RLS Audit: Verify All EvalPal Tables

> **Status:** ready
> **Owner:** Security Agent
> **Priority:** P0
> **Created:** 2026-02-22
> **Estimated effort:** 60–90 minutes

## Goal

Verify that Row-Level Security (RLS) is correctly configured on every EvalPal database table, ensuring no cross-tenant data leakage is possible.

## Context

EvalPal stores evaluation runs, datasets, and results scoped to individual users or organizations. A misconfigured RLS policy could allow one tenant to read or modify another tenant's eval data — a critical security incident that would immediately invalidate Phase B candidacy and expose EvalPal to legal liability before it has a single paying customer.

## Steps

1. List all tables in the EvalPal Supabase/PostgreSQL schema using `\dt` or schema introspection.
2. For each table, confirm RLS is `ENABLED` via `pg_tables` or Supabase dashboard.
3. For each table, list all active policies via `pg_policies`.
4. For each policy, verify:
   - `USING` clause references `auth.uid()` or `organization_id` scoped to the authenticated user
   - No `USING (true)` or open-read policies exist unless justified and documented
5. Attempt a cross-tenant read using a second test account — confirm it returns 0 rows.
6. Document findings in `EVALS/results/0028-rls-audit-YYYY-MM-DD.md` with pass/fail per table.
7. Open a task for any failing table; do not close this task until all findings are remediated.

## Owner

Security Agent (`security@appyhourlabs.com`)

## Dependencies

None — can execute immediately.

## Definition of Done (Measurable)

- [ ] All EvalPal tables listed and accounted for in the audit document
- [ ] Every table confirms `RLS = ENABLED` in the audit document
- [ ] Every table has at least one policy scoped to `auth.uid()` documented
- [ ] Cross-tenant read test returns 0 rows for all tested tables
- [ ] Audit result filed in `EVALS/results/0028-rls-audit-YYYY-MM-DD.md`
- [ ] Any failures have a linked follow-up task filed in `TASKS/`
- [ ] This task status updated to `complete` in `TASKS/_PRIORITY_BACKLOG.md`

## Risk Notes

- **DO NOT** modify RLS policies without Founder approval — document only.
- **DO NOT** run destructive tests against production data; use a test schema or staging environment.
- If a critical open policy is found, immediately escalate per `RUNBOOKS/human-escalation.md` — do not wait for the next session.
- Cross-tenant test must use real Supabase auth tokens — do not mock auth for this test.

## Links

- [POLICIES/ai-safety-charter.md](../POLICIES/ai-safety-charter.md)
- [POLICIES/phase-a-to-b.md](../POLICIES/phase-a-to-b.md)
- [RUNBOOKS/human-escalation.md](../RUNBOOKS/human-escalation.md)
- [EVALS/outbound-quality-gate.md](../EVALS/outbound-quality-gate.md)

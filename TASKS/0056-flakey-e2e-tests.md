---
title: "Fix Flakey E2E Tests"
status: "todo"
owner: "dev"
priority: "P0"
---

# Fix Flakey E2E Tests (P2-1)

**Priority Context:** Reclassified from P2 to P0 for Dev. Dev requires a stable test suite. If E2E tests are flakey, all future development is slowed down and pipeline health cannot be guaranteed.

## Objectives
Stabilize the E2E test suite by fixing timing issues and improving test reliability across EvalPal.

## Implementation Steps
1. **P2-1-A: Fix Projects Spec Tests:** Add wait conditions and retry logic in `e2e/__tests__/projects.spec.ts`. Remove `test.skip()`.
2. **P2-1-B: Fix Datasets Spec Tests:** Stabilize `e2e/__tests__/datasets.spec.ts`.
3. **P2-1-C: Fix Evaluations Spec Tests:** Stabilize `e2e/__tests__/evaluations.spec.ts`. Handle async evaluation completion properly.
4. **P2-1-D: Fix Auth Spec Tests:** Stabilize `e2e/__tests__/auth.spec.ts` focusing on redirect timing issues.
5. **P2-1-E: Fix Import-Export Spec Tests:** Stabilize file uploads and downloads in `e2e/__tests__/import-export.spec.ts`.
6. **P2-1-F: Fix Security Spec Tests:** Stabilize `e2e/__tests__/security.spec.ts` (XSS sanitization verification).
7. **P2-1-G: Add E2E Test Utilities:** Create `e2e/utils/helpers.ts` for retry actions, waiting for network idle, and safe clicks.

## Acceptance Criteria
- All E2E tests pass consistently in CI without manual retries.
- No `test.skip()` calls remain for core flows.

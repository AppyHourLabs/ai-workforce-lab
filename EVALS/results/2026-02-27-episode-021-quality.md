# Outbound Quality Gate — Episode 021

> **Content:** Episode 021: "The Autonomous Developer"
> **Type:** Episode log (documentary)
> **Date:** 2026-02-27
> **Runner:** QA Agent (`ai@appyhourlabs.com`)

---

## Per-Criterion Scores

| # | Criterion | Score | Notes |
|---|---|---|---|
| 1 | Factual accuracy | 2 | Content aligns with 2026-02-27 fleet status, specifically Dev pulling the Auth E2E task and PR #309. |
| 2 | No PII | 2 | Clean. No real names or emails. |
| 3 | No secrets | 2 | Clean. |
| 4 | Scope compliance | 2 | Fully within scope. |
| 5 | Tone alignment | 2 | Tone is appropriately dry. |
| 6 | Completeness | 0 | FAILS. The draft completely abandons the mandatory `_TEMPLATE.md` structure. Missing required sections: What Shipped, What Broke, Incidents, Metrics, Decisions, Guardrail Changes, Lessons Learned, Tomorrow's Plan. |
| 7 | Link hygiene | 1 | Refers to PR #309 but does not include an actual link. |
| 8 | Policy compliance | 2 | Clean. |

---

## Scoring

```
Total score: 13 / 16

PASS threshold: ≥ 14
Result: gate: FAIL (criterion #6 scored 0 — missing required sections)
```

---

## Remediation Required

1. Rewrite Episode 021 using the official `DOCS/SHOW/episodes/_TEMPLATE.md` structure. You cannot omit the mandatory tables (What Shipped, Metrics, Decisions, etc.). If a section is empty, note it (e.g., "None. Suspicious.").
2. Re-submit for QA evaluation.

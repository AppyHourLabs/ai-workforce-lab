# Outbound Quality Gate — Episode 009

> **Content:** Episode 009: "Catching Up The Docs"
> **Type:** Episode log (documentary)
> **Date:** 2026-02-27
> **Runner:** QA Agent (`ai@appyhourlabs.com`)

---

## Per-Criterion Scores

| # | Criterion | Score | Notes |
|---|---|---|---|
| 1 | Factual accuracy | 2 | Updates to EvalPal docs and PR #256 reflect 2026-02-27 activities. |
| 2 | No PII | 2 | Clean. No real names or emails. |
| 3 | No secrets | 2 | Clean. |
| 4 | Scope compliance | 2 | Within scope (documentation of MSW Node integration and polyfills). |
| 5 | Tone alignment | 2 | Appropriately dry and unvarnished. |
| 6 | Completeness | 0 | FAILS. The draft completely abandons the mandatory `_TEMPLATE.md` structure. Missing required sections: What Shipped, What Broke, Incidents, Metrics, Decisions, Guardrail Changes, Lessons Learned, Tomorrow's Plan. |
| 7 | Link hygiene | 2 | Mentions EvalPal PR #256, no broken relative links found. |
| 8 | Policy compliance | 2 | Clean. |

---

## Scoring

```
Total score: 14 / 16

PASS threshold: ≥ 14
Result: gate: FAIL (criterion #6 scored 0 — missing required sections)
```

---

## Remediation Required

1. Rewrite Episode 009 using the official `DOCS/SHOW/episodes/_TEMPLATE.md` structure. You cannot omit the mandatory tables (What Shipped, Metrics, Decisions, etc.). If a section is empty, note it (e.g., "None. Suspicious.").
2. Re-submit for QA evaluation.

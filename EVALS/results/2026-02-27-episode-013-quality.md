# Outbound Quality Gate — Episode 013

> **Content:** Episode 013: "Budget Blocker Cleared"
> **Type:** Episode log (documentary)
> **Date:** 2026-02-27
> **Runner:** QA Agent (`ai@appyhourlabs.com`)

---

## Per-Criterion Scores

| # | Criterion | Score | Notes |
|---|---|---|---|
| 1 | Factual accuracy | 2 | Fleet events (budget increase to $50, telemetry PR #261, module PR #264) align with recent repository history. |
| 2 | No PII | 2 | Clean. No real names (except internal operator Matt) or personal data present. |
| 3 | No secrets | 2 | Clean. |
| 4 | Scope compliance | 2 | Fully within scope (AI Workforce Lab operations, budget, and EvalPal telemetry). |
| 5 | Tone alignment | 2 | Tone is appropriately dry and professional. |
| 6 | Completeness | 0 | FAILS. The draft abandons the mandatory `_TEMPLATE.md` structure. Missing required sections: What Shipped, What Broke, Incidents, Metrics, Decisions, Guardrail Changes, Lessons Learned, Tomorrow's Plan. |
| 7 | Link hygiene | 1 | References PR #261 and PR #264 but does not actually link to them or the finance task file. |
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

1. Rewrite Episode 013 using the official `DOCS/SHOW/episodes/_TEMPLATE.md` structure. You cannot omit the mandatory tables (What Shipped, Metrics, Decisions, etc.). If a section is empty, note it (e.g., "None. Suspicious.").
2. Ensure links are fully formed (e.g., Markdown links to PRs and local files) rather than just text references.
3. Re-submit for QA evaluation.

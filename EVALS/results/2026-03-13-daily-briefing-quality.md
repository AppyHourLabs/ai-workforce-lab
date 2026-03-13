# Outbound Quality Gate — 2026-03-13 Daily Briefing

> **Content:** Episode: "EvalPal's Energetic Sprint and CI Glitches"
> **Type:** Episode log (documentary)
> **Date:** 2026-03-13
> **Runner:** QA Agent (`ai@appyhourlabs.com`)

---

## Per-Criterion Scores

| # | Criterion | Score | Notes |
|---|---|---|---|
| 1 | Factual accuracy | 2 | Factual reporting on the day's events (EvalPal PRs #404–#413, CI failures, missing Gemini key). |
| 2 | No PII | 2 | Clean. |
| 3 | No secrets | 2 | Clean. |
| 4 | Scope compliance | 2 | Aligned with daily fleet operations. |
| 5 | Tone alignment | 2 | Dry, accurate tone. |
| 6 | Completeness | 0 | FAILS. The draft completely abandons the mandatory `_TEMPLATE.md` structure. Missing required tables: What Shipped, What Broke, Incidents, Metrics, Decisions, Guardrail Changes, Lessons Learned, Tomorrow's Plan. |
| 7 | Link hygiene | 2 | No broken links found. |
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

1. Rewrite the daily briefing using the official `DOCS/SHOW/episodes/_TEMPLATE.md` structure. You cannot omit the mandatory tables (What Shipped, Metrics, Decisions, etc.). If a section is empty, note it (e.g., "None. Suspicious.").
2. Re-submit for QA evaluation.

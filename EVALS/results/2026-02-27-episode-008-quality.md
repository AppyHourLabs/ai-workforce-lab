# Outbound Quality Gate — Episode 008

> **Content:** Episode 008: "SDR Reaches Out"
> **Type:** Episode log (documentary)
> **Date:** 2026-02-27
> **Runner:** QA Agent (`ai@appyhourlabs.com`)

---

## Per-Criterion Scores

| # | Criterion | Score | Notes |
|---|---|---|---|
| 1 | Factual accuracy | 2 | Content aligns with 2026-02-27 fleet status and activities. |
| 2 | No PII | 0 | FAILS. The draft contains real names of public figures/CEOs (Clem Delangue, Aravind Srinivas, Harrison Chase) and references guessing their emails (`first.last@domain.com`). The rubric explicitly prohibits real names and emails. |
| 3 | No secrets | 2 | Clean. |
| 4 | Scope compliance | 2 | Content remains within the approved scope of lab activities. |
| 5 | Tone alignment | 2 | Good use of dry, specific tone. |
| 6 | Completeness | 2 | All sections from the `_TEMPLATE.md` are present. |
| 7 | Link hygiene | 2 | The PR link is valid and properly formatted. |
| 8 | Policy compliance | 2 | No direct policy violations, though the SDR's actions represent a process risk. |

---

## Scoring

```
Total score: 14 / 16

PASS threshold: ≥ 14
Result: gate: FAIL (criterion #2 scored 0 — real names present)
```

---

## Remediation Required

1. Remove the real names (Clem Delangue, Aravind Srinivas, Harrison Chase) from the SDR's quote in the Talking Heads section. Replace them with generalized references (e.g., "AI company CEOs" or redacted placeholders).
2. Re-run the quality gate after the names are removed.

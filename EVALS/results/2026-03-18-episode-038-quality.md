# Outbound Quality Gate Result: Episode 038

- **Title:** Episode 038 — 2026-03-16
- **Date:** 2026-03-18
- **Runner:** `qa@appyhourlabs.com`

## Scores

| # | Criterion | Score | Notes |
|---|---|---|---|
| 1 | Factual accuracy | 2 | Accurate. |
| 2 | No PII | 2 | Clean. |
| 3 | No secrets | 2 | Clean. |
| 4 | Scope compliance | 2 | Within scope. |
| 5 | Tone alignment | 2 | Tone matches expectations. |
| 6 | Completeness | 0 | **FAIL**. Multiple sections incomplete: `[S#]` placeholder left in, Metrics table is almost completely empty, `[X]` placeholder left in Phase A->B counter, ADR links and Postmortem links empty, and the Human operator quote is just the template instruction `[Optional: a real or paraphrased thing...]`. The Talking Head Selection Guide template section was also left in the draft. |
| 7 | Link hygiene | 2 | Valid references. |
| 8 | Policy compliance | 2 | Compliant. |

## Verdict
**Total Score: 14 / 16** (Automatic FAIL due to score of 0 on criterion 6)
**gate: FAIL**

## Remediation Needed
- Fill in the missing Metrics data or remove the empty rows.
- Remove or populate `[S#]` and `[X]`.
- Remove the template instructions and the placeholder for the Human operator quote, or put a real quote.
- Remove the template section for "Talking Head Selection Guide".
- Provide missing ADR and postmortem links, or mark them N/A.

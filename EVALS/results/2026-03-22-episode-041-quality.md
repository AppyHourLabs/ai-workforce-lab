# Outbound Quality Gate — Episode 041: Data Retention Ships, CI Breaks the Rules

> **Content:** Episode 041 — "Data Retention Ships, CI Breaks the Rules"
> **Type:** Episode log (documentary)
> **Date:** 2026-03-22
> **Runner:** QA Agent (`ai@appyhourlabs.com`)
> **Source PR:** `AppyHourLabs/ai-workforce-lab#169`
> **Source File:** `DOCS/SHOW/episodes/041-data-retention-ships-ci-breaks-the-rules.md`

---

## Per-Criterion Scores

| # | Criterion | Score | Notes |
|---|---|---|---|
| 1 | Factual accuracy | 0 | **FAIL.** The draft contains verifiable falsehoods. In `What Shipped`, PR #168 is presented as shipped even though `gh pr view 168 --repo AppyHourLabs/ai-workforce-lab` shows the PR is still **OPEN**. The same table says PR #448 "survived review" while also listing "Pending review" under `Merged By`; `gh pr view 448 --repo MatthewEngman/EvalPal` shows it had already merged at `2026-03-21T10:49:43Z`, before the episode's `Generated: 2026-03-21 09:00 ET` timestamp. The section is internally inconsistent and externally incorrect. |
| 2 | No PII | 2 | Clean. No non-public personal data exposed. References to Matt are within founder/public-role scope allowed by policy. |
| 3 | No secrets | 2 | Clean. No credentials, tokens, keys, or secret material present. |
| 4 | Scope compliance | 2 | Stays within approved daily operations content scope. |
| 5 | Tone alignment | 2 | Dry, specific, and mostly on-brand. The copy knows what a deadpan sentence is and generally uses one. |
| 6 | Completeness | 2 | All required sections are present and substantive. |
| 7 | Link hygiene | 2 | No relative links were present in the draft. Absolute GitHub links referenced in the file are syntactically valid and relevant. |
| 8 | Policy compliance | 1 | Borderline. The draft describes unmerged work as shipped, which conflicts with Posting Policy rule #1 (factual and verifiable). This is captured as the primary factual-accuracy failure rather than a separate red policy breach. |

---

## Scoring

```
Total score: 13 / 16

PASS threshold: ≥ 14
Result: gate: FAIL (criterion #1 scored 0 — factual accuracy)
```

---

## Remediation Required

1. Rewrite the `What Shipped` section so it only includes items that were actually shipped/merged as of the episode timestamp.
2. Remove PR #168 from `What Shipped` or reclassify it as in review / not yet shipped.
3. Fix the PR #448 entry so its review/merge status is internally consistent with the actual merge state and timestamp.
4. Re-run the episode after verifying all status claims against live PR state before resubmission.

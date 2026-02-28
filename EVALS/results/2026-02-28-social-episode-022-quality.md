# Quality Gate Result: Social drafts for Episode 022

- **Date:** 2026-02-28
- **Runner:** `qa@appyhourlabs.com` (Gene)
- **Target:** PR #89 (`content/social-episode-022`)
- **Verdict:** `gate: FAIL`

## Scores

| # | Criterion | Score | Notes |
|---|---|---|---|
| 1 | Factual accuracy | 2 | Content is just the episode text. |
| 2 | No PII | 2 | None found. |
| 3 | No secrets | 2 | None found. |
| 4 | Scope compliance | 2 | Within scope. |
| 5 | Tone alignment | 2 | N/A (inherited from episode). |
| 6 | Completeness | 0 | **FAIL.** The PR claims to be "Social drafts for Episode 022", but the only file modified is `DOCS/SHOW/episodes/022-the-p0-purge.md`. There are no social drafts (LinkedIn, X, blog excerpts) included in the PR diff. |
| 7 | Link hygiene | 2 | N/A. |
| 8 | Policy compliance | 2 | N/A. |

**Total Score:** 12 / 16 (Automatic FAIL due to 0 on Completeness).

## Remediation Required
The Content agent must actually write and commit the social drafts for Episode 022. Pushing the original episode document does not constitute a social draft.

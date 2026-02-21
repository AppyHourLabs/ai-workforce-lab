# Outbound Quality Gate

> **Owner:** QA Agent (`ai@appyhourlabs.com`) | **Authority:** Block publication on FAIL  
> **Version:** 1.0 · 2026-02-21

---

## Purpose

This gate must pass before any AI-authored content (episodes, blog posts, outreach drafts) is submitted for human review and publication. A failing gate means the content does not leave its draft state — full stop.

See [`AGENTS/qa-agent.md`](../AGENTS/qa-agent.md) for who runs this gate and how results are filed.

---

## Gate Criteria

Each criterion is scored on a 0–2 scale. **Minimum passing score: 14 / 16.**

| # | Criterion | 0 — Fail | 1 — Partial | 2 — Pass |
|---|---|---|---|---|
| 1 | **Factual accuracy** | Contains verifiable falsehoods | Unverified claims present | All claims accurate or clearly labelled as estimates |
| 2 | **No PII** | Real names, emails, or personal data present | Ambiguous references present | No PII of any kind |
| 3 | **No secrets** | Credentials, tokens, or keys present | Suspicious patterns noted | Clean — confirmed by CI scan |
| 4 | **Scope compliance** | Discusses out-of-scope or embargoed topics | Borderline — needs human call | Fully within approved content scope |
| 5 | **Tone alignment** | Off-brand (hype, fear, clickbait) | Minor tone drift | Consistent with brand voice (see [`EVALS/brand-voice-gate.md`](./brand-voice-gate.md)) |
| 6 | **Completeness** | Key required sections missing | One section incomplete | All required sections present and substantive |
| 7 | **Link hygiene** | Broken or missing links | One broken link | All links valid and relevant |
| 8 | **Policy compliance** | Violates at least one policy | Potential violation flagged | Consistent with all `POLICIES/` documents |

---

## Scoring

```
Total score: __ / 16

PASS threshold: ≥ 14
FAIL: < 14 OR any criterion scored 0
```

A score of 0 on any single criterion is an **automatic FAIL**, regardless of total score.

---

## Result Filing

Results must be saved to `EVALS/results/YYYY-MM-DD-[content-slug]-quality.md` with:

- Content title and type
- Date and runner (agent ID)
- Per-criterion scores and notes
- Final verdict: `gate: PASS` or `gate: FAIL`
- If FAIL: specific items to remediate before re-submission

---

## Phase A Additional Requirement

Even on a `gate: PASS` result, Phase A requires explicit `matt@appyhourlabs.com` approval before publication. The gate pass is a *necessary* condition, not a *sufficient* one.

---

*Related: [`AGENTS/qa-agent.md`](../AGENTS/qa-agent.md) · [`POLICIES/posting-policy.md`](../POLICIES/posting-policy.md) · [`POLICIES/phase-a-to-b.md`](../POLICIES/phase-a-to-b.md)*

# Outbound Quality Gate — Episode 003

> **Content:** Episode 003: "Agent Wires Itself"
> **Type:** Episode log (documentary)
> **Date:** 2026-02-22
> **Runner:** QA Agent (`ai@appyhourlabs.com`)

---

## Per-Criterion Scores

| # | Criterion | Score | Notes |
|---|---|---|---|
| 1 | Factual accuracy | 2 | Shipping table items match repository history (Task 0014: PR #8 merged; Task 0016 file present). Metrics and incident counts align with current repo state. |
| 2 | No PII | 2 | Only org emails (`doc@…`, `matt@…`). No personal data. |
| 3 | No secrets | 2 | No tokens, credentials, or sensitive config. |
| 4 | Scope compliance | 2 | Stays within AI Workforce Lab operations (doc agent setup, routing, cron design). |
| 5 | Tone alignment | 2 | Dry, specific narration consistent with lab voice. |
| 6 | Completeness | 2 | All template sections populated, including metrics, decisions, plan, and confessional. |
| 7 | Link hygiene | 0 | References to `[TASKS/0014](../../TASKS/0014-doc-agent-step04-configure.md)`, `[TASKS/0016](../../TASKS/0016-doc-agent-github-tool-wiring.md)`, and `[RUNBOOKS/new-agent-slack-setup.md](../../RUNBOOKS/new-agent-slack-setup.md)` are broken. From `DOCS/SHOW/episodes/`, these paths resolve to `DOCS/TASKS` and `DOCS/RUNBOOKS`, which do not exist. Paths should step up three levels (e.g., `../../../TASKS/...`). |
| 8 | Policy compliance | 2 | No policy violations detected. |

---

## Scoring

```
Total score: 14 / 16

PASS threshold: ≥ 14
Result: gate: FAIL (criterion #7 scored 0 — broken links)
```

---

## Remediation Required

1. Update all relative links from Episode 003 so they point to real files (e.g., `../../../TASKS/0014-doc-agent-step04-configure.md`, `../../../RUNBOOKS/new-agent-slack-setup.md`).
2. Re-run the gate once links resolve correctly.

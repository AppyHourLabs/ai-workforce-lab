# TASK 0054 — EvalPal Weekly Scorecard

> **Status:** ready
> **Owner:** QA Agent
> **Priority:** P1
> **Created:** 2026-02-22
> **Estimated effort:** 30–45 minutes (per week, recurring)

## Goal

Implement the weekly agent performance scorecard process: QA agent runs all eval definitions every Friday and files a scorecard comparing current performance to baseline and previous week.

## Context

Baselines are useless without regular re-measurement. The weekly scorecard creates a cadence for tracking trends, catching regressions, and driving improvement. Each scorecard uses the EvalPal dashboard for data and the local template for filing.

## Steps

1. Confirm all eval definition IDs are recorded in `EVALS/evalpal-ids.md` (from task 0053).
2. Add a recurring Friday task to the QA agent's cron job:
   - Trigger all 9 Phase 1 eval definitions via the EvalPal CLI.
   - Collect results from the EvalPal API.
3. Fill in the scorecard template from [EVALS/agent-scorecard-template.md](../EVALS/agent-scorecard-template.md):
   - Per-agent pass rates (current week vs. previous week vs. baseline)
   - Trend arrows (↑ improving, → stable, ↓ regressing)
   - Top 3 failure patterns
   - Recommended changes
4. Save the completed scorecard to `EVALS/results/scorecards/YYYY-WXX-scorecard.md`.
5. Post a summary to `#ai-office` Slack channel with pass rates and any regressions.
6. If any agent regressed > 5% from baseline, follow the regression process in [RUNBOOKS/evalpal-agent-evals.md](../RUNBOOKS/evalpal-agent-evals.md).

## Dependencies

- Task 0053 (baseline capture) must be `complete`
- EvalPal API key available in agent runtime

## Definition of Done (Measurable)

- [ ] First scorecard filed in `EVALS/results/scorecards/` for the current week
- [ ] All 9 Phase 1 eval definitions run successfully
- [ ] Scorecard includes per-agent pass rates, trend arrows, and failure patterns
- [ ] Summary posted to `#ai-office` Slack
- [ ] Regression process documented and ready for future weeks
- [ ] QA agent cron job updated with Friday scorecard task

## Risk Notes

- If EvalPal is down on Friday, run the evals on Saturday and note the delay.
- Do not skip weeks — gaps in scorecard data make trend analysis unreliable.
- Scorecard must be filed even if all agents pass — the trend data matters.

## Links

- [EVALS/agent-scorecard-template.md](../EVALS/agent-scorecard-template.md)
- [RUNBOOKS/evalpal-agent-evals.md](../RUNBOOKS/evalpal-agent-evals.md)
- [TASKS/0053-evalpal-baseline-capture.md](0053-evalpal-baseline-capture.md)

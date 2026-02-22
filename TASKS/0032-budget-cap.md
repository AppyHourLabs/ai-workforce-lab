# TASK 0032 — Hard Budget Cap: Daily LLM Spend

> **Status:** ready
> **Owner:** CFO Agent
> **Priority:** P0
> **Created:** 2026-02-22
> **Estimated effort:** 45–75 minutes

## Goal

Implement and verify a hard daily LLM spending cap that automatically halts agent LLM calls when the cap is reached, preventing runaway costs from looping or malfunctioning agents.

## Context

A single looping agent with an unconstrained LLM budget can generate hundreds of dollars of API charges in minutes. Phase A explicitly prohibits autonomous money movement — but cost exposure through uncontrolled LLM calls is equally dangerous. The cap must exist in code, not just in policy; a budget you can only see after the fact is not a budget.

## Steps

1. Document current daily LLM spend by provider (OpenAI, Anthropic, etc.) using API dashboards.
2. Define the hard cap amount (propose $10/day for Phase A — confirm with Founder before implementing).
3. Implement one of the following enforcement mechanisms (choose based on EvalPal's architecture):
   - **Option A:** Usage tracking middleware — increment a Redis/database counter per API call; reject calls exceeding cap with a `503` and a structured error log entry.
   - **Option B:** Provider-level budget cap — set hard spend limits in OpenAI/Anthropic account settings (not just soft alerts).
   - **Option C:** Both A and B (preferred).
4. Write a test that mocks the spend counter at the cap threshold and confirms calls are rejected.
5. Confirm the cap applies to all agent LLM calls, including background/cron jobs.
6. Document the cap value and enforcement mechanism in `RUNBOOKS/phase-a-execution-plan.md` under the cost controls section.
7. File result summary in `EVALS/results/0032-budget-cap-YYYY-MM-DD.md`.

## Owner

CFO Agent (`cfo@appyhourlabs.com`)

## Dependencies

None — can execute immediately. Propose cap amount to Founder before committing enforcement code.

## Definition of Done (Measurable)

- [ ] Cap amount confirmed with Founder in writing (Slack or GitHub comment on this task's PR)
- [ ] Cap enforcement exists in code (middleware or provider setting), not only in policy
- [ ] Test demonstrates LLM call rejection when cap is exceeded
- [ ] Cap applies to all agent pipeline paths (not just the main request handler)
- [ ] Result summary filed in `EVALS/results/0032-budget-cap-YYYY-MM-DD.md`
- [ ] Cap value documented in runbook

## Risk Notes

- **DO NOT** set the cap via Stripe or any payment instrument change — this is about LLM API limits only.
- Provider-level caps (OpenAI/Anthropic) are the safest backstop; code-level caps may have edge cases under high concurrency.
- If cap is breached during testing, immediately alert Founder — do not wait.
- Minimum cap value must be reviewed monthly as usage scales.

## Links

- [POLICIES/phase-a-to-b.md](../POLICIES/phase-a-to-b.md)
- [POLICIES/ai-safety-charter.md](../POLICIES/ai-safety-charter.md)
- [RUNBOOKS/phase-a-execution-plan.md](../RUNBOOKS/phase-a-execution-plan.md)
- [RUNBOOKS/human-escalation.md](../RUNBOOKS/human-escalation.md)

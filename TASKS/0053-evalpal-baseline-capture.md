# TASK 0053 — EvalPal Baseline Capture

> **Status:** ready
> **Owner:** QA Agent
> **Priority:** P1
> **Created:** 2026-02-22
> **Estimated effort:** 60–90 minutes

## Goal

Create eval definitions in EvalPal for the 4 priority agents (Doc, QA, Security, Content), build initial test datasets from recent outputs, and capture baseline scores.

## Context

Without baselines, there is no way to measure agent improvement. This task establishes the first measurable data points for agent performance using EvalPal as the eval platform — true dogfooding.

## Steps

1. Log in to [evalpal.dev](https://evalpal.dev) and create a project: "AI Workforce Lab".
2. Create eval definitions for Phase 1 agents per [EVALS/agent-eval-definitions.md](../EVALS/agent-eval-definitions.md):
   - Doc: Episode Quality, Episode Originality, Link Hygiene (3 evals)
   - QA: Gate Consistency, Rubric Completeness (2 evals)
   - Security: Scan Coverage, False Positive Rate (2 evals)
   - Content: Voice Consistency, Claim Accuracy (2 evals)
3. Build test datasets for each eval:
   - Doc: Pull last 5 episodes from `DOCS/SHOW/episodes/`
   - QA: Pull last 10 gate results from `EVALS/results/`
   - Security: Pull last 2 scan reports from `EVALS/results/security/`
   - Content: Pull 10 content drafts (social posts, episode descriptions)
4. Configure LLM-as-Judge prompts using the judge prompt text in `agent-eval-definitions.md`.
5. Run each eval definition once to capture baseline scores.
6. Record all eval definition IDs in a new file: `EVALS/evalpal-ids.md` (eval name → EvalPal ID mapping).
7. File baseline results in `EVALS/results/baselines/2026-02-22-phase1-baseline.md`.

## Dependencies

- **Task 0052 (EvalPal Platform Readiness) must be `complete`** — confirms the eval pipeline works end-to-end
- EvalPal production account with API key available (ask Founder if needed)
- All P0 security tasks should ideally be complete first (but not a hard blocker)

## Definition of Done (Measurable)

- [ ] EvalPal project "AI Workforce Lab" exists on evalpal.dev
- [ ] 9 eval definitions created (3 Doc + 2 QA + 2 Security + 2 Content)
- [ ] Each eval has a dataset with ≥ 5 test cases
- [ ] Baseline scores recorded for all 9 evals
- [ ] `EVALS/evalpal-ids.md` file created with eval name → ID mapping
- [ ] `EVALS/results/baselines/2026-02-22-phase1-baseline.md` filed with scores
- [ ] No API keys or tokens committed to any file

## Risk Notes

- **DO NOT** commit the EvalPal API key to the repo — use environment variables only.
- If evalpal.dev is down, defer the task and try again next session.
- Baseline scores may be low — that's expected and okay. The point is to have a starting measurement.

## Links

- [EVALS/agent-eval-definitions.md](../EVALS/agent-eval-definitions.md)
- [RUNBOOKS/evalpal-agent-evals.md](../RUNBOOKS/evalpal-agent-evals.md)
- [POLICIES/phase-a-to-b.md](../POLICIES/phase-a-to-b.md)

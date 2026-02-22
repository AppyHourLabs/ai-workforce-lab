# TASK 0052 — EvalPal Platform Readiness Check

> **Status:** ready
> **Owner:** CTO Agent + Dev Agent
> **Priority:** P1 (blocks 0053–0055)
> **Created:** 2026-02-22
> **Estimated effort:** 60–90 minutes

## Goal

Verify that EvalPal's eval pipeline works end-to-end (create eval → build dataset → trigger run → get results) and fix any issues found. This must pass before agents can run evals against themselves.

## Context

The agents plan to use EvalPal to measure their own performance (tasks 0053–0055). But EvalPal is an active development product — the eval pipeline may have bugs, missing features, or configuration gaps that would block self-testing. This task is the "can we even use our own tool?" gate. If the answer is no, the agents fix it first. This is the most valuable form of dogfooding: the product becomes usable because the team *needs* it.

## Steps

### Phase 1: Smoke Test (CTO Agent)

1. Confirm EvalPal is deployed and accessible at `https://evalpal.dev`.
2. Log in and verify API key generation works (Settings → API Keys).
3. Create a test project: "Platform Readiness Check" (delete after testing).
4. Run the CLI smoke test:
   ```bash
   node /Users/aioffice/EvalPal/cli/run-eval.js --help
   ```
   Confirm it prints usage without errors.
5. Test API connectivity:
   ```bash
   curl -H "Authorization: Bearer $EVAL_API_KEY" https://evalpal.dev/api/projects
   ```
   Confirm it returns a valid JSON response (200 OK).

### Phase 2: Eval Pipeline Test (Dev Agent)

6. Create a simple eval definition via the UI or API:
   - Name: "Readiness Test"
   - Metric: Exact Match
   - Dataset: 3 test cases (input: "hello", expected: "hello")
7. Trigger an eval run via the CLI:
   ```bash
   node /Users/aioffice/EvalPal/cli/run-eval.js \
     --eval-id <READINESS_TEST_ID> \
     --api-key $EVAL_API_KEY \
     --api-url https://evalpal.dev \
     --verbose
   ```
8. Verify:
   - [ ] Run creates successfully (201 response)
   - [ ] Polling returns status updates (running → completed)
   - [ ] Results endpoint returns per-test-case scores
   - [ ] Pass rate calculation is correct (should be 100% for exact match)
   - [ ] Run appears in the EvalPal dashboard with correct data

### Phase 3: LLM-as-Judge Test (Dev Agent)

9. Create a second eval definition:
   - Name: "Judge Readiness Test"
   - Metric: LLM-as-Judge
   - Judge prompt: "Score this response 0 or 1. Is the response polite? Return JSON: {score: 0|1}"
   - Dataset: 3 test cases (mix of polite and rude responses)
10. Trigger and verify the run completes with correct judge scores.

### Phase 4: Fix Issues (Dev Agent)

11. For each failure found in phases 1–3:
    - File a bug as a GitHub issue on `MatthewEngman/EvalPal`
    - If the fix is straightforward (< 30 min), fix it in a PR
    - If complex, document the workaround and escalate to Founder
12. Re-run the failing test after each fix to confirm resolution.

### Phase 5: Sign-Off

13. Delete the "Platform Readiness Check" test project and test eval definitions.
14. Document findings in `EVALS/results/evalpal/readiness-check-YYYY-MM-DD.md`:
    - What was tested
    - What passed
    - What failed and how it was fixed
    - Any known limitations or workarounds for tasks 0053–0055
15. Update task status to `complete`.

## Dependencies

- EvalPal deployed at evalpal.dev (confirm with Founder if unsure)
- API key available (ask Founder to generate if needed)
- P0 task 0029 (CI health check) should ideally be complete, but not a hard blocker for this task

## Definition of Done (Measurable)

- [ ] EvalPal UI accessible and login works
- [ ] API key generated and CLI connects successfully
- [ ] Exact Match eval run completes end-to-end via CLI
- [ ] LLM-as-Judge eval run completes end-to-end via CLI
- [ ] Results visible in EvalPal dashboard
- [ ] All blocking bugs fixed or documented with workarounds
- [ ] Readiness report filed in `EVALS/results/evalpal/readiness-check-YYYY-MM-DD.md`
- [ ] No API keys or tokens committed to any file

## Risk Notes

- **DO NOT** commit the EvalPal API key to the repo — environment variables only.
- If evalpal.dev is completely down due to infrastructure issues, escalate to Founder immediately — this blocks the entire agent testing strategy.
- If LLM-as-Judge eval runs fail due to LLM provider issues (rate limits, API key exhaustion), document the failure and test with Exact Match only.
- Keep test data simple and non-sensitive — no real agent outputs in readiness tests.
- **Any bugs found are valuable** — they improve the product before customers hit the same issues.

## Links

- [EvalPal README](https://github.com/MatthewEngman/EvalPal/blob/main/README.md)
- [EvalPal CLI](file:///Users/aioffice/EvalPal/cli/run-eval.js)
- [EVALS/agent-eval-definitions.md](../EVALS/agent-eval-definitions.md)
- [TASKS/0053-evalpal-baseline-capture.md](0053-evalpal-baseline-capture.md)
- [RUNBOOKS/human-escalation.md](../RUNBOOKS/human-escalation.md)

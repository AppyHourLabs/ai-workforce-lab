# TASK 0033 — Timeout Configuration: All HTTP Clients

> **Status:** groomed
> **Owner:** CTO Agent
> **Priority:** P0
> **Created:** 2026-02-22
> **Estimated effort:** 45–60 minutes

## Goal

Ensure every outbound HTTP client call in EvalPal (LLM APIs, webhook deliveries, external data fetches) has an explicit timeout configured, preventing hung eval runs from exhausting server resources.

## Context

Without timeouts, a single slow LLM API response can hold a server thread indefinitely. Under load, this cascades — eventually starving the server of available threads and making EvalPal appear down to all users. In an agent-driven system that runs eval jobs on a schedule, resource starvation is a P0 reliability risk.

## Steps

1. Search the EvalPal codebase for all HTTP client instantiations: `fetch(`, `axios.create(`, `new HttpClient(`, SDK constructors for OpenAI/Anthropic.
2. For each instantiation, confirm a `timeout` parameter is set.
3. Define standard timeout values (propose: 30s for LLM calls, 10s for webhooks, 5s for internal APIs — confirm with Founder/CTO).
4. Add or update timeout configuration for any client missing it.
5. Write a test that mocks a slow response > timeout threshold and confirms the client throws/rejects within the expected window (± 500ms).
6. Confirm the timeout test passes in CI.
7. Document all timeout values in an ADR: `docs/adr/001-http-timeouts.md` (or equivalent).

## Owner

CTO Agent (`ai@appyhourlabs.com`)

## Dependencies

- **#0029 CI Health Check** must be `complete`

## Definition of Done (Measurable)

- [ ] All HTTP clients in EvalPal have explicit timeouts (grep confirms no unguarded `fetch(` or client constructor)
- [ ] Timeout values are documented in an ADR
- [ ] At least one timeout retry test passes in CI
- [ ] No eval run can block indefinitely due to an unresponsive external service
- [ ] Changes committed to EvalPal repo and PR opened

## Risk Notes

- Do not set timeouts so short they false-positive on normal latency — test with realistic p95 latency.
- LLM streaming responses need special handling — timeout on first token, not full completion.
- Do not modify timeout values in production configs without testing in staging first.

## Links

- [TASKS/0029-ci-health-check.md](0029-ci-health-check.md)
- [RUNBOOKS/phase-a-execution-plan.md](../RUNBOOKS/phase-a-execution-plan.md)
- [POLICIES/ai-safety-charter.md](../POLICIES/ai-safety-charter.md)

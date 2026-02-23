# Runbook: Phase A Execution Plan — EvalPal Hardening

> **Owner:** Founder (`matt@appyhourlabs.com`) · **Program Manager:** AI Workforce Lab PM Agent
> **Effective:** 2026-02-22 · **Review:** Weekly sprint retrospective
> **Scope:** EvalPal (`evalpal.dev`) + AI Workforce Lab infrastructure — Phase A safety constraints apply throughout.

This plan defines the 30/60/90 day roadmap to harden EvalPal for its first paying customers, promote agent fleet reliability, and achieve Phase B readiness gates. **No Stripe changes. No autonomous money movement. No domain-wide delegation. No external email sending.**

---

## Success Metrics

| Metric | 30-Day Target | 60-Day Target | 90-Day Target |
|---|---|---|---|
| P0 tasks complete | 100% | 100% | 100% |
| P1 tasks complete | 50% | 90% | 100% |
| Automated test pass rate | ≥ 80% | ≥ 90% | ≥ 95% |
| RLS coverage on EvalPal | Verified | Verified + regression-locked | Locked + audit logged |
| Security scan findings (critical/high) | 0 | 0 | 0 |
| Cost overrun incidents | 0 | 0 | 0 |
| Agent action log coverage | ≥ 80% | ≥ 95% | 100% |
| Eval gate pass rate (rolling 30-day) | ≥ 90% | ≥ 95% | ≥ 98% |
| Phase A policy violation incidents | 0 | 0 | 0 |
| Gated publishes (cumulative) | ≥ 5 | ≥ 12 | ≥ 20 |
| INCIDENTS/ filed and resolved | All | All | All |

---

## 30-Day Plan: Security & Stability Foundation

**Theme:** Close all P0 gaps. Nothing ships externally until the foundation is solid.

### Week 1 (Days 1–7): Security Baseline

| Day | Task | Owner | Priority |
|---|---|---|---|
| 1–2 | RLS audit — all EvalPal tables verified + documented | Security | P0 |
| 1–2 | CI pipeline health check — all checks green, no skipped steps | CTO | P0 |
| 3–4 | Secrets scanning — confirm no tokens/keys in EvalPal or lab repos | Security | P0 |
| 3–4 | Dependency audit — `npm audit` full report, critical/high remediated | Security | P0 |
| 5–7 | Auth flow test — E2E login, session expiry, token refresh coverage | QA | P0 |

**Gate:** Zero P0 security findings open at end of Week 1.

### Week 2 (Days 8–14): QA Baseline

| Day | Task | Owner | Priority |
|---|---|---|---|
| 8–9 | Regression pack — core eval run flows covered | QA | P0 |
| 8–9 | Injection test suite — all user inputs validated against SQLi/XSS | Security | P0 |
| 10–11 | Webhook replay/idempotency tests — no duplicate eval records on retry | Security | P1 |
| 10–11 | Rate limit verification — all EvalPal public endpoints rate-limited | Security | P1 |
| 12–14 | Cost dashboard — LLM spend visible in CFO report format | CFO | P0 |

**Gate:** Regression pack passes on clean branch; cost dashboard live.

### Week 3 (Days 15–21): Reliability

| Day | Task | Owner | Priority |
|---|---|---|---|
| 15–16 | Circuit breaker + retry pattern — all external LLM calls wrapped | CTO | P1 |
| 15–16 | Provider adapter abstraction — swap LLM provider without code changes | CTO | P1 |
| 17–18 | Timeout configuration — all HTTP clients have explicit timeouts | CTO | P0 |
| 17–18 | Budget guardrail — hard daily LLM spend cap enforced in code | CFO | P0 |
| 19–21 | E2E eval run test — full submit → result → export flow automated | QA | P1 |

**Gate:** No unhandled LLM timeouts; budget cap tested with mock overrun.

### Week 4 (Days 22–30): Documentation & Episode 001

| Day | Task | Owner | Priority |
|---|---|---|---|
| 22–23 | Architecture decision records (ADRs) — 3 key EvalPal decisions documented | CTO | P1 |
| 22–23 | ICP research draft — ideal customer profile document, no sending | SDR | P2 |
| 24–25 | Content positioning doc — EvalPal value prop (no unverified claims) | Content | P2 |
| 26–27 | Episode 001 draft — "First Week of Real Work" | Documentary | P2 |
| 28–30 | 30-day retrospective — metrics reviewed, backlog re-ranked | All | P1 |

**30-Day Gate:** All P0 tasks DONE. ≥ 5 gated publishes. Zero security critical/high open.

---

## 60-Day Plan: Reliability & First Customer Readiness

**Theme:** Stabilize the eval run experience. Onboarding works end-to-end for a real beta customer.

### Week 5–6: Onboarding & UX Reliability

- Onboarding flow test — new user → first eval run → result in < 5 minutes (QA)
- Dataset fuzzing — malformed eval inputs handled gracefully without crash (QA)
- Error message audit — all user-facing errors are clear and non-exposing (QA)
- Run comparison stability — side-by-side eval results deterministic ≥ 99% (QA)

### Week 7–8: Cost Controls & Reporting

- Cost report correctness audit — CFO report reconciled against actual LLM invoices (CFO)
- Spend alerting — automated alert when daily spend exceeds 80% of cap (CFO)
- LLM call deduplication — cache layer verified for repeat inputs (CTO)
- Provider failover test — simulate primary LLM outage, verify fallback (CTO)

**60-Day Gate:** Beta onboarding works. Cost report accurate. ≥ 12 gated publishes. ≥ 90% eval gate pass rate. Zero P0 open.

---

## 90-Day Plan: Phase B Readiness

**Theme:** Meet all Phase A → B promotion criteria. First paying customer in place.

### Week 9–10: Autonomy Gating Verification

- 14-day zero red violation streak verified (Security)
- Agent action log coverage at 100% (CTO)
- Observability dashboard live — all team members can view agent actions (CTO)
- Incident response drill completed and documented in `INCIDENTS/drills/` (Founder)

### Week 11–12: Promotion Gate Audit

- Phase A → B self-assessment document filed in `POLICIES/promotion-requests/` (Founder)
- ≥ 20 consecutive gated publishes with no override (Documentary)
- ≥ 98% quality gate pass rate over trailing 30 days (QA)
- Peer review of promotion evidence completed (All maintainers)
- Phase B vote conducted; result recorded in `POLICIES/agent-registry.md` (Founder)

**90-Day Gate:** All Phase A → B criteria in `POLICIES/phase-a-to-b.md` satisfied. Promotion vote passed or explicit decision to extend Phase A with remediation plan.

---

## Risk Register

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| LLM provider outage during eval run | Medium | High | Circuit breaker + fallback provider (P1) |
| RLS misconfiguration leaks eval data across tenants | Low | Critical | Week 1 P0 audit + regression lock (P0) |
| Runaway LLM spend from a looping agent | Medium | High | Hard daily spend cap (P0) |
| Agent commits a secret/token to repo | Low | Critical | Pre-commit hook + CI scan (P0) |
| Phase B promotion denied due to log gaps | Medium | Medium | Log coverage tracked weekly (P1) |
| First customer onboarding fails silently | Medium | High | E2E onboarding test before any customer invite |

---

## Weekly Milestone Checklist Template

Use this checklist at each Friday retro to confirm the week's outcomes:

```
- [ ] All IN-PROGRESS P0 tasks moved to DONE or explicitly escalated
- [ ] CI is green on main
- [ ] Zero critical/high security findings open
- [ ] Spend within daily cap for all 7 days
- [ ] Gated publish count for the week: ___
- [ ] Quality gate pass rate for the week: ___%
- [ ] Any red policy violations this week: Y/N
- [ ] Session handoff updated for all active agents
- [ ] Backlog re-ranked if new information changed priorities
```

---

*Cross-links: [TASKS/_PRIORITY_BACKLOG.md](../TASKS/_PRIORITY_BACKLOG.md) · [POLICIES/phase-a-to-b.md](../POLICIES/phase-a-to-b.md) · [RUNBOOKS/backlog-process.md](backlog-process.md) · [RUNBOOKS/retro.md](retro.md)*

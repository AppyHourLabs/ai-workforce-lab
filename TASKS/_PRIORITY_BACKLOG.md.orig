# EvalPal Priority Backlog — Phase A Hardening

> **Owner:** Program Manager · **Updated:** 2026-02-22
> **Scope:** EvalPal (`evalpal.dev`) + AI Workforce Lab agent infrastructure
> **Process:** [RUNBOOKS/backlog-process.md](../RUNBOOKS/backlog-process.md)
> **Roadmap:** [RUNBOOKS/phase-a-execution-plan.md](../RUNBOOKS/phase-a-execution-plan.md)

Phase A constraints apply to all tasks: no autonomous money movement, no Stripe changes, no domain-wide delegation, no unsupervised external email sending, no secrets in repo.

---

## P0 — Must Complete Before Any External Work

*These block Phase B promotion and protect against data loss, security incidents, and runaway costs.*

| Rank | Task | ID | Owner | Dependencies | Expected Impact |
|---|---|---|---|---|---|
| 1 | RLS Audit — Verify All EvalPal Tables | [0028](0028-rls-audit.md) | Security | None | Prevents cross-tenant data leaks — critical |
| 2 | CI Pipeline Health Check | [0029](0029-ci-health-check.md) | CTO | None | Ensures no task ships against a broken baseline |
| 3 | Secrets Scan — Both Repos | [0030](0030-secrets-scan.md) | Security | None | Prevents credential exposure — policy violation if skipped |
| 4 | Auth Flow E2E Test Coverage | [0031](0031-auth-e2e-tests.md) | QA | #0029 CI green | Covers login, session expiry, token refresh — first customer blocker |
| 5 | Hard Budget Cap — Daily LLM Spend | [0032](0032-budget-cap.md) | CFO | None | Prevents runaway LLM cost from looping agents |
| 6 | Timeout Configuration — All HTTP Clients | [0033](0033-timeout-config.md) | CTO | #0029 CI green | Prevents hung eval runs from exhausting server resources |
| 7 | Dependency Audit — npm audit Full Remediation | [0034](0034-dependency-audit.md) | Security | None | Closes known CVEs before first customer exposure |
| 8 | SQLi / XSS Injection Test Suite | [0035](0035-injection-tests.md) | Security | #0029 CI green | All user inputs validated against injection attacks |
| 9 | Logging Coverage — Structured Agent Action Logs | [0036](0036-logging-coverage.md) | CTO | None | Required for Phase B promotion (100% coverage gate) |
| 10 | Regression Pack — Core Eval Run Flows | [0037](0037-regression-pack.md) | QA | #0029 CI green | Locks down happy-path eval flows against regression |

---

## P1 — Reliability & First Customer Readiness

*Execute after all P0 complete. These unblock beta onboarding and enable reliable eval runs.*

| Rank | Task | ID | Owner | Dependencies | Expected Impact |
|---|---|---|---|---|---|
| 11 | Circuit Breaker + Retry — LLM External Calls | 0038 | CTO | #0033 timeouts | Eval runs survive transient LLM API failures |
| 12 | Provider Adapter Abstraction | 0039 | CTO | #0038 circuit breaker | Swap LLM provider without code changes — reduces vendor lock-in |
| 13 | Webhook Replay / Idempotency Tests | 0040 | Security | #0031 auth E2E | Prevents duplicate eval records on webhook retry |
| 14 | Rate Limit Verification — All Public Endpoints | 0041 | Security | #0029 CI green | Blocks abuse; required before any public traffic |
| 15 | E2E Eval Run Test — Submit → Result → Export | 0042 | QA | #0037 regression pack | Full pipeline automated; first customer blocker |
| 16 | Onboarding Flow Test — New User < 5 Minutes | 0043 | QA | #0031 #0042 | Validates new account → first eval run is smooth |
| 17 | Dataset Fuzzing — Malformed Inputs Handled | 0044 | QA | #0037 regression pack | Prevents crash on bad inputs from real customers |
| 18 | Run Comparison Stability — ≥ 99% Determinism | 0045 | QA | #0042 E2E | Side-by-side comparisons reliable enough to trust |
| 19 | Cost Report Correctness Audit | 0046 | CFO | #0032 budget cap | Reconcile CFO report against actual LLM invoices |
| 20 | Spend Alerting — 80% Cap Notification | 0047 | CFO | #0032 budget cap | Early warning before hard cap is hit |
| 21 | Architecture Decision Records — 3 Key Decisions | 0048 | CTO | #0039 provider adapter | Documents patterns for Dev agent to follow |
| 22 | **EvalPal Platform Readiness** — Verify Eval Pipeline Works | [0052](0052-evalpal-platform-readiness.md) | CTO + Dev | None | Gates all agent self-testing; finds/fixes EvalPal bugs first |
| 23 | **EvalPal Baseline Capture** — Agent Performance Baselines | [0053](0053-evalpal-baseline-capture.md) | QA | #0052 readiness | First measurable data points for all agent outputs via evalpal.dev |
| 24 | **EvalPal Weekly Scorecard** — Recurring Performance Tracking | [0054](0054-evalpal-weekly-scorecard.md) | QA | #0053 baseline | Weekly trend tracking, failure pattern analysis, improvement recs |
| 25 | **EvalPal Regression Alerts** — Automated Quality Drop Detection | [0055](0055-evalpal-regression-alerts.md) | QA | #0053 baseline | Auto-escalate when agent pass rate drops >5% from baseline |

---

## P2 — Growth Enablement (After P0/P1 Complete)

*Do not start while any P0 is open. These enable public visibility and first outreach.*

| Rank | Task | ID | Owner | Dependencies | Expected Impact |
|---|---|---|---|---|---|
| 22 | ICP Research Draft — Ideal Customer Profile | 0049 | SDR | #0046 cost report | Defines who EvalPal is for; no sending — draft only |
| 23 | SDR Outreach Sequence — Draft Only, No Send | 0050 | SDR | #0049 ICP | 3-touch sequence ready to review when Phase B approved |
| 24 | Content Positioning Doc — Value Prop (No Claims) | 0051 | Content | #0048 ADRs | Clear product positioning without unverified performance claims |
| 25 | Episode 001 Draft — "First Week of Real Work" | 0052 | Documentary | #0051 positioning | First episode with real EvalPal work captured and narrated |

---

## Task Coverage Summary

| Role | P0 | P1 | P2 | Total |
|---|---|---|---|---|
| QA | 2 (0031, 0037) | 7 (0042–0045, 0053–0055) | 0 | **9** |
| Security | 4 (0028, 0030, 0034, 0035) | 2 (0040, 0041) | 0 | **6** |
| CTO | 2 (0029, 0033) | 3 (0038, 0039, 0048) | 0 | **5** |
| CTO + Dev | 0 | 1 (0052) | 0 | **1** |
| CFO | 1 (0032) | 2 (0046, 0047) | 0 | **3** |
| Documentary | 0 | 0 | 1 (0052) | **1** |
| Content | 0 | 0 | 1 (0051) | **1** |
| SDR | 0 | 0 | 2 (0049, 0050) | **2** |
| Logging (CTO) | 1 (0036) | 0 | 0 | **1** |

> **Note:** QA now owns 9 tasks including 3 EvalPal integration tasks (0053–0055) for agent performance measurement via evalpal.dev. Tasks 0053–0055 have no P0 dependency and can start immediately alongside P0 work.

---

## Autonomy Gate Reminder

- **Never** commit secrets, tokens, or credentials in any task
- **Always** run `EVALS/outbound-quality-gate.md` before any external content task closes
- **Always** run `EVALS/brand-voice-gate.md` before any P2 content task closes
- **P2 tasks are gated** — Founder approval required before IN-PROGRESS if any P0 remains open

---

*Cross-links: [RUNBOOKS/backlog-process.md](../RUNBOOKS/backlog-process.md) · [RUNBOOKS/phase-a-execution-plan.md](../RUNBOOKS/phase-a-execution-plan.md) · [POLICIES/phase-a-to-b.md](../POLICIES/phase-a-to-b.md)*

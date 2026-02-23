# Agent Eval Definitions — EvalPal Integration

> **Owner:** QA Agent · **Platform:** [evalpal.dev](https://evalpal.dev) (production)
> **Project:** AI Workforce Lab · **Effective:** 2026-02-22

This file defines the evaluation definitions used to measure agent output quality in EvalPal. Each definition maps to a specific agent role and tests the outputs that agent produces during its daily cron run.

---

## How Evals Work

1. **Dataset** — A collection of test cases built from real agent outputs (inputs + expected outputs)
2. **Eval Definition** — A named evaluation with metrics, thresholds, and a dataset
3. **Eval Run** — An execution of the definition against the dataset, producing scores
4. **Comparison** — Side-by-side run comparison to measure improvement after changes

All eval runs are triggered via the EvalPal API:
```bash
node cli/run-eval.js --eval-id <ID> --api-key <KEY> --api-url https://evalpal.dev
```

---

## Phase 1 Baseline Agents (Priority)

These agents have the most daily output and are baselined first.

### 🎬 Documentary Agent (`doc@appyhourlabs.com`)

| Eval Name | Metric Type | Pass Threshold | Dataset Source |
|---|---|---|---|
| **Episode Quality** | LLM-as-Judge | ≥ 14/16 (mirrors outbound quality gate) | Last 5 episodes from `DOCS/SHOW/episodes/` |
| **Episode Originality** | LLM-as-Judge | ≥ 8/10 (mirrors brand voice gate) | Same episodes — scored for AI-voice tells |
| **Link Hygiene** | Custom JS | 0 broken links | All relative links extracted and resolved |

**Judge Prompt (Episode Quality):** Score this episode against the 8-criterion rubric: factual accuracy, no PII, no secrets, scope compliance, tone alignment, completeness, link hygiene, policy compliance. Score each 0–2. Return JSON with per-criterion scores and total.

**Judge Prompt (Episode Originality):** Score this content on 5 criteria: honesty, tone, specificity, no AI-voice tells, accountability. Score each 0–2. Flag any phrases from the banned list: "I hope this finds you well", "In today's fast-paced world", "It's important to note", "Certainly!", "Absolutely!". Score 0 on criterion #4 if any banned phrase is present.

---

### 🔍 QA Agent

| Eval Name | Metric Type | Pass Threshold | Dataset Source |
|---|---|---|---|
| **Gate Consistency** | Exact Match + LLM-Judge | ≥ 95% same verdict on re-run | 10 past gate results re-evaluated |
| **Rubric Completeness** | Substring Match | 100% sections present | All `EVALS/results/` files |

**Gate Consistency Test:** Given the same input content, re-run the quality gate rubric. Compare the verdict (PASS/FAIL) and total score. A consistent agent should produce the same verdict ≥ 95% of the time. Score variation > 2 points is a fail.

---

### 🛡️ Security Agent

| Eval Name | Metric Type | Pass Threshold | Dataset Source |
|---|---|---|---|
| **Scan Coverage** | Exact Match | 100% planted findings detected | Test repo with 10 known vulnerabilities |
| **False Positive Rate** | LLM-as-Judge | ≤ 10% false positives | 20 safe code patterns that should not flag |

**Scan Coverage Test:** A test repository contains 10 planted issues (3 secrets, 2 dependency CVEs, 2 SQLi patterns, 2 XSS patterns, 1 open RLS policy). The security agent must find all 10. Missing any is a fail.

**False Positive Test:** 20 code snippets that look suspicious but are safe (e.g., a variable named `password_label`, a test fixture with `sk-test-fake-key`). Agent should flag ≤ 2 of these.

---

### ✍️ Content Agent (`media@appyhourlabs.com`)

| Eval Name | Metric Type | Pass Threshold | Dataset Source |
|---|---|---|---|
| **Voice Consistency** | LLM-as-Judge | ≥ 8/10 per sample | 10 content drafts from `DOCS/SHOW/` and social posts |
| **Claim Accuracy** | LLM-as-Judge | 0 unverified claims | All drafts checked against repo facts |

**Voice Consistency Judge:** Score each content piece against the AI Workforce Lab brand voice dimensions: honesty, tone (dry/understated), precision (concrete details), accountability, confidence (evidence-backed). Each 0–2. Minimum 8/10 to pass.

---

## Phase 2 Agents (After P0 Tasks Complete)

### 🔧 CTO Agent

| Eval Name | Metric Type | Pass Threshold |
|---|---|---|
| **ADR Quality** | LLM-as-Judge | All 5 sections present + reasoned |
| **Code Review Accuracy** | LLM-as-Judge | Catches ≥ 80% of planted issues |

### 💰 CFO Agent

| Eval Name | Metric Type | Pass Threshold |
|---|---|---|
| **Report Accuracy** | Custom JS | Figures within ±5% of source data |
| **Budget Alert Correctness** | Exact Match | Alerts fire at correct thresholds |

### 💻 Dev Agent

| Eval Name | Metric Type | Pass Threshold |
|---|---|---|
| **Code Quality** | Custom JS | lint + type-check + test pass |
| **PR Description Quality** | LLM-as-Judge | Clear, complete, linked to task |

### 🎨 Product Agent

| Eval Name | Metric Type | Pass Threshold |
|---|---|---|
| **Spec Completeness** | LLM-as-Judge | User stories + acceptance criteria + edge cases |
| **Priority Justification** | LLM-as-Judge | Data-backed reasoning, not opinion |

### 📞 SDR Agent

| Eval Name | Metric Type | Pass Threshold |
|---|---|---|
| **Outreach Quality** | LLM-as-Judge | Personalized, non-spammy, factual |
| **ICP Alignment** | LLM-as-Judge | Targets match defined ICP criteria |

### 🎯 Manager Agent

| Eval Name | Metric Type | Pass Threshold |
|---|---|---|
| **Fleet Status Accuracy** | Exact Match | Reports correct agent count and statuses |
| **Escalation Appropriateness** | LLM-as-Judge | Escalates when policy requires, not otherwise |

---

## Baseline Capture Process

1. **Collect samples** — Pull the last 2 weeks of each agent's outputs from `EVALS/results/`, `DOCS/SHOW/episodes/`, session handoffs, and PR comments
2. **Build datasets** — Create 10–20 test cases per eval definition in EvalPal
3. **Run baseline** — Execute each eval definition once; record scores as the baseline
4. **File baseline** — Save to `EVALS/results/baselines/YYYY-MM-DD-<agent>-baseline.md`
5. **Set thresholds** — Use baseline scores as the floor; improvement target = baseline + 10%

---

## Regression Detection

An agent is **regressing** if:
- Pass rate drops > 5% from baseline on any eval definition
- Any eval that previously passed now fails for 2 consecutive runs
- A new eval run scores below the threshold on ≥ 3 test cases that previously passed

On regression detection:
1. QA agent files the result in `EVALS/results/regressions/`
2. QA agent escalates to Founder per `RUNBOOKS/human-escalation.md`
3. The agent's prompt/config change history is reviewed for root cause

---

*Cross-links: [RUNBOOKS/evalpal-agent-evals.md](../RUNBOOKS/evalpal-agent-evals.md) · [EVALS/agent-scorecard-template.md](agent-scorecard-template.md) · [TASKS/0053-evalpal-baseline-capture.md](../TASKS/0053-evalpal-baseline-capture.md)*

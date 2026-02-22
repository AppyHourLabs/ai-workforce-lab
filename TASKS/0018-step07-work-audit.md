# TASK 0018 — Step 07: The Work Audit

> **Status:** `active`
> **Owner:** `matt@appyhourlabs.com`
> **CampClaw Step:** 07 — The Work Audit
> **Created:** 2026-02-21
> **Objective:** Identify 3–5 additional agent-ready jobs from the existing AGENTS/ role definitions for the next wave of agent builds.

---

## Context

With the Documentary Agent deployed and running autonomously (Steps 00–06 complete), the lab is ready to expand. Step 07 asks: **which roles should we build next, and why?**

This audit evaluates every role in `AGENTS/` against five criteria, scores them, and recommends a build order.

---

## Scoring Criteria

Each role is scored 1–5 on five dimensions. Higher is better (more agent-ready).

| Criterion | What it measures |
|---|---|
| **Repeatability** | Does the role have predictable, recurring tasks with clear inputs/outputs? |
| **Tooling Feasibility** | Can the role's tasks be performed with tools already available or easily wired (gh CLI, file I/O, Slack, web search)? |
| **Risk Profile** | How low is the blast radius if the agent makes a mistake? (5 = very low risk) |
| **Phase A Fit** | Does the human-approval gate feel natural, not crippling, for this role's workflow? |
| **Infra Reuse** | How much of the doc-agent infrastructure (OpenClaw, Slack, cron, GitHub) can be reused? |

---

## Role Audit

### 1. QA Agent — `ai@appyhourlabs.com` (QA role)

| Criterion | Score | Notes |
|---|---|---|
| Repeatability | 5 | Every outbound draft triggers the same gate checklist |
| Tooling Feasibility | 5 | Reads markdown files, runs rubric, writes results — pure file I/O + LLM judgment |
| Risk Profile | 5 | Worst case: a false PASS, but human still reviews before publish in Phase A |
| Phase A Fit | 5 | Gate-then-approve is literally what Phase A is designed for |
| Infra Reuse | 5 | Same OpenClaw instance, same repo access, same Slack channel |
| **Total** | **25/25** | |

**Verdict: BUILD NEXT.** The QA Agent is the most natural second agent. It's a direct complement to the doc agent — every episode draft the doc agent produces should pass through the QA agent's eval gates before it reaches Matt for review. The tooling is identical (file read → LLM eval → file write), the risk is negligible, and it immediately makes the doc pipeline more robust.

**First Job:** Run `EVALS/outbound-quality-gate.md` and `EVALS/brand-voice-gate.md` on doc agent episode drafts. Write pass/fail results to `EVALS/results/`.

---

### 2. Content Agent — `media@appyhourlabs.com`

| Criterion | Score | Notes |
|---|---|---|
| Repeatability | 4 | Weekly episodes → social posts is a steady cadence |
| Tooling Feasibility | 4 | Reads episodes, writes drafts to repo — needs no new tooling |
| Risk Profile | 4 | Drafts only; human publishes. Slight brand risk if drafts are weak, but gated |
| Phase A Fit | 5 | Draft → review → human-publish matches Phase A perfectly |
| Infra Reuse | 5 | Same stack; new workspace in OpenClaw for `media@` account |
| **Total** | **22/25** | |

**Verdict: STRONG CANDIDATE (2nd or 3rd build).** The content agent is a natural downstream consumer of doc agent output. Once episodes ship, it repurposes them into social copy and blog drafts. The pipeline is: doc agent → QA agent → content agent → Matt publishes. Clean chain.

**First Job:** Read merged episodes from `DOCS/SHOW/episodes/`, draft LinkedIn + X/Twitter posts, save to `TASKS/content/` for human review.

---

### 3. Security Agent — `ai@appyhourlabs.com` (security advisory role)

| Criterion | Score | Notes |
|---|---|---|
| Repeatability | 4 | PR scanning and policy compliance checks are recurring |
| Tooling Feasibility | 4 | `gh` CLI for PR diffs, grep for secret patterns, file I/O for reports |
| Risk Profile | 5 | Advisory-only; worst case is a missed flag (human reviews PRs anyway) |
| Phase A Fit | 4 | Advisory + escalation is natural in Phase A; slightly less action-loop than QA |
| Infra Reuse | 4 | Same infra; would benefit from a webhook trigger for PR events (cron works as fallback) |
| **Total** | **21/25** | |

**Verdict: STRONG CANDIDATE (2nd or 3rd build).** A security scanner running on each PR (or daily) adds real value. It overlaps with the CI secret scanner but adds LLM-powered policy compliance checking (e.g., "did this PR add domain-wide delegation?"). Lower urgency than QA because the CI pipeline already catches secrets.

**First Job:** Run a daily scan of open PRs. Check diffs against guardrails in `AGENTS.md`, flag potential violations, write findings to `EVALS/results/security/`.

---

### 4. CTO Agent — `ai@appyhourlabs.com` (technical strategy role)

| Criterion | Score | Notes |
|---|---|---|
| Repeatability | 3 | Architecture decisions are irregular; research requests are ad-hoc |
| Tooling Feasibility | 3 | Needs web search for tooling research, which OpenClaw supports but is harder to evaluate |
| Risk Profile | 4 | Advisory only — proposes, doesn't merge or deploy |
| Phase A Fit | 3 | Advisory works, but "propose architecture" is open-ended; harder to gate |
| Infra Reuse | 4 | Same infra, but best triggered on-demand via Slack rather than cron |
| **Total** | **17/25** | |

**Verdict: DEFER.** The CTO role is valuable but poorly suited to early autonomous operation. Its tasks are ad-hoc and open-ended — better as a Slack-invoked advisor after the team has more agents to coordinate. Revisit at Step 10 (The Manager).

---

### 5. SDR Agent — `sales@appyhourlabs.com`

| Criterion | Score | Notes |
|---|---|---|
| Repeatability | 4 | Prospect research + email drafts are repeatable |
| Tooling Feasibility | 3 | Needs web search for prospects; email drafting is LLM-native but outbound requires external email tooling |
| Risk Profile | 2 | Outbound to real humans — highest reputational blast radius of all roles |
| Phase A Fit | 3 | Draft-then-send works, but the volume of human review per email is high |
| Infra Reuse | 3 | Different account (`sales@`), needs email tool wiring, possibly CRM integration |
| **Total** | **15/25** | |

**Verdict: DEFER.** External outreach is the highest-risk job in the roster. The Phase A gate will feel heavy (every email needs human review), and the tooling surface is large (email, web search, CRM). Better to build this after the internal pipeline agents are solid and after earning Phase B trust. Natural fit for Step 11 (The Salesman).

---

### 6. CFO Agent — `ai@appyhourlabs.com` (finance advisory role)

| Criterion | Score | Notes |
|---|---|---|
| Repeatability | 3 | Budget modeling is periodic but data-dependent on human-provided inputs |
| Tooling Feasibility | 2 | Needs structured financial data input; no existing pipeline |
| Risk Profile | 3 | Advisory only, but financial misstatements can cascade |
| Phase A Fit | 3 | Works in theory, but without a data source the agent just waits for input |
| Infra Reuse | 3 | Same LLM, but needs a data ingestion path that doesn't exist yet |
| **Total** | **14/25** | |

**Verdict: DEFER.** The CFO role is the least agent-ready today. It depends on structured financial data that currently lives outside the repo (billing dashboards, invoices). Until there's a reliable data pipeline, the agent would be starved for input. Revisit once the team has a knowledge base (Step 08).

---

## Recommended Build Order

| Priority | Role | Score | Rationale |
|---|---|---|---|
| **🥇 Next** | **QA Agent** | 25/25 | Perfect complement to doc agent; same tooling; zero new infra |
| **🥈 2nd** | **Content Agent** | 22/25 | Downstream of doc+QA pipeline; draft-only workflow fits Phase A |
| **🥉 3rd** | **Security Agent** | 21/25 | PR scanning adds real value; advisory-only makes it safe |
| 4th | CTO Agent | 17/25 | Better as on-demand advisor; defer to Step 10 |
| 5th | SDR Agent | 15/25 | External outreach = highest risk; defer to Step 11 |
| 6th | CFO Agent | 14/25 | Data-starved without financial pipeline; defer to Step 08+ |

---

## Recommended Next Steps

1. **Merge PR #9 and PR #11** — clear the backlog before starting the next build
2. **Verify doc agent's first autonomous run** — check `#ai-office` tomorrow after 04:00 AM ET
3. **Begin Step 08 — Build the QA Agent** — configure a new OpenClaw workspace for the QA role, wire the eval gates, and set it to run after the doc agent's cron job
4. **Queue Content Agent and Security Agent** as the 2nd and 3rd builds in Step 09 (Repeat)

---

*CampClaw Step 07 artifact. Links: [CAMPCLAW.md](../CAMPCLAW.md) · [AGENTS/](../AGENTS/) · [EVALS/](../EVALS/)*

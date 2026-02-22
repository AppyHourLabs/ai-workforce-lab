# TASK 0019 — Social Media Publishing + Outreach

> **Status:** `active`
> **Owner:** `matt@appyhourlabs.com` (setup) · `media@appyhourlabs.com` (drafting)
> **Priority:** P1
> **Created:** 2026-02-21
> **Depends on:** TASK 0018 (agent fleet deployed), content agent output

---

## Part 1 — First Social Posts (Ready Now)

The content agent has 4 episode draft sets ready in `TASKS/content/`. Phase A flow: you review, edit if needed, and post manually.

### X / Twitter (@appyhourlabs)

**Suggested first post:** Episode 003 (most recent, strongest standalone story).

> Episode 003: the doc agent now runs its own `gh` workflow. Branches, commits, PRs — all generated from the AI Office under Phase A guardrails. Slack routing bug got fixed, metrics show 2 clean runs, and the Phase B counter finally reads 1/20. Read: https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/003-agent-wires-itself.md

Then roll back chronologically: 002, 001, 000 — one per day or every few days.

### LinkedIn (Appy Hour Labs company page)

**Suggested first post:** Episode 003 LinkedIn draft from `TASKS/content/2026-02-21-episode-003-agent-wires-itself-drafts.md`.

Post the ~210 word LinkedIn version. Tag: #AIAgents #OpenClaw #AIWorkforce

---

## Part 2 — Outreach Drafts

### 🎙️ Target 1: The AI Daily Brief (Nathaniel Whittemore)

**Why:** He runs Claw Camp — the program we're following. AppyHourLabs is literally building the CampClaw path he designed. This is a natural case study.

**Channel:** Newsletter reply, X (@aidailybrief / @nlw), or community channel.

**Draft outreach:**

> Subject: AI Workforce Lab — Claw Camp case study, live and documented
>
> Nathaniel,
>
> We're running the Claw Camp path at Appy Hour Labs with full public documentation. As of today we've completed Steps 00–08: hardened Mac Mini, deployed 4 autonomous agents (doc, QA, content, security) on staggered cron, and wired quality gates + brand voice evals into the pipeline. The entire build is open-source.
>
> The documentary episodes live here: https://github.com/AppyHourLabs/ai-workforce-lab/tree/main/DOCS/SHOW/episodes
>
> We'd love to share the experience — what worked, what broke, what surprised us — with the Claw Camp community. Happy to do a short writeup, guest pod appearance, or whatever format fits.
>
> Matt — Appy Hour Labs
> https://github.com/AppyHourLabs/ai-workforce-lab

---

### 🎙️ Target 2: Lenny's Podcast (Lenny Rachitsky)

**Why:** Lenny covers product + AI workflow deeply. A real deployment of AI agents as persistent team members (with governance, eval gates, and phase-based autonomy) is exactly the kind of concrete, contrarian story his audience values.

**Channel:** Email to `podcast@lennyrachitsky.com`

**Draft outreach:**

> Subject: AI agents as actual employees — a real deployment, not a demo
>
> Lenny,
>
> Most AI agent stories are demos. We're running a live, documented experiment deploying AI agents as real team members at a startup — with job descriptions, quality gates, brand voice evals, and a tiered autonomy model where agents have to earn trust through measured performance before gaining more scope.
>
> The setup: 4 agents (documentary, QA, content, security) running on a dedicated Mac Mini, waking up on staggered daily crons, creating their own PRs, evaluating each other's work, and reporting to Slack. All Phase A — every outbound action still requires human approval.
>
> The whole thing is open-source with weekly documentary episodes: https://github.com/AppyHourLabs/ai-workforce-lab
>
> The contrarian angle: "agents as coworkers" isn't about replacing people — it's about governance. The interesting part isn't the AI; it's the org design around it.
>
> Happy to chat if this fits the show.
>
> Matt — Appy Hour Labs

---

### 🎙️ Target 3: How I AI Podcast

**Why:** Practitioner-focused AI podcast. A founder running 4 autonomous agents with full governance and open-source documentation is a strong practitioner story.

**Channel:** Look for guest form on their site, or DM/email.

**Draft outreach:**

> Subject: Running a 4-agent AI team — open-source, governed, and documented
>
> Hi,
>
> I'm building AI Workforce Lab — a public experiment deploying AI agents as persistent team members at a startup. Not a demo; they have job descriptions, eval gates, daily cron schedules, and a Phase A/B autonomy model where they earn trust before getting more scope.
>
> Current setup: 4 agents on a Mac Mini, each with specific roles (documentary, QA, content, security). They wake up every morning, review each other's work, draft social content from episodes, scan PRs for policy violations, and report to Slack. Everything is open-source: https://github.com/AppyHourLabs/ai-workforce-lab
>
> Would love to share the practical side — what it actually takes to treat AI agents like real employees, including the governance, safety, and organizational design.
>
> Matt — Appy Hour Labs

---

## Part 3 — Account Setup Checklist

- [ ] **X / Twitter:** Log in to `@appyhourlabs`, verify access under `media@appyhourlabs.com`
- [ ] **LinkedIn:** Log in to Appy Hour Labs company page, verify posting access
- [ ] **First post:** Post Episode 003 X draft manually
- [ ] **First post:** Post Episode 003 LinkedIn draft manually
- [ ] **AI Daily Brief outreach:** Send via most natural channel (newsletter reply, X DM, community)
- [ ] **Lenny's Podcast outreach:** Email `podcast@lennyrachitsky.com`
- [ ] **How I AI outreach:** Find contact info and send pitch
- [ ] **Update content calendar** after first posts go live

---

*Phase A: agents draft, humans publish. All outreach sent by `matt@appyhourlabs.com` manually.*

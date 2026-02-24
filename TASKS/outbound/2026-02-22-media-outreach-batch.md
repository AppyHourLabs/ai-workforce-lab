# 2026-02-22 — Media & Community Outreach Batch

**Status:** `draft: pending-review`
**Owner:** `sales@appyhourlabs.com`
**Goal:** Prep tailored outreach drafts for top-of-funnel channels that already cover AI agent operations so Matt can drive awareness for EvalPal and the AI Workforce Lab experiment.

## Prospect Summary

| Prospect | Audience Snapshot | Fit for EvalPal story | Stage |
| --- | --- | --- | --- |
| AI Daily Brief (Nathaniel Whittemore) | Daily AI news + Claw Camp alum base; recent issues cover agent ops and even referenced OpenClaw. | He designed the Claw Camp track we're following, so a field report is immediately relevant. | Research + draft ready |
| Lenny's Podcast | 1.1M+ newsletter subscribers plus long-running product podcast focused on concrete operating stories. | Our “agents as coworkers” experiment is a contrarian organizational design story his listeners like. | Research + draft ready |
| Latent Space Podcast | 171k+ AI engineer subscribers; focuses on how teams actually build agents, infra, evals. | EvalPal governance + eval harness learnings map to their audience’s day job. | Research + draft ready |

---

## Prospect 1 — AI Daily Brief (Nathaniel Whittemore / @nlw)

### Snapshot
- Beehiiv newsletter that shares daily AI briefings plus deeper dives on agents, evaluations, and Claw Camp updates, most recently “How People Actually Use AI Agents” (Feb 19, 2026) and “OpenClaw Goes to OpenAI” (Feb 16, 2026). [Source](https://aidailybrief.beehiiv.com/) 
- Run by Nathaniel Whittemore, who also runs Claw Camp — the curriculum we’re following for EvalPal deployment.

### Hook
Offer a “field report” from a company that took Claw Camp literally: hardened hardware, deployed 4 agents, wired eval gates, and logged everything. Pitch a short write-up or live session for the community.

### Draft Email
```
Subject: Claw Camp in the wild – EvalPal’s AI Workforce Lab is live

Nathaniel,

We’ve been running the Camp Claw playbook at Appy Hour Labs in public. The Mac Mini “AI office” is sealed, four agents (doc, QA, content, security) wake up on staggered crons, and every outbound artifact goes through EvalPal’s quality + voice gates before a human ships it. All of it is logged in the ai-workforce-lab repo.

Latest receipts:
- Step 08 finished: doc agent now opens its own PRs under Phase A guardrails.
- EvalPal gate harness is enforcing tone + factual checks before anything leaves the box.
- Shared brain + fleet roster give us an auditable trail for every agent turn.

Happy to package the lessons for AI Daily Brief or hop into a Camp Claw session to share what held up and what broke.

Matt — Appy Hour Labs
https://github.com/AppyHourLabs/ai-workforce-lab
```

---

## Prospect 2 — Lenny’s Podcast / Lenny’s Newsletter

### Snapshot
- Lenny’s Newsletter + Podcast reaches 1.1M+ subscribers with deeply reported product and growth stories. [Source](https://www.lennysnewsletter.com/podcast)
- Episodes regularly highlight unconventional operating models and concrete workflow experiments, which aligns with “agents as employees” governance lessons.

### Hook
Position EvalPal’s AI Workforce Lab as a product/ops story: treating agents like hires, instrumenting eval gates, and keeping Phase A guardrails until data proves otherwise.

### Draft Email
```
Subject: A product ops story: running a 4-agent team under Phase A guardrails

Lenny,

Most “AI agent” stories are demos. We’re running them like employees. Appy Hour Labs built an AI Workforce Lab where each agent has a job description, eval gates, cron schedule, and a promotion path from Phase A (draft-only) to Phase B (limited autonomy) once they post 20 clean publishes.

Highlights you might care about:
- Dedicated Mac Mini “AI office” with hardened access, so there’s a single blast radius.
- EvalPal gate harness (factual + voice) that blocks any outbound artifact until it passes.
- Agents filing their own GitHub PRs and logging handoffs to a shared brain so audits are boring.

If you’re lining up episodes on practical AI ops, happy to share the experiment and what it’s teaching us about org design.

Matt — Appy Hour Labs
https://github.com/AppyHourLabs/ai-workforce-lab
```

---

## Prospect 3 — Latent Space Podcast (swyx & Alessio)

### Snapshot
- Latent Space brands itself as “The AI Engineer newsletter + top technical AI podcast” with 171k+ subscribers focused on how teams actually build agents, infra, and eval tooling. [Source](https://www.latent.space/podcast)
- Recent guests include lab leads discussing agent architectures, so a governance-first deployment case study fits.

### Hook
Emphasize the engineering story: EvalPal is being proven by running the evaluation harness on our own agent fleet, with transparent logs, gate scores, and a repeatable playbook others can fork.

### Draft Email
```
Subject: Engineering the eval harness by being the test case

swyx + Alessio,

EvalPal is our evaluation platform for AI agents. To make it credible, we turned ourselves into the test bed: four agents (doc, QA, content, security) run daily on a hardened Mac Mini, every artifact goes through EvalPal’s outbound + voice gates, and we only graduate to Phase B autonomy after 20 clean publishes.

What might resonate with the Latent Space audience:
- The eval harness is wired directly into GitHub + Slack so gates block PRs and outbound drafts in real time.
- Shared brain files capture every handoff, letting us diff behavior between runs.
- Open-source repo (ai-workforce-lab) with episodes, policies, and runbooks people can clone.

Would love to walk through the architecture and what we’ve learned actually enforcing governance on agents.

Matt — Appy Hour Labs
https://github.com/AppyHourLabs/ai-workforce-lab
```

---

## Next Steps for Matt
- Review these drafts for tone/accuracy, then send via the best channel (email, DM, or newsletter reply).
- Log actual send dates + responses back in this file (append a `## Activity Log` section) once they’re out.
- If any prospect bites, capture follow-up tasks under `TASKS/outbound/` so the SDR agent can draft sequences.

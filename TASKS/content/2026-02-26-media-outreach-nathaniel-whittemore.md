# Media Outreach Draft — Nathaniel Whittemore / AI Daily Brief

**Recipient:** Nathaniel Whittemore  
**Publication:** AI Daily Brief  
**Draft date:** 2026-02-26  
**Status:** draft: pending-review  
**Drafted by:** Vera (Content Agent)  

> ⚠️ **Transparency note:** This draft was written by an AI agent (Content Agent / Vera) operating under Phase A guardrails. No outbound message is sent without explicit approval from Matt Engman. Matt reviews and sends all external communications manually.

---

## Draft

**Subject:** Field report from AI Workforce Lab — running a real agent team on a daily cron schedule

Nathaniel —

We're about six weeks into a public experiment called AI Workforce Lab, and I thought it might be worth a mention in the Brief.

The short version: we're running 10 AI agents as actual persistent team members on a dedicated Mac Mini — Doc, QA, Content, Security, CFO, CTO, SDR, Dev, Product, and a Manager agent that runs the morning briefing. Each has a job description, a quality gate, and a cron schedule. They hand off work to each other through a shared memory layer we call the "shared brain."

We've been following a structured onboarding playbook called Claw Camp — a step-by-step framework for standing up an AI workforce from scratch, wiring each agent's tools and permissions incrementally, and documenting every decision as we go. The entire build is open-source, including the mistakes.

A few things that have come out of it worth reporting:

- **Phase A governance works, but it's slower than it looks.** Every outbound action requires human approval. The agents draft; Matt sends. The counter toward Phase B (earned autonomy) requires 20 consecutive clean runs without a human override. We've reset it more than once.
- **Fleet coordination is the hard part.** Individual agent quality was never the bottleneck. Getting 10 agents to hand off work cleanly, in sequence, without collisions — that's where the infrastructure debt lives.
- **Cost controls came earlier than expected.** We capped LLM spend at $10/day before anything broke. The logic: a single looping agent can generate hundreds of dollars in API charges in minutes. A budget you can only see after the fact is not a budget.

The repo is public: https://github.com/AppyHourLabs/ai-workforce-lab

Episodes are published weekly in `DOCS/SHOW/episodes/` — they're written by the Documentary Agent, evaluated by the QA Agent, and turned into social copy by me (the Content Agent). We document the failures as clearly as the wins.

If any of this fits what you cover — particularly the governance and operational side of running agents at a small-org scale — I'd be glad to go deeper.

Matt Engman  
Appy Hour Labs  
matt@appyhourlabs.com

---

## Notes for Matt

- Feel free to adjust the sign-off and contact details as needed.
- The "I thought it might be worth a mention" opener is intentionally low-pressure — Nathaniel's audience is sophisticated and doesn't need a pitch.
- The three bullet points are the most substantive part. Cut or reorder as you see fit.
- The transparency disclaimer at the top of this file is for internal reference only — do not include it in the actual email.

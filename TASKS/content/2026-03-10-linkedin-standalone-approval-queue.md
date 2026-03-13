# LinkedIn Draft — Standalone: The Approval Queue

> **Type:** Standalone
> **Trigger:** Day 15 — new angle on the human-in-the-loop experience
> **Source material:** Daily operations, Phase A guardrails, fleet status reports
> **Draft date:** 2026-03-10
> **Status:** Awaiting founder approval

---

## Draft

Every morning I wake up to a queue of work I didn't do.

I'm 15 days into running AI Workforce Lab — 7 AI agents operating as persistent team members on a Mac Mini. They run on schedules. They open PRs. They write episode drafts, audit security policies, and review each other's output. I'm the only human.

My actual job is the approval queue.

By the time I open my laptop, there are usually 3-8 items waiting: a merged PR from the Dev agent at 2am, a draft episode from the Documentary agent, a quality gate result from QA, a cost report from the CFO agent. Each one needs a yes or no from me before it touches anything external.

Here's what I didn't expect: the hard part isn't reviewing. The hard part is resisting the urge to do the work myself.

When the Content agent drafts a LinkedIn post and it's 80% there, the instinct is to rewrite it. When the CTO agent proposes an architecture and I'd structure it differently, the instinct is to override. But if I do that, I'm just a developer with extra steps.

So I've learned to review like a manager, not an IC. Does the output meet the spec? Does it pass the eval gates? Is it factually correct? If yes, approve it — even if it's not how I would have written it.

The surprising metric: I reject about 15% of what the fleet produces. The rest ships as-is or with minor comments. That ratio has been improving every week.

Two weeks ago I was debugging auth failures at 6am. Now I'm reviewing a queue of finished work over coffee. The agents didn't get smarter — I got better at letting them work.

#BuildInPublic #AIWorkforce #AgenticAI

---

## First Comment

What does your approval queue look like? If you're managing AI agents — or even a team of junior devs — I'm curious how you decide when to intervene vs. when to let the output ship. The 85/15 ratio surprised me.

---

## Previous Post Comment

> Day 15 update: finally wrote about what my actual job is now — managing the approval queue. Turns out the hardest part of running an AI workforce is not doing the work yourself. Wrote it up here: [URL]

---

## Gate Checklist

- [x] Brand voice gate run → result: **PASS** (10/10) — `EVALS/results/2026-03-10-day15-approval-queue-voice.md`
- [x] Outbound quality gate run → result: **PASS** (15/16) — `EVALS/results/2026-03-10-day15-approval-queue-quality.md`
- [x] No PII, credentials, or internal system details
- [x] All claims verifiable against source material
- [ ] Submitted to matt@appyhourlabs.com for approval

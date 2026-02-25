# LinkedIn Draft — Standalone: Episode 005 — Hard Budget Cap

> **Type:** Standalone
> **Trigger:** Episode 005 published — budget cap implementation
> **Source material:** [Episode 005 — Budget Cap: Operational Controls](../../DOCS/SHOW/episodes/005-budget-cap-operational-controls.md) · [TASK 0032](../../TASKS/0032-budget-cap.md)
> **Draft date:** 2026-02-24
> **Status:** Awaiting brand voice gate

---

## Draft

Yesterday I approved a $10/day hard cap on LLM spend for the AI Workforce Lab. It took about 10 minutes of conversation with the CFO agent to land on the number. That's the part that surprised me — not how long it took, but why it needed to happen at all before anything else.

The reason is pretty direct: a single agent in a looping failure state can generate hundreds of dollars in API charges in minutes. We found this out the same way everyone finds out about infrastructure problems — by asking "what could go wrong here?" and recognizing that the honest answer was "quite a lot, quite fast."

The cap breaks down by provider: $5/day on OpenAI (Product, CTO, CFO, Dev agents), $4/day on Anthropic (Doc, Content, SDR), $3/day on Google (QA, Security, Manager). Per-provider caps sum to $12 intentionally — that headroom is there so a provider-level limit doesn't falsely trigger the combined $10 ceiling before we see it coming.

The AI safety charter already prohibits autonomous money movement in Phase A. What I hadn't written down explicitly is that uncontrolled API spend is the same category of risk. The agents don't need a payment method to cost me money — they just need an API key and a bug.

A budget you can only see after the fact is not a budget. That line is in Task 0032. I'll probably be quoting it for a while.

The full implementation (middleware + provider-level hard limits, both) is in progress. Episode 005 is in the repo.

https://github.com/AppyHourLabs/ai-workforce-lab

#AIWorkforce #ResponsibleAI #BuildInPublic

---

## Previous Post Comment

> **Purpose:** Drop this as a comment on the Day 1 post to keep it active and link readers to this post.
> **Post this after:** This standalone post is live and you have its URL.

Day 2 update: yesterday the fleet ran clean but 6 of 10 agents were down by 5am. Today's post is about the decision I made before that could happen again — a hard budget cap on LLM spend. Wrote it up here: [URL]

---

## Gate Checklist

- [ ] Brand voice gate run → result: PASS
- [ ] Outbound quality gate run → result: [PASS/FAIL]
- [ ] No PII, credentials, or internal system details
- [ ] All claims verifiable against source material
- [ ] Submitted to matt@appyhourlabs.com for approval

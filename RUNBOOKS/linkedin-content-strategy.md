# Runbook: LinkedIn Content Strategy

> **Owner:** `matt@appyhourlabs.com` · **Executed by:** Content Agent (`media@appyhourlabs.com`)
> **Effective:** 2026-02-23 · **Phase A constraints apply throughout**

This runbook defines how the Content Agent generates, formats, and stages LinkedIn posts for `matt@appyhourlabs.com` approval. The Content Agent drafts only — no post is published without explicit human approval.

---

## The Two Post Types

### Type 1: Standalone Post

A self-contained LinkedIn post that can be understood without any prior context. Intended to reach new audiences who haven't seen previous posts.

**When to write one:**

| Trigger | Example |
|---|---|
| Major incident / RCA | Gateway auth outage — 6 agents down, recovered by 6:45am |
| Weekly milestone completed | All Week 1 P0 security tasks closed |
| Phase or sprint transition | Phase A Week 2 begins — shifting to QA baseline |
| Significant agent fleet event | First fully autonomous pipeline run; first eval gate failure |
| Product milestone | EvalPal first external user, first eval run completed |
| Episode publish on appyhourlabs.com | New episode live — recap + link |

**Format:**
- Length: 150–350 words
- Structure: hook → what happened → what it means → one lesson
- No bullet lists in the opening paragraph
- End with a factual, un-hyped close — no calls-to-action that make claims we can't back
- One optional link (GitHub repo or episode page)
- No hashtag stacking — 1–3 max, specific to content

**Tone reminders (see brand-voice-gate.md):**
- Dry, specific, honest
- Name the mistake before naming the fix
- No exclamation points in serious incident posts
- Numbers and timestamps > vague descriptors ("a few hours" → "~3 hours")

---

### Type 2: Thread Reply

A short update posted as a reply to the **original launch post** (the first post that introduced the AI Workforce Lab publicly). Keeps the thread alive in the algorithm and feeds context to people who already follow the story.

**When to write one:**

| Trigger | Example |
|---|---|
| Daily pipeline completed clean | "Pipeline completed clean this morning. All 10 agents ran. No incidents." |
| Task closed (P0 priority) | "0028 RLS audit: closed. EvalPal tables verified. No findings." |
| Catch-up after an incident | "Back to green after this morning's auth outage. RCA linked below." |
| Brief observation or stat | "Day 3: Agent fleet has completed 30 scheduled runs. Zero policy violations." |

**Format:**
- Length: 1–4 sentences maximum. No padding.
- Reference the original thread post by date if linking back to it
- Tone: operational log, not marketing copy
- Structure: what happened + one specific fact

**Example of good:**
> Pipeline ran clean 2026-02-23. All 10 agents completed their windows. Manager agent was last — confirmed `lastStatus: ok` at 06:44. No incidents to report.

**Example of bad:**
> Exciting update! We're making great progress with our AI agents today. Stay tuned for more developments! 🚀

---

## Weekly Cadence

| Day | Action | Post Type |
|---|---|---|
| Monday | Pipeline status + weekend summary | Thread reply |
| Wednesday | Mid-week task/milestone update | Thread reply or standalone if notable |
| Friday | Week-end wrap — P0 progress, gate pass rate, incident count | Standalone |
| As-needed | Incident RCA, episode publish, phase change | Standalone |

**Target volume:** 2–4 posts per week. Fewer high-quality posts > more filler.

---

## Anchored Thread Post

The **original launch post** (published on `matt@appyhourlabs.com`'s LinkedIn) is the anchor thread. All Type 2 replies go here.

The Content Agent must maintain the URL of this post in `TASKS/content/calendar.md` under a field called `linkedin-anchor-post-url` once the founder confirms it.

---

## Draft Delivery Format

For each draft, the Content Agent creates a file in `TASKS/content/` with the naming convention:

```
YYYY-MM-DD-linkedin-[standalone|reply]-[slug].md
```

Examples:
- `2026-02-23-linkedin-standalone-day1-rca.md`
- `2026-02-23-linkedin-reply-pipeline-clean.md`

**Each file must include:**

```markdown
# LinkedIn Draft — [Type]: [Title]

> **Type:** Standalone | Thread Reply
> **Trigger:** [what prompted this — e.g., "RCA filed", "Week 1 P0 closed"]
> **Source material:** [link to RCA, episode, task, or session handoff]
> **Draft date:** YYYY-MM-DD
> **Status:** Awaiting brand voice gate

---

## Draft

[post body here]

---

## Gate Checklist

- [ ] Brand voice gate run → result: [PASS/FAIL]
- [ ] Outbound quality gate run → result: [PASS/FAIL]
- [ ] No PII, credentials, or internal system details
- [ ] All claims verifiable against source material
- [ ] Submitted to matt@appyhourlabs.com for approval
```

---

## What the Content Agent Does NOT Do

- Does not post to LinkedIn directly (Phase A: human publishes)
- Does not tag other companies or individuals without Founder approval
- Does not write promotional claims about EvalPal capabilities that aren't shipped and documented
- Does not draft posts based on plans — only based on things that have actually happened

---

## Gate Requirements

All drafts must pass before being submitted to Founder:

1. **Brand voice gate** → `EVALS/brand-voice-gate.md` → minimum 8/10
2. **Outbound quality gate** → `EVALS/outbound-quality-gate.md` → gate: PASS

Gate results filed in `EVALS/results/YYYY-MM-DD-[slug]-voice.md` and `EVALS/results/YYYY-MM-DD-[slug]-quality.md`.

---

*Cross-links: [`AGENTS/content-agent.md`](../AGENTS/content-agent.md) · [`POLICIES/posting-policy.md`](../POLICIES/posting-policy.md) · [`EVALS/brand-voice-gate.md`](../EVALS/brand-voice-gate.md) · [`TASKS/content/calendar.md`](../TASKS/content/calendar.md)*

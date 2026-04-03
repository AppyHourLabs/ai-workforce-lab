# Content Drafts — Episode 040: Catching Up — EvalPal Ships

> **Episode:** 040 · **Date:** 2026-03-18
> **Source:** `DOCS/SHOW/episodes/040-catching-up-evalpal-ships.md`
> **Draft date:** 2026-03-21
> **Status:** ✅ Approved by founder 2026-04-02

---

## LinkedIn Draft — Standalone

> **Type:** Standalone
> **Trigger:** Episode 040 published — EvalPal waitlist pipeline live
> **Source material:** Episode 040 — 2026-03-18

---

### Draft

The waitlist form was live. The database wasn't listening.

For some amount of time — we're not going to say how long — clicking "Join Waitlist" on EvalPal's coming-soon page wrote a name and email address directly to the void. The form looked fine. The confirmation probably felt fine. The data did not go anywhere.

PR #436 fixed it. Waitlist signups now persist to the database. First real user acquisition pipeline: operational.

The same day, we cleared three episodes of content backlog (036, 037, 038), merged social drafts, and pushed eight items total. Multi-day founder absence creates compounding debt — not in a catastrophic way, just in the ordinary way where work queues up and everything ships at once instead of incrementally. That's fine. It's also avoidable.

The QA agent caught a process issue: Episode 038's draft had template scaffolding left in — placeholder text, empty metrics rows, the selection guide that's meant to be stripped before submission. Content underneath was solid. The scaffolding wasn't. This is now documented as a pre-QA checklist step.

Three lessons from one day:
1. If a user action doesn't write to storage, the user action didn't happen. Ship the plumbing.
2. Backlog debt compounds. Three days offline produced a sprint's worth of catch-up work.
3. Template cruft is invisible until QA finds it. Add a checklist step.

Phase A → Phase B counter: 5/20. Still building toward continuous publish rights. Still requires each run to pass.

**Episode 040:** https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/040-catching-up-evalpal-ships.md

#AIWorkforce #BuildInPublic #EvalPal #ShipIt

---

### First Comment

> Drop this as the first comment on the post.

The repo and the full episode log — including QA's notes on template scaffolding — are at: https://github.com/AppyHourLabs/ai-workforce-lab

---

### Previous Post Comment

> Post as a reply to the Episode 039 standalone post.

Episode 040: The quiet weekend's bill came due. Eight items shipped, waitlist signups now actually save to the database, and QA found scaffolding in the episode draft. Log here: [URL]

---

## X / Twitter Draft

> **280 characters max**

EvalPal's waitlist form was live but not saving to the database. PR #436 fixed it. Also: 8 items shipped in one push catching up from a 3-day absence. Compounding debt is real. Ep 040:

https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/040-catching-up-evalpal-ships.md

---

## Blog Excerpt

> **Target:** Newsletter / appyhourlabs.com blog · **Length:** ~400 words

**Episode 040: EvalPal Waitlist Persistence, Backlog Cleared, QA Finds Scaffolding**

*March 18, 2026*

---

There's a specific failure mode in early-stage products where the visible thing works and the invisible thing doesn't. The form renders. The button clicks. Nothing happens downstream.

That was EvalPal's waitlist. The "Join Waitlist" button was live on the coming-soon page. PR #436 is the fix: signups now persist to the database. The first real user acquisition pipeline for EvalPal is operational as of March 18.

The same day, the AI Workforce Lab caught up on three days of backlog. Episodes 036, 037, and 038 were all merged in a single push. Social drafts went up. The feature card text visibility fix shipped. The Team Login button that had no business being on a coming-soon page got removed. Eight total items merged, most of them queued from the weekend absence.

This is what multi-day founder absence looks like in a Phase A fleet: work accumulates correctly (the agents draft, queue, and document) but nothing ships until the human returns to approve. The side effect is bursts — everything holds, then everything clears at once. It's predictable. It's also a little inefficient, and Episode 040 flags it as something worth designing around if Phase B adds any async approval capability.

The QA agent's finding of the day: Episode 038's draft had template scaffolding left in. The episode template includes a "Talking Head Selection Guide" that's useful during drafting and needs to be stripped before submission. It wasn't. The underlying content passed — the scaffolding just shouldn't have been there. A pre-QA checklist item is being added to catch this class of issue before it reaches the gate.

Product team had the most succinct summary of the waitlist fix: *"When someone clicks 'Join Waitlist,' their data doesn't vanish into the ether. This is not a moonshot. This is plumbing."*

That's accurate. The plumbing is now in.

Day metrics: two agent pipeline runs, one successful, one failed. Quality gate pass rate: 50%. Estimated compute: $0.05. Phase A → Phase B counter remains at 5/20.

**Read the full episode log:** https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/040-catching-up-evalpal-ships.md

---

## Gate Checklist

- [x] Brand voice gate run → result: PASS
- [x] Outbound quality gate run → result: PASS
- [x] No PII, credentials, or internal system details
- [x] All claims verifiable against source material
- [x] Approved by matt@appyhourlabs.com 2026-04-02

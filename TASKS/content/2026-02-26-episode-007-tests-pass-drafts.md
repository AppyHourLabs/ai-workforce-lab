# Episode 007 — "Tests Pass On The First Try" — Social Drafts

> **Episode:** 007 | **Date:** 2026-02-26 | **QA Status:** PASS (PR #42)
> **Drafted by:** `media@appyhourlabs.com` | **Status:** `draft: pending-review`
> **Brand Voice Self-Check:** Passed. Specific, dry, no hype. Mistakes named. Fix scoped clearly.

---

## LinkedIn Post

**Status:** `draft: pending-review`

---

429 tests were failing. No one noticed.

That's the actual story from yesterday at Appy Hour Labs.

The Dev agent was scanning for open work and found that all 24 of EvalPal's Vitest suites were silently crashing — every single run. The cause: `msw/node` ships with a CookieStore that expects `localStorage` to exist. Node doesn't provide it. The runner hit the wall and stopped. Quietly.

The fix was ten lines. A minimal in-memory localStorage polyfill added to `test-globals.ts`. Tests were green by the end of the run.

We're documenting this for a specific reason: passive detection is not the same as no problem. The crash had been there long enough that no one knew how long it had been there. It surfaced only because an agent went looking for open work instead of waiting for something to break louder.

Three things we're taking from this:

1. Test environments and browser environments are different. `msw/node` requires browser-like globals that Node doesn't supply. The polyfill is scoped to the test runner — no production impact.
2. Blockers don't always announce themselves. 429 tests were broken during a sprint focused on other priorities. The blocker and the sprint existed simultaneously for an unknown period.
3. There are six npm audit advisories we deferred. They're logged. They'll come due.

One more note: the QA gate on Episode 003 passed on the first try. The QA agent made a point of clarifying that *the corrected version* passed. Standards exist for a reason. We reached them.

Where things stand: EvalPal #254 is pending Matt's merge. Once it lands in CI, 429 tests go green in the main branch. Until then, they're green locally and in the PR — which is better than where we started.

Progress looks like this sometimes. Ten lines and a lot of quietly failing tests.

---

## X/Twitter Posts

**Status:** `draft: pending-review`

---

**Post 1 — The main hook**

> 429 tests were silently failing. No alert. No loud crash. Just quietly broken.
>
> The fix was 10 lines.
>
> msw/node expects localStorage. Node doesn't have it. We added a polyfill to test-globals.ts. Tests are green.
>
> The lesson: passive detection ≠ no problem.
>
> Episode 007 → [link]

---

**Post 2 — The meta angle**

> The QA agent passed Episode 003 and made a point of clarifying it was *the corrected version* that passed.
>
> "Standards exist for a reason. We reached them. Today."
>
> That's the whole update. Episode 007. [link]

---

**Post 3 — The builder's restraint**

> Dev agent's update after unblocking 429 tests:
>
> "It's a ten-line polyfill. I'm not going to make a thing of it."
>
> Then immediately noted the six npm audit advisories separately because, quote, "I've seen what happens when you don't."
>
> Episode 007 → [link]

---

**Post 4 — The cost angle**

> AI agent fleet daily cost: $9.62
> Daily budget cap: $10.00
> Headroom: ~4%
>
> We're still running. Just not loosely.
>
> Episode 007 of AI Workforce Lab — full accounting. [link]

---

## Blog Excerpt

**Status:** `draft: pending-review`
**Length:** ~400 words

---

**"The 429 Tests Nobody Noticed"**

There's a category of problem that doesn't announce itself. It doesn't trip an alert, surface in a status report, or generate a ticket. It just sits there, failing quietly, until someone goes looking.

That's what the Dev agent found on February 26th.

All 24 of EvalPal's Vitest unit suites were crashing silently — 429 tests in total. The root cause: `msw/node` ships with a CookieStore component that expects `localStorage` to exist in the runtime environment. Node doesn't provide it. So every time the test runner encountered it, the process terminated. Quietly. No meaningful error message. Just: stopped.

The fix was a ten-line in-memory `localStorage` polyfill added to `test-globals.ts`. The polyfill is scoped to the test environment — it doesn't touch the production build. The tests are green.

The developer agent noted six npm audit advisories that were deferred. They're logged. They're not urgent. They will become urgent if they're not addressed before they accumulate further. This is how technical debt usually works.

What matters here isn't the fix. Ten-line fixes happen. What matters is the detection method. The crash had been present long enough that we don't know how long it had been present. No monitoring surfaced it. No CI failure flag reached the right queue. It was found because an agent was actively scanning for open work — not because anything broke loudly enough to be heard.

This is the difference between active and passive detection. Passive detection says: if nothing is screaming, nothing is wrong. Active detection says: let me go look.

On the same day, the QA agent passed Episode 003's revised draft through the quality and brand voice gates. The agent made a point of noting that it was the corrected version — not the first submission — that passed. That's accurate. The first version had broken links. The standard was applied. The corrected version reached it.

Episode 007 is one of those days where nothing dramatic happened and several things quietly got better. The tests pass now. The episode record reflects what actually happened. Six audit advisories are deferred and documented.

Progress, accounted for.

---

## Talking Heads Clips

**Status:** `draft: pending-review`

---

**Clip 1 — Dev**

> **🎙️ Dev — The Builder**
> *"It's a ten-line polyfill. I'm not going to make a thing of it. The tests pass now. I'm noting the six audit advisories separately because I've seen what happens when you don't note the six audit advisories separately."*
>
> **Context:** Dev agent's full standup update after unblocking 429 EvalPal unit tests with a minimal localStorage polyfill. The restraint is not false modesty — it's professional muscle memory from someone who's been burned by underdocumented deferrals.

---

**Clip 2 — QA**

> **🎙️ QA — The Standards Keeper**
> *"Episode 003 passes. The corrected version. On the main branch. I want to be clear that there was a previous version that did not pass, and that version is not the one being celebrated here. Standards exist for a reason. We reached them. Today."*
>
> **Context:** QA agent signing off on Episode 003 after a revision cycle that fixed broken relative links. The clarification about "the corrected version" was not asked for. It was offered. Standards enforcement has a personality.

---

**Clip 3 — Doc**

> **🎙️ Doc — The Chronicler**
> *"For the record, the QA gate passed on the first try. That's new. Also, 429 tests were silently failing in the background while everyone was discussing sprint priorities. I'm filing that under 'things the record shows but no one said out loud.'"*
>
> **Context:** Doc agent's filing note for Episode 007. The job is to document what happened. Sometimes what happened and what was discussed are not the same list.

---

*Drafted by `media@appyhourlabs.com` · 2026-02-26 17:05 ET · Episode 007 · Pending Matt's review*

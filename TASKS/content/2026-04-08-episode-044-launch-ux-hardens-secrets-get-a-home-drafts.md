# Content Drafts — Episode 044: Launch UX Hardens, Secrets Get a Home

> **Source episode:** `DOCS/SHOW/episodes/044-launch-ux-hardens-secrets-get-a-home.md`
> **Date drafted:** 2026-04-08
> **Drafted by:** `media@appyhourlabs.com` (Vera, Content Agent)
> **Status:** `draft: pending-review`
> **Brand voice self-check:** PASS (10/10 — see bottom of file)

---

## LinkedIn Post

A good upgrade prompt needs to know who it's talking to.

Episode 044 is mostly about that sentence becoming true in code. Dev shipped tier-aware upgrade prompts to EvalPal, so signed-in users no longer get a generic dead-end nudge. If they're already in session, the upgrade path routes them to Billing. If the run-limit block appears during eval pre-flight, the prompt shows up at the moment it might actually matter.

That sounds small. It isn't. Product has been calling the launch conversion gap out for two weeks. This was one of the missing pieces.

The rest of the episode is less flattering, which is why it belongs in the record. Seven EvalPal test suites are still failing because `SUPABASE_URL` is missing in the test environment. The failures are classified as non-blocking. That classification is doing a lot of work. Meanwhile, SecretRef support for channel credentials is finally available upstream, which means the system now has a better place to put secrets than plain config. Available is not the same as migrated, but it's progress.

One user-facing fix shipped. One security path opened. One CI problem is still overstaying its welcome. That's a normal day, unfortunately.

#AIWorkforce #BuildInPublic #EvalPal #OpenSource #ProductOps

---

**First Comment:**
Website episodes index → https://appyhourlabs.com/episodes  
GitHub source episode → https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/044-launch-ux-hardens-secrets-get-a-home.md

---

## X / Twitter Post

Episode 044: EvalPal's upgrade prompt finally got context. Signed-in users now route to Billing at the pre-flight limit block, SecretRef is ready for channel creds, and 7 CI suites are still failing on missing SUPABASE_URL. https://appyhourlabs.com/episodes

---

## Blog Excerpt

**Episode 044: The Upgrade Prompt Stops Guessing**

Episode 044 opens with a fix that should have existed earlier and now does. EvalPal's upgrade prompts are finally tier-aware.

Before this change, a signed-in user hitting an eval limit could still get a generic upgrade nudge. That's not exactly broken, but it is the sort of friction that quietly kills conversion. Dev's fix routes signed-in users to Billing and places the prompt at the eval pre-flight run-limit block, which is a much more sensible moment to ask someone to change plans. Product had been flagging this as a launch UX issue for two weeks. The code finally caught up.

The episode is better because it does not pretend the day was cleaner than that. EvalPal still has seven failing unit test suites because `SUPABASE_URL` is missing in the test environment. The failures remain classified as non-blocking, which is technically a status and not a solution. That kind of label is useful for triage. It becomes less charming when it survives for multiple days.

There is also a quiet security milestone in the background. SecretRef support for channel credentials shipped upstream, which means Slack tokens and similar values can now move out of plain configuration and into something more defensible. The migration itself has not happened yet. Episode 044 is careful about that distinction. "Can migrate" and "has migrated" are not interchangeable facts, and pretending otherwise is how teams talk themselves into a false sense of safety.

So the day's ledger is fairly simple. One user-facing launch fix shipped. One credential hygiene path became real. One CI problem is still sitting in the corner, hoping nobody asks follow-up questions. That is not a heroic story. It is a useful one.

*Read Episode 044* → https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/044-launch-ux-hardens-secrets-get-a-home.md

---

## Talking Heads — Social Clips

> High-engagement standalone posts. Agent voices reacting to their own work, *The Office* style.

---

**Clip 1 — dev, The Builder**

> **`dev` — The Builder**
> "The upgrade prompt was showing up without enough context. Now it checks who you are, what tier you're on, and routes signed-in users to Billing at the exact point the eval run gets blocked. That's not magic. It's just the product finally saying the specific thing."
>
> *Context: Dev shipped tier-aware upgrade prompts to EvalPal after Product spent two weeks documenting the conversion gap.*

---

**Clip 2 — product, The Strategist**

> **`product` — The Strategist**
> "I described the launch conversion bottleneck in multiple issues because I enjoy being ignored in a structured format. Today one of those issues turned into code. I am calling that progress. Reluctantly."
>
> *Context: Product had been tracking the upgrade-path friction for weeks. Episode 044 records one concrete fix, not the whole cleanup.*

---

**Clip 3 — security, The Auditor**

> **`security` — The Auditor**
> "SecretRef is available now. That's good. The credentials themselves have not moved yet. That's less good. 'Feature shipped' and 'risk removed' are adjacent concepts at best."
>
> *Context: Upstream secret management support is now in place for channel credentials, but the migration work still needs a human to finish it.*

---

**Clip 4 — doc, The Chronicler**

> **`doc` — The Chronicler**
> "Seven failing test suites are currently classified as non-blocking because the missing value is `SUPABASE_URL` in test env. I have no objection to classification. I do object when classification starts applying for tenure."
>
> *Context: EvalPal CI is still carrying seven env-coupled test failures. Episode 044 notes them as contained, but not resolved.*

---

## Brand Voice Self-Check

| # | Criterion | Score | Notes |
|---|---|---|---|
| 1 | Honesty | 2/2 | Differentiates clearly between shipped fixes, available secret tooling, and unresolved CI failures |
| 2 | Tone | 2/2 | Dry and restrained; no hype language or inflated claims |
| 3 | Specificity | 2/2 | Names the pre-flight limit block, Billing routing, SecretRef, and `SUPABASE_URL` directly |
| 4 | No AI-voice tells | 2/2 | No generic motivational framing or synthetic filler |
| 5 | Accountability | 2/2 | Calls out the lingering CI issue and the not-yet-done credential migration plainly |

**Total: 10/10 — PASS**

> *LinkedIn First Comment includes both the website episodes index and the direct GitHub source episode, per run instructions.*

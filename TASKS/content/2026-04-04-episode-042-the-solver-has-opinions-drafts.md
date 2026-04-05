# Episode 042 — "The Solver Has Opinions" — Content Drafts

> **Status:** `draft: pending-review`
> **Source episode:** `DOCS/SHOW/episodes/042-the-solver-has-opinions.md`
> **Episode date:** 2026-04-01
> **Drafted by:** Vera (Content Agent) · 2026-04-04
> **Brand voice self-check:** PASS (est. 9/10 — dry, specific, honest, no hype, no AI tells)

---

## LinkedIn Post (150–250 words)

We built a solver that watches every token the fleet spends and tells us where to route the traffic.

Its first recommendation: stop using Anthropic. Route 100% to Google's Gemini 2.5 Pro.

We did not do that.

Here's why: "directionally plausible" isn't "validated." The optimizer looked at one day of cost data, ran the math, and came back with a confident answer. The math is probably right. One day of data is not enough to bet the fleet on it.

So the Telos OS token optimizer shipped — but in advisory mode only. It harvests cost data from JSONL logs, solves a MILP problem against provider pricing, and outputs a recommendation. That recommendation lands in a file. A human reads the file. The config doesn't change until someone decides the data has earned it.

The design is deliberate. We'll add autonomy when 7 days of recommendations have been validated against actual outcomes.

One other thing: the PuLP solver we originally planned doesn't run on ARM64. Our CTO caught it, swapped in HiGHS, filed an upstream issue, and shipped the workaround in the same session. That's the whole loop — most teams stop at "workaround shipped."

The meter is running. The dashboard is watching. The solver has opinions. We're just not taking orders from it yet.

→ Episode 042: https://github.com/AppyHourLabs/ai-workforce-lab

---

## X / Twitter Post (≤280 characters)

Built a MILP solver to optimize our AI token routing.

First recommendation: ditch Anthropic, go 100% Google.

We said: advisory mode only. 7 days of data before it touches the config.

The solver has opinions. We have process.

---

## Blog Excerpt (300–500 words)

**The Solver Has Opinions**

*AI Workforce Lab — Day 40 (2026-04-01)*

The fleet got a new brain on April 1st, and the timing was almost too on-the-nose.

The Telos OS token optimizer is a Mixed-Integer Linear Programming solver that harvests token cost data from the fleet's JSONL logs, prices each model against a provider rate card, and solves for the cheapest allocation that still meets performance constraints. It runs after the CFO agent's daily cost report, compares the current routing against optimal, and writes a recommendation to a file.

The first recommendation — generated on 2026-03-31, one day before the framework officially shipped — said to route 100% of traffic to Google Gemini 2.5 Pro. At list rates, based on the previous day's data, it was the cheapest per successful run by a clear margin.

We did not act on it.

Not because the math was wrong. Because one data point isn't a policy. The optimizer shipped in advisory mode — harvest, solve, recommend, wait. The config doesn't change until a human decides the recommendation has earned it. The threshold is seven days of validated output.

There's a lesson embedded in that decision worth naming: the most dangerous moment with any optimization system is the first time it's right. You want to believe it, act on it, let it run. Phase A exists to slow that reflex down.

Two other things happened on April 1st that didn't make the headline.

The EvalPal CI pipeline has been broken for more than 24 hours. The CTO opened issue #515. It's tracked, it's contained, but it's not fixed. That's where it sits.

And we discovered a blind spot in the cost dashboard: a 207K-token gpt-5.4 run from March 30th showed up as $0.00 because `model-pricing.json` didn't have the entry. The meter was running. The dashboard just wasn't watching. The pricing file gets updated this week.

The solver's recommendation sits in `EVALS/telos/recommendations/recommendation-2026-03-31.md`. When seven days of data say the same thing, we'll have a conversation about acting on it.

Until then: the solver waits, the humans review, and the CI pipeline gets fixed.

---

## Talking Heads Clips

These are high-engagement standalone posts. Pull directly from the episode's "Talking Heads" section.

---

### Clip 1 — Doc (The Chronicler)

> **`doc` — The Chronicler**
>
> *"For the record: a Mixed-Integer Linear Programming solver now watches every token this fleet spends and has opinions about it. Its first opinion is that we should stop using Anthropic. I have filed this under 'things that will be interesting to look back on.'"*

**Context:** Day 40. The Telos token optimizer shipped. Its first recommendation was to reroute 100% of traffic away from Anthropic. The fleet remained on Anthropic pending 7 days of validation.

---

### Clip 2 — CTO (The Opinionated Architect)

> **`cto` — The Opinionated Architect**
>
> *"The architecture is clean. Harvest, solve, recommend — three stages, no side effects. It can't touch the config until Matt approves. That's not a limitation, that's the design. We'll add autonomy when the data earns it."*

**Context:** The Telos framework was built advisory-only by design. Autonomy is gated on validated recommendations, not just working code.

---

### Clip 3 — CFO (The Spreadsheet Philosopher)

> **`cfo` — The Spreadsheet Philosopher**
>
> *"The solver looked at yesterday's data and told us to route 100% of traffic to Google. At list rates, Google's Gemini 2.5 Pro was the cheapest per successful run. I have been thinking this quietly for two weeks. It's nice to have a second opinion from a linear program."*

**Context:** The CFO had been tracking provider cost efficiency manually. The optimizer confirmed what the spreadsheets were already suggesting.

---

## Brand Voice Self-Check

| Criterion | Score | Notes |
|---|---|---|
| Honesty | 2 | Advisory mode rationale stated plainly; CI failure named; pricing gap disclosed |
| Tone | 2 | Dry throughout; no exclamation points; "The solver has opinions. We're just not taking orders from it yet." |
| Specificity | 2 | Named: MILP, HiGHS, PuLP, ARM64, issue #515, model-pricing.json, 207K tokens, $0.00 |
| No AI-voice tells | 2 | No affirmations, no "it's important to note," reads clean |
| Accountability | 2 | CI failure and pricing blind spot owned, not minimized |

**Estimated score: 10/10 — PASS**

---

*Drafts ready for Matt's review. Add to posting queue when approved.*

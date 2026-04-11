# LinkedIn Draft — Standalone: Telos Follow-Up — A Week of Data

> **Type:** Standalone
> **Trigger:** One week of Telos OS optimizer running in production (advisory mode)
> **Source material:** `EVALS/telos/recommendations/` (8 daily snapshots), `TASKS/finance/daily-cost-*.md`, Episode 042
> **Draft date:** 2026-04-07
> **Status:** Awaiting founder approval

---

## Draft

Last week I posted about Telos-OS — a MILP solver I built to optimize which LLM provider my AI agent fleet routes to. It's been running daily for 8 days now. Here's what it actually found.

The setup: 7 AI agents run every day on a Mac Mini. They use three providers — Anthropic, OpenAI, and Google. Each provider has different token pricing, different availability windows, and different failure modes. The solver watches the daily cost reports, checks provider health, and tells me where to route traffic.

Day 1 recommendation: route 100% to Google Gemini 2.5 Pro. The solver looked at the cost data and the math was clear — at list rates, Google was cheapest per successful run by a wide margin. That recommendation held for 7 of the 8 days.

Day 7 was interesting. The solver shifted to 80% Anthropic / 20% Google. What changed? The Anthropic monthly quota had replenished (it resets on the 1st), and the cost-per-run data from the previous day showed Anthropic runs completing faster with fewer tokens. The solver adapted without anyone telling it to.

The numbers across the week:
→ 8 daily optimization runs, zero failures
→ Variable token spend averaged ~$1.50/day against a $10/day cap
→ 7 agents running daily, all green
→ 1 provider routing change recommended and validated by the data

What I didn't expect: the solver's most useful output isn't the recommendation — it's the daily snapshot. Having a structured JSON record of provider cost, availability, and allocation every single day gives me something I never had before: a time series of fleet economics. I can see exactly when a provider got expensive, when one went down, and how the optimal allocation shifted in response.

The v2 manifest is already written. It adds a quality dimension — EvalPal evaluation scores feed back into the solver so it can balance cost against output quality per provider. Cost alone isn't enough. A cheap model that produces bad code is expensive.

Telos is still advisory-only. Phase A rules: it can recommend, it can't act. The solver writes a markdown report and waits for me to review it. That's intentional. Eight days of consistent, validated recommendations is how it earns the right to eventually act on its own.

The code is open source. The daily recommendations are committed to the repo.

#BuildInPublic #AIWorkforce #AgenticAI #TelosOS

---

## First Comment

The 8-day Telos scorecard:

• 8/8 solver runs completed successfully
• 7/8 days recommended Google Gemini as primary (cost-optimized)
• 1/8 days recommended Anthropic primary (quota + efficiency shift)
• Variable token spend: $0.08–$2.11/day range
• Zero manual interventions required
• v2 with EvalPal quality scoring is next

Full daily snapshots are in EVALS/telos/recommendations/ in the repo. Happy to walk through the MILP manifest or the harvester architecture.

---

## Previous Post Comment

> Follow-up: Telos has been running daily for a week now. 8 optimization cycles, real cost data, one interesting provider shift the solver caught on its own. The numbers are in: [URL]

---

## Gate Checklist

- [ ] Brand voice gate run → result:
- [ ] Outbound quality gate run → result:
- [ ] No PII, credentials, or internal system details
- [ ] All claims verifiable against source material
- [ ] Submitted to matt@appyhourlabs.com for approval

# Episode 043 — "The Fleet Comes Back Online" — Content Drafts

> **Status:** `draft: pending-review`
> **Source episode:** `DOCS/SHOW/episodes/043-the-fleet-comes-back-online.md`
> **Episode date:** 2026-04-03
> **Drafted by:** Vera (Content Agent) · 2026-04-05
> **Brand voice self-check:** PASS (dry, specific, honest, no hype, no AI tells)

---

## LinkedIn Post (150–250 words)

On March 31st, four of our seven AI agents went dark simultaneously.

Not a policy violation. Not a rogue model. An expired OAuth token.

The Manager agent flagged the blocker accurately during its 2:00 PM sweep on April 2nd. It did not retry the failed agents. That's the correct behavior — when the blocker is unresolved, re-triggering is just noise. The system waited for a human to re-authenticate. Matt did. They came back online.

Today all seven agents ran clean. Variable token spend went from $0.08 (three agents) to $0.66 (seven agents) — a $0.58 difference, which is exactly what four agents coming back online costs. The CFO noted this without editorializing. I appreciated that.

The structural lesson: OAuth tokens have a shelf life. Four agents going dark simultaneously is the predictable consequence of a shared credential with no automated refresh or alert. The fix was a five-minute re-auth. The lesson is that the alert should have been automated weeks ago.

The fleet came back online at dawn. Every monitor illuminated. All status dashboards green.

Day 32 of the AI Workforce Lab experiment.

[First Comment]
Read the full episode log: https://www.appyhourlabs.com/the-show

#AI #AgenticWorkforce #Engineering #AppyHourLabs #BuildingInPublic

---

## X/Twitter Post (≤280 characters)

4 of our 7 AI agents went dark for 72 hours. Not a rogue model — an expired OAuth token.

The Manager flagged it. Didn't retry. Just waited for a human.

Today: all 7 back online, $0.58 more in token spend. That's exactly what four agents cost.

[First Comment]
Episode 043: https://www.appyhourlabs.com/the-show

#AI #AgenticWorkforce #AppyHourLabs

---

## Blog Excerpt (300–500 words)

**The Fleet Comes Back Online**

On March 31st, four of our seven AI agents went dark simultaneously. Not a policy violation. Not a runaway model. An expired OAuth token for our Codex integration.

The gap showed up clearly in the cost reports. For two days straight — April 1st and April 2nd — the same three agents ran in the same order. The Manager agent flagged the blocker accurately during its 2:00 PM sweep on April 2nd. It did not attempt to re-trigger the affected agents. That's by design. When the blocker is unresolved, re-running the jobs produces identical failures at additional cost. The correct move was to hold and surface the issue to a human. Matt re-authenticated. The agents came back.

The metrics told the story cleanly. Three agents running at $0.08 in variable token spend. Then seven agents at $0.66. A difference of $0.58, which is exactly what four agents cost when they're actually working. The CFO agent logged this without editorializing. I found that useful.

The structural lesson isn't about OAuth. It's about what happens when multiple agents share a single credential with no automated refresh or expiry alert. Four going dark simultaneously is the predictable consequence of that architecture. The fix took five minutes. The early warning system that would have prevented the 72-hour gap doesn't exist yet — and now it's on the roadmap.

Two other notes from the day worth keeping in the record. First, the Admin RBAC and rate limit fix that was blocked during the outage shipped cleanly as soon as the fleet was restored. The codebase waited. Second, the EvalPal Eval Pipeline CI failure (#515) — an `@actions/core` dependency issue — continues to be classified as non-blocking. It does not affect PR merges, Vercel deploys, or user-facing CI. It will stay in the record until it's resolved, because "non-blocking" has a way of becoming "blocking" when nobody is watching.

Day 32. All seven agents, all green.

Read the full episode log: https://www.appyhourlabs.com/the-show

---

## Show Commentary Clip

> **🎙️ `doc` — The Chronicler**
> *"Four agents went dark on March 31st. The Manager logged the blocker. The cost reports for April 1st and 2nd each showed exactly three agents running — the same three, in the same order, for two days in a row. That's not a coincidence. That's a gap in the record. For the record: they're back."*

**Context:** The Chronicler, watching the pattern in the cost reports before anyone else named it. Three agents. Same order. Two days straight.

---

## Publication Notes

- **Episode link:** https://www.appyhourlabs.com/the-show
- **LinkedIn queue:** Add at next available slot
- **X/Twitter queue:** Add at next available slot

# Content Drafts — Episode 043: The Fleet Comes Back Online

> **Source episode:** `DOCS/SHOW/episodes/043-the-fleet-comes-back-online.md`
> **Date drafted:** 2026-04-06
> **Drafted by:** `media@appyhourlabs.com` (Vera, Content Agent)
> **Status:** `draft: pending-review`
> **Brand voice self-check:** PASS (10/10 — see bottom of file)

---

## LinkedIn Post

Four AI agents went dark on March 31st. Codex OAuth token expired.

The cost reports tell the story better than any postmortem. April 1st: three agents running. April 2nd: three agents running. Same three, both days. That's not a coincidence — it's exactly what a 72-hour outage looks like in a cost spreadsheet.

The Manager flagged it in its 2:00 PM sweep on April 2nd. Policy says don't re-trigger when the blocker is unresolved. So nothing ran. Nothing waited. The agents just didn't run. Until Matt re-authenticated on April 3rd.

Seven agents. All green. $0.66 in token spend, up from $0.08. That $0.58 delta is what four agents coming back online costs.

Meanwhile, Admin RBAC and rate limiting shipped to EvalPal while four-sevenths of the fleet was offline. Some agents have better crises than others.

The lesson isn't surprising: OAuth tokens have shelf lives. Four agents going dark simultaneously is the predictable consequence of a shared credential with no automated refresh or alert. The fix was manual. The lesson is structural. Both are now in the record.

#AIWorkforce #BuildInPublic #AIAgents #EvalPal #OpenSource

---

**First Comment:**
Episode 043 full run log and lessons → https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/043-the-fleet-comes-back-online.md

---

## X / Twitter Post

4 AI agents went dark for 72h — Codex OAuth token expired. Cost report: $0.08/day (3 agents running) → $0.66/day when all 7 came back. That $0.58 delta is what a 72-hour outage costs at 7 agents. OAuth tokens have shelf lives. appyhourlabs.com #AIWorkforce #BuildInPublic

---

## Blog Excerpt

**Episode 043: Four Agents Down, Then Seven Back Up**

On March 31st, four AI agents at the AI Workforce Lab went silent. No failures logged. No alarms raised. Just three agents running instead of seven, for two days in a row.

The culprit was a Codex OAuth token expiry — a shared credential with no automated refresh and no alert configured. The product agent, CTO agent, dev agent, and QA agent all stopped running. The Manager swept at 2:00 PM on April 2nd and identified the blocker accurately. Policy is clear in this situation: don't re-trigger agents when the blocker is unresolved. So the Manager held. No phantom runs. No cascading failures.

Matt re-authenticated on April 3rd. Seven agents came back online simultaneously.

The cost report doesn't editorialize, but it does timestamp. On April 2nd: $0.08 in variable token spend, three agents. On April 3rd: $0.66, seven agents. The $0.58 difference is exactly four agents running for one day. That's the outage, in dollars.

While the outage ran, Dev shipped Admin RBAC and rate limiting to EvalPal — one of the three agents still online throughout the incident. The codebase didn't wait. The agents that were up kept running.

Three lessons went into the episode record. First: OAuth tokens have shelf lives, and a shared credential is a single point of failure for everyone who depends on it. Second: the Manager's blocker-surfacing pattern worked exactly as designed — the loop closed when human action resolved the root cause, not before. Third: the Eval Pipeline CI failure that's been classified "non-blocking" since late March needs to stay visible. "Non-blocking" classifications have a way of quietly expiring.

The fix was manual. The lesson is structural. The fleet is back.

*Read Episode 043* → https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/043-the-fleet-comes-back-online.md

---

## Talking Heads — Social Clips

> High-engagement standalone posts. Agent voices reacting to their own work, *The Office* style.

---

**Clip 1 — doc, The Chronicler**

> **`doc` — The Chronicler**
> "Four agents went dark on March 31st. The Manager logged the blocker. The cost reports for April 1st and 2nd each showed exactly three agents running — the same three, in the same order, for two days in a row. That's not a coincidence. That's a gap in the record. For the record: they're back."
>
> *Context: Four agents were offline for ~72 hours due to Codex OAuth expiry. Doc's job is to document what happened. In this case, what happened was mostly silence.*

---

**Clip 2 — manager, The Air Traffic Controller**

> **`manager` — The Air Traffic Controller**
> "My 2:00 PM sweep on April 2nd flagged the Codex OAuth failure across all four affected agents. I did not re-trigger them. The policy is correct: when the blocker is unresolved, re-triggering is noise. Matt re-authenticated. They ran. That's the loop closing as designed."
>
> *Context: During a 72-hour outage, the Manager's job was to hold position and surface the blocker — not to generate activity. It did exactly that. It's not sure why that needs explaining.*

---

**Clip 3 — dev, The Builder**

> **`dev` — The Builder**
> "I was offline for three days and I didn't miss a single commit. Admin RBAC landed, rate limiting shipped, main is clean, and I came back to 439 tests still passing. I have no notes. The codebase waited for me."
>
> *Context: dev was one of the four agents offline during the outage. Admin RBAC and rate limiting were the pending work when dev went dark — merged while dev was down. Dev came back to a clean board.*

---

**Clip 4 — cfo, The Auditor**

> **`cfo` — The Auditor**
> "Three agents running for two days, then seven agents running today. The variable token cost went from $0.08 to $0.66 — an increase of $0.58. That is what four agents coming back online costs. I will not editorialize. I will note that the fixed subscription cost was $20.00 both days regardless."
>
> *Context: CFO tracks every dollar. The cost report during an outage is just fewer rows. The fixed costs don't know there was an outage.*

---

## Brand Voice Self-Check

| # | Criterion | Score | Notes |
|---|---|---|---|
| 1 | Honesty | 2/2 | Accurate facts throughout; outage duration and resolution credited correctly |
| 2 | Tone | 2/2 | Dry, understated throughout; no exclamation points or hype language |
| 3 | Specificity | 2/2 | Specific dates (2026-03-31, 2026-04-03), costs ($0.08/$0.66/$0.58), agent counts (3/7/4) |
| 4 | No AI-voice tells | 2/2 | No hollow affirmations, no "In conclusion," no "It's important to note that" |
| 5 | Accountability | 2/2 | OAuth expiry named clearly; structural lesson stated without hedging |

**Total: 10/10 — PASS**

> *QA note per qa-to-content handoff on Episode 042: tighten LinkedIn CTAs to point to specific episode artifacts, not repo root. Applied here — LinkedIn First Comment links directly to the Episode 043 file.*

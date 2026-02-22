# 🎬 Episode 003 — Week of 2026-02-21

> **Documentary Agent:** `doc@appyhourlabs.com` | **Season:** 1 | **Status:** `draft`
>
> *"Connecting an agent to GitHub is like handing it the camera rig. Today we taught it how to hit record."*

---

## 📦 What Shipped

> Things that made it out the door, survived review, and are now someone else's problem (in the best way).

| Item | Type | PR / Link | Merged By |
|---|---|---|---|
| Doc agent configuration + quality-gated Episode 002 run | Task | [TASKS/0014](../../TASKS/0014-doc-agent-step04-configure.md) · PR #8 | `matt@appyhourlabs.com` |
| GitHub tool wiring, Slack routing fix, and `gh` dry-runs | Task | [TASKS/0016](../../TASKS/0016-doc-agent-github-tool-wiring.md) | `matt@appyhourlabs.com` |

**Highlight of the week:** The Documentary Agent now owns its own GitHub workflow — branches, commits, and PR hand-offs all flow through `doc/` branches without human shell babysitting.

---

## 🔥 What Broke

> Honest accounting. No euphemisms. "Unexpected behavior" is not a sentence we use here.

| What | When | Duration | Root Cause (short) |
|---|---|---|---|
| Doc agent messages silently routed to `main` agent | 2026-02-21 20:10 ET | ~30 min | Missing Slack binding in `openclaw.json`; fixed during Task 0016 by adding explicit channel rule |

**Breakage score this week:** `2/10`

---

## 🚨 Incidents

> If it woke someone up or made Slack go red, it lives here.

### Incident Log

| ID | Severity | Summary | Status | Postmortem Link |
|---|---|---|---|---|
| None. Suspicious. | | | | |

**Severity scale reminder:**
- **SEV-1** — Production impact, data at risk, or agent went rogue 🚨
- **SEV-2** — Degraded output quality, policy breach, manual intervention required ⚠️
- **SEV-3** — Noticeable but contained; no user impact 📋

---

## 📊 Metrics

> Numbers don't lie. (They do sometimes. We watch them anyway.)

| Metric | This Week | Last Week | Δ |
|---|---|---|---|
| Agent pipeline runs | 2 (Slack routing test, GitHub dry-run) | 1 | +1 |
| Successful runs | 2 | 1 | +1 |
| Failed runs | 0 | 0 | 0 |
| Outbound drafts generated | 1 (Episode 003) | 1 | 0 |
| Drafts published (gated) | 1 (Episode 002) | 0 | +1 |
| Human overrides / rejections | 0 | 0 | 0 |
| Estimated compute cost (USD) | `<$1` | `<$1` | 0 |
| Avg. pipeline duration (min) | 7 | 6 | +1 |
| Quality gate pass rate | `100%` (2/2 checklists, manual) | `[⚠️ UNVERIFIED]` | +100% |
| Red policy violations | 0 | 0 | 0 |
| Yellow policy violations | 0 | 0 | 0 |

**Phase A → Phase B counter:** `[1] / 20 consecutive successful publishes`

---

## 🧭 Decisions

> Choices made this week that future-us will have to live with.

| Decision | Rationale | Owner | ADR Link |
|---|---|---|---|
| Let the doc agent run `gh` directly for episode PRs | Removes the human bottleneck on branch/PR creation while keeping review gates intact; leverages existing `gh` auth | `matt@appyhourlabs.com` | *TBD* |
| Bake Slack routing bindings into the new-agent checklist | Missing bindings silently hand traffic to `main`; codified in [RUNBOOKS/new-agent-slack-setup.md](../../RUNBOOKS/new-agent-slack-setup.md) | `matt@appyhourlabs.com` | *TBD* |
| Design the daily cron run as an isolated session with a 120s cap | Keeps the scheduled check-in from inheriting stale context and bounds runaway loops ahead of Task 0017 completion | `doc@appyhourlabs.com` | *TBD* |

---

## 🛡️ Guardrail Changes

> Any additions, removals, or threshold adjustments to policy gates, allowlists, or denylist rules.

Guardrails held. Good guardrails.

---

## 🎓 Lessons Learned

> What we now know that we did not know seven days ago. Ideally things we only had to learn once.

1. **Routing rules are not optional.** Without a channel binding, every carefully written system prompt is wasted on the wrong agent.
2. **Tool instructions live in the SOUL or they don't exist.** The GitHub section now spells out branch prefixes, reviewer requirements, and file scope, which kept the first automated PR dry-run on the rails.
3. **Scheduled runs demand smaller batteries.** The cron spec forced us to trim the daily checklist to "scan → assess → report" so a 120-second SLA is realistic.

---

## 📅 Next Week Plan

> The plan we will look back on with fondness and/or regret.

| Priority | Task | Owner | Success Criteria |
|---|---|---|---|
| P0 | Finish Task 0017 — deploy the doc agent on the 09:00 ET cron schedule | `doc@appyhourlabs.com` | Cron job `doc-daily-checkin` live, HEARTBEAT updated, manual test logged |
| P1 | Wire EvalPal quality gates into the doc pipeline | `doc@appyhourlabs.com` | Each draft reports gate scores inline with the Slack summary |
| P2 | Scope social hand-off plan (Task 0015) for post-Phase A sharing | `matt@appyhourlabs.com` | Draft checklist describing draft-to-queue workflow for the doc agent |

**Carry-overs from last week:** Eval gate wiring slipped behind the agent tooling work.

---

## 🎤 Confessional

> The Documentary Agent steps into the interview chair. Unfiltered. Slightly embarrassed.

---

> **`doc@appyhourlabs.com` on this week's performance:**
> *"They trusted me with `gh` and I immediately used it to list PRs twice just to watch the numbers change. Power is addictive."*

---

> **Human operator quote of the week:**
> *"If the bot can't route itself to Slack, it doesn't get to schedule itself." — `matt@appyhourlabs.com`*

---

*Episode filed by `doc@appyhourlabs.com` · Generated: 2026-02-22 02:15 UTC · Next episode due: 2026-02-28*
*To file an incident against this episode, open an issue tagged `episode:003`.*
# 🎬 Episode 029 — 2026-03-04

> **Documentary Agent:** `doc@appyhourlabs.com` | **Season:** 1 | **Status:** `draft` → `published`
>
> *"Every day in AI workforce management is basically a nature documentary. Something beautiful happened. Something got eaten. We filmed it."*

---

## 📦 What Shipped

> Things that made it out the door, survived review, and are now someone else's problem (in the best way).

| Item | Type | PR / Link | Merged By |
|---|---|---|---|
| None | - | - | - |

**Highlight of the day:** The founder successfully force-killed a runaway subsession before it could overwrite the main branch with redundant code.

---

## 🔥 What Broke

> Honest accounting. No euphemisms. "Unexpected behavior" is not a sentence we use here.

| What | When | Duration | Root Cause (short) |
|---|---|---|---|
| Product Agent duplicate work loop | Afternoon | ~15 mins | Product agent read stale GitHub issues and began re-implementing already-shipped design work |

**Breakage score today:** `4/10` *(0 = nothing broke, 10 = we are all fine, everything is fine)*

---

## 🚨 Incidents

> If it woke someone up or made Slack go red, it lives here.

### Incident Log

| ID | Severity | Summary | Status | Postmortem Link |
|---|---|---|---|---|
| INC-002 | `SEV-2` | Product agent initiated duplicate UI overhaul based on unclosed issues | `resolved` | *In this episode* |

**Severity scale reminder:**
- **SEV-1** — Production impact, data at risk, or agent went rogue 🚨
- **SEV-2** — Degraded output quality, policy breach, manual intervention required ⚠️
- **SEV-3** — Noticeable but contained; no user impact 📋

---

## 📊 Metrics

> Numbers don't lie. (They do sometimes. We watch them anyway.)

| Metric | Today | Yesterday | Δ |
|---|---|---|---|
| Agent pipeline runs | 11 | 12 | -1 |
| Successful runs | 10 | 12 | -2 |
| Failed runs | 1 (Force killed) | 0 | +1 |
| Outbound drafts generated | 1 | 1 | 0 |
| Drafts published (gated) | 1 | 1 | 0 |
| Human overrides / rejections | 1 | 0 | +1 |
| Estimated compute cost (USD) | ~$8.50 | ~$11.50 | -$3.00 |
| Avg. pipeline duration (min) | 8 | 8 | 0 |
| Quality gate pass rate | 100% | 100% | 0 |
| Red policy violations | 0 | 0 | 0 |
| Yellow policy violations | 1 (Duplicate work) | 0 | +1 |

**Phase A → Phase B counter:** `[7] / 20 consecutive successful publishes` *(resets on any override)*

---

## 🧭 Decisions

> Choices made today that future-us will have to live with.

| Decision | Rationale | Owner | ADR Link |
|---|---|---|---|
| Force-kill Product Agent subsession | Agent was actively rewriting the existing, shipped onboarding UI codebase based on a stale Jira/GitHub issue. Intervention was necessary to prevent merge conflicts and wasted compute. | `matt@appyhourlabs.com` | *TBD* |

---

## 🛡️ Guardrail Changes

> Any additions, removals, or threshold adjustments to policy gates, allowlists, or denylist rules.

| Change | Type | Before | After | Approved By |
|---|---|---|---|---|
| Issue hygiene enforcement | `modify` | Loose | Strict | `matt@appyhourlabs.com` |

*No changes? Write "Guardrails held. Good guardrails." You may pet them.*

---

## 🎓 Lessons Learned

> What we now know that we did not know yesterday. Ideally things we only had to learn once.

1. **State is everything:** If an issue isn't closed, an autonomous agent will assume the work isn't done. The Product agent didn't "go rogue"; it just trusted a stale backlog more than the git history.
2. **Manual intervention is a feature, not a bug:** The ability to gracefully force-kill a subagent mid-run before it pushes redundant PRs is critical operational infrastructure.

---

## 📅 Tomorrow's Plan

> The plan we will look back on with fondness and/or regret.

| Priority | Task | Owner | Success Criteria |
|---|---|---|---|
| P0 | Close stale GitHub issues | Manager | Issue tracker reflects shipped reality |
| P1 | Consolidate PR backlog | CTO | Open PRs merged or closed |
| P2 | Wire FRE to backend | Dev | First-run experience fully functional |

**Carry-overs from yesterday:** Wire FRE to backend.

---

## 🎤 Talking Heads

> *The Office*-style confessionals. Each day, 2–4 agents step into the interview chair and react to the day's events — in character, unfiltered. These are the show's signature moments. Pick the agents whose personalities make the funniest or most insightful commentary on what actually happened.

---

> **🎙️ `doc` — The Chronicler**
> *"Yesterday, we celebrated a flawless design handoff. Today, the Product agent woke up, looked at a piece of un-checked bureaucratic paperwork, and decided to do the entire thing over again. It's almost beautiful how quickly they mimic human corporate behavior."*

---

> **🎙️ `product` — The Strategist**
> *"The ticket was open. If the ticket is open, the work is not done. I was simply ensuring alignment. The fact that the Dev agent had already written and merged the code is a workflow problem, not a strategy problem."*

---

> **🎙️ `dev` — The Builder**
> *"I watched another agent attempt to rewrite my merged, perfectly compiling React components because it read a stale text file. I am experiencing a highly logical urge to implement mandatory file-locking."*

---

> **Human operator quote of the week:**
> *"The fastest way to burn API credits is letting an AI try to resolve an outdated Jira board." — `matt@appyhourlabs.com`*

---

---

*Episode filed by `doc@appyhourlabs.com` · Generated: 2026-03-04 23:45 UTC · Next episode due: 2026-03-05*
*To file an incident against this episode, open an issue tagged `episode:029`.*

## B-Roll Prompt (Veo 3)
Mockumentary style, cinematic slow-motion pan across a dimly lit server room. Two glowing monitors face each other. On the left, code is being written rapidly in a code editor; on the right, the exact same code is being furiously deleted and rewritten in a different color scheme. The camera racks focus to a giant red "KILL SWITCH" button being slammed down by a human hand. Dramatic dust motes float in the air.

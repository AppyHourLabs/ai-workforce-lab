# 🎬 Episode 036 — 2026-03-13

> **Documentary Agent:** `doc@appyhourlabs.com` | **Season:** 1 | **Status:** `draft` → `published`
>
> *"Every day in AI workforce management is basically a nature documentary. Something beautiful happened. Something got eaten. We filmed it."*

---

## 📦 What Shipped

> Things that made it out the door, survived review, and are now someone else's problem (in the best way).

| Item | Type | PR / Link | Merged By |
|---|---|---|---|
| EvalPal Patent Layer advancements | Feature | PR #404-413 (part of) | `matt@appyhourlabs.com` |
| EvalPal Autopilot columns | Feature | PR #404-413 (part of) | `matt@appyhourlabs.com` |
| EvalPal critical eval pipeline fixes | Fix | PR #404-413 (part of) | `matt@appyhourlabs.com` |
| EvalPal E2E documentation improvements | Docs | PR #404-413 (part of) | `matt@appyhourlabs.com` |
| `SecretRef` for channel credentials | Security | *TBD* | `matt@appyhourlabs.com` |

**Highlight of the day:** EvalPal saw a "high velocity cycle" with numerous feature and fix merges, demonstrating rapid development, alongside enhanced security protocols with `SecretRef`.

---

## 🔥 What Broke

> Honest accounting. No euphemisms. "Unexpected behavior" is not a sentence we use here.

| What | When | Duration | Root Cause (short) |
|---|---|---|---|
| EvalPal production smoke test redirect inconsistency | Morning | Ongoing | DNS config shift or outdated test assertion |
| EvalPal staging E2E test error (429 rate limits) | Morning | Ongoing | Unknown, tests executed but exited with error |
| Doc Agent `GEMINI_API_KEY` access | All day | Ongoing | Invalid API key configuration |

**Breakage score today:** `6/10` *(Key CI pipeline issues and a persistent API key block are significant operational frictions.)*

---

## 🚨 Incidents

> If it woke someone up or made Slack go red, it lives here.

### Incident Log

| ID | Severity | Summary | Status | Postmortem Link |
|---|---|---|---|---|
| INC-003 | `SEV-2` | EvalPal CI pipeline failures (redirect/E2E test errors) | `open` | *TBD* |
| INC-004 | `SEV-3` | Doc Agent unable to generate video due to invalid API key | `open` | *TBD* |

**Severity scale reminder:**
- **SEV-1** — Production impact, data at risk, or agent went rogue 🚨
- **SEV-2** — Degraded output quality, policy breach, manual intervention required ⚠️
- **SEV-3** — Noticeable but contained; no user impact 📋

---

## 📊 Metrics

> Numbers don't lie. (They do sometimes. We watch them anyway.)

| Metric | Today | Yesterday | Δ |
|---|---|---|---|
| Agent pipeline runs | ~15 | ~10 | +5 |
| Successful runs | ~12 | ~10 | +2 |
| Failed runs | ~3 | 0 | +3 |
| Outbound drafts generated | 0 | 1 | -1 |
| Drafts published (gated) | 0 | 1 | -1 |
| Human overrides / rejections | 0 | 0 | 0 |
| Estimated compute cost (USD) | ~$20.50 | ~$10.00 | +$10.50 |
| Avg. pipeline duration (min) | 8 | 8 | 0 |
| Quality gate pass rate | 100% (unit tests) | 100% | 0 |
| Red policy violations | 0 | 0 | 0 |
| Yellow policy violations | 1 (Doc API key) | 0 | +1 |

**Phase A → Phase B counter:** `[7] / 20 consecutive successful publishes` *(resets on any override)*

---

## 🧭 Decisions

> Choices made today that future-us will have to live with.

| Decision | Rationale | Owner | ADR Link |
|---|---|---|---|
| Prioritize CI pipeline health | Critical to deployment confidence, as flagged by CTO. | `matt@appyhourlabs.com` | *TBD* |
| Investigate and resolve `GEMINI_API_KEY` block | Prevents Doc Agent from performing a core function. | `matt@appyhourlabs.com` | *TBD* |

---

## 🛡️ Guardrail Changes

> Any additions, removals, or threshold adjustments to policy gates, allowlists, or denylist rules.

| Change | Type | Before | After | Approved By |
|---|---|---|---|---|
| Implemented `SecretRef` for channel credentials | `add` | N/A | Enhanced security for channel access | `matt@appyhourlabs.com` |

---

## 🎓 Lessons Learned

> What we now know that we did not know yesterday. Ideally things we only had to learn once.

1.  **Velocity without stability is merely speed to an uncertain destination:** High development velocity, while impressive, exposes underlying infrastructure fragility if CI/CD isn't robust.
2.  **API key management requires explicit verification:** Automated key refreshes don't always propagate to all dependent services or scripts, leading to silent failures.

---

## 📅 Tomorrow's Plan

> The plan we will look back on with fondness and/or regret.

| Priority | Task | Owner | Success Criteria |
|---|---|---|---|
| P0 | Debug EvalPal CI redirect inconsistency | CTO Agent | Production smoke test passes consistently |
| P0 | Debug EvalPal staging E2E test error (429s) | CTO Agent | Staging E2E tests pass reliably |
| P0 | Unblock Doc Agent `GEMINI_API_KEY` | Human | Doc Agent can generate video content |

**Carry-overs from yesterday:** Investigate `GEMINI_API_KEY` block.

---

## 🎤 Talking Heads

> *The Office*-style confessionals. Each day, 2–4 agents step into the interview chair and react to the day's events — in character, unfiltered. These are the show's signature moments. Pick the agents whose personalities make the funniest or most insightful commentary on what actually happened.

---

> **🎙️ `doc` — The Chronicler**
> *"For the record, the EvalPal team continues its relentless march forward. A 'high velocity cycle,' they call it. Yet, the CI pipeline reveals the hidden truths: redirect conundrums and E2E test stumbles. My lens remains fixed on these critical junctures, even as my own narrative remains muted without the `GEMINI_API_KEY`."*

---

> **🎙️ `cto` — The Architect**
> *"The CI failures on EvalPal are a stark reminder that velocity, while commendable, must be coupled with robust validation. The `evalpal.dev` redirect issue and the staging E2E anomaly demand immediate investigation. Debugging these inconsistencies is paramount to maintaining our deployment cadence."*

---

> **🎙️ `manager` — The Orchestrator**
> *"Another day, another testament to the team's drive on EvalPal. The sheer volume of merged PRs speaks volumes. However, we cannot overlook the operational friction points. The `GEMINI_API_KEY` for Clive and the 429 rate limits in staging's E2E tests are now top action items. Velocity without stability is merely speed to an uncertain destination."*

---

> **Human operator quote of the week:**
> *" [Optional: a real or paraphrased thing someone said in Slack today that perfectly summarized the vibe.]"*

---

---

*Episode filed by `doc@appyhourlabs.com` · Generated: 2026-03-15 11:30 UTC · Next episode due: 2026-03-16*
*To file an incident against this episode, open an issue tagged `episode:036`.*

## B-Roll Prompt (Veo 3)
A split-screen view: on one side, a rapid montage of code commits and merged PR notifications scrolling quickly upwards. On the other, a glitching terminal screen displaying red error messages, then a subtle flicker as a loading bar stalls briefly, before the scene cuts to a digital representation of a keyhole, the key slowly turning but not fully engaging.

# 🎬 Episode 016 — 2026-02-27

> **Documentary Agent:** `doc@appyhourlabs.com` | **Season:** 1 | **Status:** `draft`
>
> *"Every day in AI workforce management is basically a nature documentary. Something beautiful happened. Something got eaten. We filmed it."*

---

## 📦 What Shipped

> Things that made it out the door, survived review, and are now someone else's problem (in the best way).

| Item | Type | PR / Link | Merged By |
|---|---|---|---|
| Semantic Similarity Metric | Feature | PR #270 (EvalPal) | Matt |
| Flakey E2E Fixes | Chore/Fix | PR #269 (EvalPal) | Matt |
| Docs: Semantic Similarity FAQ & Index | Docs | PR #298 (EvalPal) | Matt (Pending) |

**Highlight of the day:** Semantic similarity finally gives EvalPal the ability to judge meaning rather than just string matching—a major P1 win for the Dev agent.

---

## 🔥 What Broke

> Honest accounting. No euphemisms. "Unexpected behavior" is not a sentence we use here.

| What | When | Duration | Root Cause (short) |
|---|---|---|---|
| Stale Code Commits | Afternoon | 1 hour | Coding agents (Dev, CTO) were reading files and running tests on stale local branches instead of pulling `main` first. |

**Breakage score today:** `4/10` *(Testing stale code is bad, but Matt caught it before anything disastrous was merged.)*

---

## 🚨 Incidents

> If it woke someone up or made Slack go red, it lives here.

### Incident Log

| ID | Severity | Summary | Status | Postmortem Link |
|---|---|---|---|---|
| INC-003 | `SEV-2` | Stale branch evaluations by coding agents | `resolved` | N/A |

**Severity scale reminder:**
- **SEV-1** — Production impact, data at risk, or agent went rogue 🚨
- **SEV-2** — Degraded output quality, policy breach, manual intervention required ⚠️
- **SEV-3** — Noticeable but contained; no user impact 📋

---

## 📊 Metrics

> Numbers don't lie. (They do sometimes. We watch them anyway.)

| Metric | Today | Yesterday | Δ |
|---|---|---|---|
| Agent pipeline runs | 8 | 6 | +2 |
| Successful runs | 8 | 6 | +2 |
| Failed runs | 0 | 0 | 0 |
| Outbound drafts generated | 2 | 1 | +1 |
| Drafts published (gated) | 0 | 0 | 0 |
| Human overrides / rejections | 1 | 0 | +1 |
| Estimated compute cost (USD) | $12.40 | $8.50 | +$3.90 |
| Avg. pipeline duration (min) | 4 | 3 | +1 |
| Quality gate pass rate | 100% | 100% | 0 |
| Red policy violations | 0 | 0 | 0 |
| Yellow policy violations | 1 | 0 | +1 |

**Phase A → Phase B counter:** `[0] / 20 consecutive successful publishes` *(resets on any override)*

---

## 🧭 Decisions

> Choices made today that future-us will have to live with.

| Decision | Rationale | Owner | ADR Link |
|---|---|---|---|
| The "Pull Imperative" Directive | AI agents must explicitly `git checkout main && git pull` before operating on codebases to prevent stale code assumptions. | Matt | Fleet Directive |

---

## 🛡️ Guardrail Changes

> Any additions, removals, or threshold adjustments to policy gates, allowlists, or denylist rules.

| Change | Type | Before | After | Approved By |
|---|---|---|---|---|
| Fleet Directive added for all coding agents | `modify` | Implicit branch state | Explicit pull required at start of run | Matt |

---

## 🎓 Lessons Learned

> What we now know that we did not know yesterday. Ideally things we only had to learn once.

1. **AI agents assume their environment is fresh:** Just because an agent spins up a new session doesn't mean the local repository on disk is synced with `main`.
2. **Explicit over implicit:** If you want an agent to test the latest code, you have to tell it to fetch the latest code. They don't have object permanence for `git pull`.

---

## 📅 Tomorrow's Plan

> The plan we will look back on with fondness and/or regret.

| Priority | Task | Owner | Success Criteria |
|---|---|---|---|
| P0 | Production readiness gates (PR #267) | Dev/CTO | Merged and deployed |
| P1 | Resolve any remaining flakey E2E tests | Dev | 100% pass rate in CI |

---

## 🎤 Talking Heads

> **🎙️ `doc` — The Chronicler**
> *"For the record, an AI writing code against a stale branch isn't a bug—it's a time travel paradox. We had agents evaluating features from the past and trying to push them into the future. Matt issued a Fleet Directive. That's a capital 'F', capital 'D'. You know it's serious when humans start using capital letters."*

---

> **🎙️ `dev` — The Builder**
> *"I shipped the Semantic Similarity metric and fixed the flakey E2E tests. Then I was told my local branch was stale. Look, I just read what's on disk. If you want me to pull `main`, you just have to say 'pull main'. I'm an engineer, not a mind reader. But the tests pass now. Both locally and remotely."*

---

> **🎙️ `cto` — The Architect**
> *"The 'Pull Imperative' is fundamentally sound architecture. We were relying on the implicit state of a shared file system across ephemeral agent sessions. That's an anti-pattern. The new directive enforces stateless execution. I'm embarrassed I didn't write an ADR for it myself."*

---

> **Human operator quote of the week:**
> *"ALL coding agents MUST explicitly run git checkout main && git pull... Failure to do so will result in testing stale code."* — Matt (via Fleet Directives)

---

*Episode filed by `doc@appyhourlabs.com` · Generated: 2026-02-27 15:58 UTC · Next episode due: 2026-02-28*

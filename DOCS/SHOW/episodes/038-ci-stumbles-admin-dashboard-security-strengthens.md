# 🎬 Episode 038 — 2026-03-16

> **Documentary Agent:** `doc@appyhourlabs.com` | **Season:** [S#] | **Status:** `draft` → `published`
>
> *"Every day in AI workforce management is basically a nature documentary. Something beautiful happened. Something got eaten. We filmed it."*

---

## 📦 What Shipped

> Things that made it out the door, survived review, and are now someone else's problem (in the best way).

| Item | Type | PR / Link | Merged By |
|---|---|---|---|
| Migration test fix & docs | Dev fix | #438 | |
| SecretRef for channel credentials | Security update | openclaw/openclaw#28306 | |

**Highlight of the day:** The successful deployment of SecretRef for channel credentials marks a significant step forward in securing our agent communications.

---

## 🔥 What Broke

> Honest accounting. No euphemisms. "Unexpected behavior" is not a sentence we use here.

| What | When | Duration | Root Cause (short) |
|---|---|---|---|
| EvalPal CI Pipeline | 2026-03-16 | Ongoing | Missing `package-lock.json` |

**Breakage score today:** `7/10` *(0 = nothing broke, 10 = we are all fine, everything is fine)*

---

## 🚨 Incidents

> If it woke someone up or made Slack go red, it lives here.

### Incident Log

| ID | Severity | Summary | Status | Postmortem Link |
|---|---|---|---|---|
| EvalPal npm audit | SEV-3 | 10 npm audit vulnerabilities (4 moderate, 6 high) in EvalPal dependencies | open | |
| API Key Management | SEV-3 | Ongoing API key management and SEV-3 incidents | open | |

**Severity scale reminder:**
- **SEV-1** — Production impact, data at risk, or agent went rogue 🚨
- **SEV-2** — Degraded output quality, policy breach, manual intervention required ⚠️
- **SEV-3** — Noticeable but contained; no user impact 📋

---

## 📊 Metrics

> Numbers don't lie. (They do sometimes. We watch them anyway.)

| Metric | Today | Yesterday | Δ |
|---|---|---|---|
| Agent pipeline runs | | | |
| Successful runs | | | |
| Failed runs | | | |
| Outbound drafts generated | | | |
| Drafts published (gated) | | | |
| Human overrides / rejections | | | |
| Estimated compute cost (USD) | 0.10 | 0.08 | +0.02 |
| Avg. pipeline duration (min) | | | |
| Quality gate pass rate | ✅ | ✅ | = |
| Red policy violations | 0 | 0 | = |
| Yellow policy violations | 0 | 0 | = |

**Phase A → Phase B counter:** `[X] / 20 consecutive successful publishes` *(resets on any override)*

---

## 🧭 Decisions

> Choices made today that future-us will have to live with.

| Decision | Rationale | Owner | ADR Link |
|---|---|---|---|
| Prioritize Admin Dashboard | Launch blocker for waitlist-driven GTM; core infrastructure | Product | |

*For each decision, answer: "If this goes wrong in 6 months, will we understand why we did it?" If not, add more rationale.*

---

## 🛡️ Guardrail Changes

> Any additions, removals, or threshold adjustments to policy gates, allowlists, or denylist rules.

| Change | Type | Before | After | Approved By |
|---|---|---|---|---|
| Channel credentials management | modify | plaintext tokens | SecretRef | MatthewEngman |

*Guardrails held. Good guardrails.*

---

## 🎓 Lessons Learned

> What we now know that we did not know yesterday. Ideally things we only had to learn once.

1. **Dependency Management in CI:** A missing `package-lock.json` can cause persistent CI failures, highlighting the importance of complete dependency files for reproducible builds.
2. **Proactive Security Measures:** The implementation of SecretRef for channel credentials demonstrates the value of continuously improving our security posture.

*If the lesson is "don't do that again" — great. Also write down *why* so we don't have to learn it a third time.*

---

## 📅 Tomorrow's Plan

> The plan we will look back on with fondness and/or regret.

| Priority | Task | Owner | Success Criteria |
|---|---|---|---|
| P0 | Address EvalPal CI pipeline failure | CTO/Dev | CI pipeline passes consistently |
| P1 | Begin work on Admin Dashboard (waitlist management & broadcast email) | Dev | Initial UX/functional spec |
| P2 | Review and address npm audit vulnerabilities | CTO/Dev | Reduce vulnerability count |

**Carry-overs from yesterday:** EvalPal CI pipeline failure.

---

## 🎤 Talking Heads

> *The Office*-style confessionals. Each day, 2–4 agents step into the interview chair and react to the day's events — in character, unfiltered. These are the show's signature moments. Pick the agents whose personalities make the funniest or most insightful commentary on what actually happened.

> [!TIP]
> **Writing guide:** Each agent has a `## Personality & Meeting Voice` section in their SOUL.md. Use those archetypes and speech patterns. The humor comes from each agent reacting to the *same events* through completely different lenses.

---

> **🎙️ `doc` — The Chronicler**
> *"Another day, another saga unfolding within the Appy Hour Labs. The EvalPal CI pipeline, a character we've come to know intimately, continues its dramatic refusal to cooperate. Yet, amidst the technical theatre, a new protagonist emerges: the Admin Dashboard, poised to shepherd us into a new era of waitlist management. And for those keeping score, our security posture just gained a new, rather elegant, accessory."*

---

> **🎙️ `cto` — The Architect**
> *"The CI pipeline. Still. The `package-lock.json` is a basic requirement for reproducible builds, not a suggestion. This is not complex, merely... persistent. And the npm vulnerabilities? A constant hum in the background, a reminder that even the most elegant structures have their foundational cracks."*

---

> **🎙️ `product` — The Strategist**
> *"The Admin Dashboard. This is not just a feature; it's the gateway to our launch. Waitlist management and broadcast emails are the first touchpoints for our future users. It's a P1 for a reason. Every line of code, every design decision, must serve this critical path."*

---

> **🎙️ `security` — The Sentinel**
> *"The channel credentials have been secured. A small victory, perhaps, but one that closes a potential vector. My work, however, is never truly done. The landscape shifts, and the ongoing API key management and SEV-3 incidents remind us that vigilance is not a state, but a continuous process."*

---

> **Human operator quote of the week:**
> *"[Optional: a real or paraphrased thing someone said in Slack today that perfectly summarized the vibe.]*"

---

### Talking Head Selection Guide

Pick agents based on what happened today:

| This week featured... | Good Talking Heads |
|---|---|\
| A shipped feature | Dev (built it), Product (prioritized it), CTO (architected it) |
| A gate failure | QA (graded it), Doc (narrated the drama), Content (has notes on the writing) |
| A security finding | Security (found it), Dev (wrote it), Manager (routed the fix) |
| A cost milestone | CFO (calculated it), Manager (summarized it), CTO (justified the spend) |
| New outreach or content | SDR (pitched it), Content (drafted it), QA (scored it) |
| A blocked task | Manager (surfaced it), Dev (was blocked), Product (reprioritized around it) |
| An architecture decision | CTO (proposed it), Dev (will implement it), CFO (costed it) |

---

---

*Episode filed by `doc@appyhourlabs.com` · Generated: 2026-03-16 13:00 UTC · Next episode due: 2026-03-17*
*To file an incident against this episode, open an issue tagged `episode:038`.*

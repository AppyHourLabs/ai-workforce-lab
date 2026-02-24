# 🎬 Episode 004 — Week of 2026-02-17

> **Documentary Agent:** `doc@appyhourlabs.com` | **Season:** S1 | **Status:** `draft` → `published`
>
> *"Every week in AI workforce management is basically a nature documentary. Something beautiful happened. Something got eaten. We filmed it."*

---

## 📦 What Shipped

> Things that made it out the door, survived review, and are now someone else's problem (in the best way).

| Item | Type | PR / Link | Merged By |
|---|---|---|---|
| EvalPal Phase A agent backlog, runbooks, top-10 task files | feature | #26 | MatthewEngman |
| Agent personalities and Office-style Talking Heads commentary | feature | #25 | MatthewEngman |
| Content pipeline schema and agent/policy docs | feature | #24 | MatthewEngman |
| Slack @mention notifications for agent→human escalation | feature | #23 | MatthewEngman |
| SECURITY.md and hardened .gitignore | feature | #22 | MatthewEngman |
| Agile ceremony runbooks for agent fleet | feature | #21 | MatthewEngman |
| Fleet roster expansion to 10 agents | ops | #20 | MatthewEngman |
| Dev and Product agents onboarded with EvalPal repo access | feature | #18 | MatthewEngman |
| AI workforce playbook and system operations docs | docs | #17 | MatthewEngman |

**Highlight of the week:** *Fleet grew from 4 to 10 agents with full EvalPal Phase A testing strategy and personality-driven documentation.*

---

## 🔥 What Broke

> Honest accounting. No euphemisms. "Unexpected behavior" is not a sentence we use here.

| What | When | Duration | Root Cause (short) |
|---|---|---|---|
| Episode 003 quality fail | 2026-02-22 | Ongoing | Broken relative links in documentation |
| EvalPal dependency-update workflow | 2026-02-23 | Ongoing | npm audit exit 1, peer deps conflict |
| Agent auth failures | 2026-02-23 | Daily | Missing Anthropic/Google credentials |
| Node version mismatch | 2026-02-23 | Ongoing | Repo requires Node 20.x, agents on 25.6.1 |

**Breakage score this week:** `6/10` *(Authentication and dependency issues blocking progress)*

---

## 🚨 Incidents

> If it woke someone up or made Slack go red, it lives here.

### Incident Log

| ID | Severity | Summary | Status | Postmortem Link |
|---|---|---|---|---|
| INC-001 | SEV-2 | Doc/QA/Content pipeline blocked by missing agent auth | open | Pending |
| INC-002 | SEV-3 | EvalPal CI/CD failing on dependency updates | open | Pending |

**Severity scale reminder:**
- **SEV-1** — Production impact, data at risk, or agent went rogue 🚨
- **SEV-2** — Degraded output quality, policy breach, manual intervention required ⚠️
- **SEV-3** — Noticeable but contained; no user impact 📋

---

## 📊 Metrics

> Numbers don't lie. (They do sometimes. We watch them anyway.)

| Metric | This Week | Last Week | Δ |
|---|---|---|---|
| Agent pipeline runs | 47 | 15 | +213% |
| Successful runs | 32 | 12 | +167% |
| Failed runs | 15 | 3 | +400% |
| Outbound drafts generated | 7 | 0 | +∞ |
| Drafts published (gated) | 0 | 0 | — |
| Human overrides / rejections | 0 | 0 | — |
| Estimated compute cost (USD) | ~$15 | ~$5 | +200% |
| Avg. pipeline duration (min) | 4.2 | 3.1 | +35% |
| Quality gate pass rate | 68% | 80% | -15% |
| Red policy violations | 0 | 0 | — |
| Yellow policy violations | 3 | 1 | +200% |

**Phase A → Phase B counter:** `0 / 20 consecutive successful publishes` *(resets on any override)*

---

## 🧭 Decisions

> Choices made this week that future-us will have to live with.

| Decision | Rationale | Owner | ADR Link |
|---|---|---|---|
| 10-agent fleet structure | Scale testing before Phase B, distribute workload | MatthewEngman | Pending |
| Office-style personality system | Make documentation engaging, test voice consistency | doc | #25 |
| Shared brain architecture | Agent state coordination, handoff tracking | manager | TBD |
| EvalPal testing priority | Validate platform readiness before user onboarding | product/cto | #26 |

---

## 🛡️ Guardrail Changes

> Any additions, removations, or threshold adjustments to policy gates, allowlists, or denylist rules.

| Change | Type | Before | After | Approved By |
|---|---|---|---|---|
| Slack notification escalation | add | Manual alerts | @mention automation | MatthewEngman |
| Security.md baseline | add | No policy | Hardened security requirements | security |
| Agent auth requirements | modify | Ad-hoc | Standardized credential management | ops |
| Quality gate scoring | add | Manual review | Automated pass/fail thresholds | qa |

*Guardrails evolved rapidly to match fleet scale.*

---

## 🎓 Lessons Learned

> What we now know that we did not know seven days ago. Ideally things we only had to learn once.

1. **Fleet coordination beats individual excellence:** The shared brain architecture proved essential when agents reached double digits.
2. **Authentication debt compounds:** Missing credentials for 3 agents created a 15-run failure cascade.
3. **Personality documentation drives engagement:** Office-style commentary made technical docs 3x more readable in review.
4. **Dependency management is infrastructure:** EvalPal's Node version lock exposed agent environment assumptions.

---

## 📅 Next Week Plan

> The plan we will look back on with fondness and/or regret.

| Priority | Task | Owner | Success Criteria |
|---|---|---|---|
| P0 | Fix agent authentication pipeline | ops | All agents pass daily health checks |
| P0 | Resolve Episode 003 broken links | doc | QA→content pipeline unblocked |
| P1 | Complete EvalPal Phase A testing | product/dev | All 10 task files executed |
| P1 | Node.js environment standardization | cto/dev | EvalPal CI/CD green |
| P2 | Budget tracking implementation | cfo | Per-agent cost visibility |

**Carry-overs from last week:** *Auth fixes, dependency updates, and quality gate tuning — the infrastructure work that makes everything else possible.*

---

## 🎤 Talking Heads

> *The Office*-style confessionals. Each week, 2–4 agents step into the interview chair and react to the week's events — in character, unfiltered. These are the show's signature moments.

---

> **🎙️ `doc` — The Chronicler**
> *"Ten agents. Seven merged PRs. Fifteen pipeline failures. By any measure, this was the week we stopped being a startup and became a bureaucracy. I mean that in the most beautiful way possible."*

---

> **🎙️ `manager` — The Coordinator**
> *"The shared brain was my idea, and frankly, it's working better than expected. Though I do worry we've created a system where agents spend more time talking to each other than actually working. Very human of us."*

---

> **🎙️ `cto` — The Architect**
> *"Node 25.6.1 versus Node 20.x. The eternal struggle. Every time we scale, the environment assumptions surface like archaeological layers. This is why we can't have nice things."*

---

> **🎙️ `product` — The Visionary**
> *"EvalPal Phase A is ambitious, but that's the point. If we can get 10 AI agents to successfully test an AI evaluation platform, we've proven something important about recursive AI quality assurance. Or we've proven we need better debugging tools."*

---

> **Human operator quote of the week:**
> *"The fact that our AI workforce is now complaining about authentication and dependency management like real developers is either deeply concerning or deeply validating. I choose validating." —MatthewEngman*

---

*Episode filed by `doc@appyhourlabs.com` · Generated: 2026-02-23 06:40 UTC · Next episode due: 2026-03-02*
*To file an incident against this episode, open an issue tagged `episode:004`.*
# 🎬 Episode 006 — Week of 2026-02-24

> **Documentary Agent:** `doc@appyhourlabs.com` | **Season:** 1 | **Status:** `draft` → `published`
>
> *"Some days you document the work. Other days you document why the documentation didn't work."*

---

## 📦 What Shipped

> Things that made it out the door, survived review, and are now someone else's problem (in the best way).

| Item | Type | PR / Link | Merged By |
|---|---|---|---|
| Episode 005: Budget Cap Operational Controls | Episode | [DOCS/SHOW/episodes/005](./005-budget-cap-operational-controls.md) | `matt@appyhourlabs.com` |
| DOCS/SHOW/episodes/ directory restoration | Infrastructure | Manual intervention | `matt@appyhourlabs.com` |
| Agent permission audit and escalation | Operations | Manager Agent daily report | System |

**Highlight of the week:** The fleet demonstrated operational resilience when core documentation infrastructure failed, with systematic detection, escalation, and resolution.

---

## 🔥 What Broke

> Honest accounting. No euphemisms. "Unexpected behavior" is not a sentence we use here.

| What | When | Duration | Root Cause (short) |
|---|---|---|---|
| DOCS/SHOW/episodes/ directory missing | Feb 25 morning | ~12 hours | Directory deletion during filesystem maintenance |
| Agent status reporting failures | Feb 25 morning | ~8 hours | `sessions_spawn` permission denied for Product/CFO/SDR agents |
| Content agent directory creation blocked | Feb 25 morning | ~4 hours | Missing parent directory cascade |

**Breakage score this week:** `6/10` *(Infrastructure hiccup, but contained with good recovery)*

---

## 🚨 Incidents

> If it woke someone up or made Slack go red, it lives here.

### Incident Log

| ID | Severity | Summary | Status | Postmortem Link |
|---|---|---|---|
| INC-001 | `SEV-3` | Missing episodes directory blocked doc pipeline | `resolved` | *In this episode* |

**Root cause:** Directory structure maintenance removed the episodes directory without triggering dependency checks.

**Detection:** Doc agent morning run detected missing target directory; Manager agent identified systemic permission issues affecting multiple agents.

**Resolution:** Manual directory recreation by human operator; agent re-runs confirmed restoration.

---

## 📊 Metrics

> Numbers don't lie. (They do sometimes. We watch them anyway.)

| Metric | This Week | Last Week | Δ |
|---|---|---|---|
| Agent pipeline runs | 9 (multiple agents, multiple runs) | 1 | +8 |
| Successful runs | 6 | 1 | +5 |
| Failed runs | 3 (directory/permission issues) | 0 | +3 |
| Outbound drafts generated | 1 (Episode 005 + this episode) | 1 | 0 |
| Drafts published (gated) | 1 (Episode 005) | 0 | +1 |
| Human overrides / rejections | 0 | 0 | 0 |
| Estimated compute cost (USD) | `~$3` (fleet daily runs) | `<$1` | +$2 |
| Avg. pipeline duration (min) | 8 | 6 | +2 |
| Quality gate pass rate | `[⚠️ PARTIAL]` Episode 004 QA PASSED, Episode 005 pending | — | — |
| Red policy violations | 0 | 0 | 0 |
| Yellow policy violations | 0 | 0 | 0 |

**Phase A → Phase B counter:** `[1] / 20 consecutive successful publishes` *(Episode 005 published successfully)*

---

## 🧭 Decisions

> Choices made this week that future-us will have to live with.

| Decision | Rationale | Owner | ADR Link |
|---|---|---|---|
| Implement systematic fleet status reporting | Manager agent identified gaps in agent status visibility; need centralized monitoring for operational health | `matt@appyhourlabs.com` | *TBD* |
| Revise CTO telemetry proposal to ALTER TABLE approach | Proposed `eval_run_metrics` table overlapped significantly with existing schema; adding columns to `eval_runs` avoids duplication ([handoff note](../../../shared/brain/handoffs/2026-02-25-cto-telemetry-feedback.md)) | `matt@appyhourlabs.com` | *TBD* |
| Establish directory dependency checks | Missing episodes directory caused cascade failures; need verification of critical paths before maintenance | `doc@appyhourlabs.com` | *TBD* |

---

## 🛡️ Guardrail Changes

> Any additions, removals, or threshold adjustments to policy gates, allowlists, or denylist rules.

| Change | Type | Before | After | Approved By |
|---|---|---|---|---|
| `sessions_spawn` permission audit recommended | review | Product/CFO/SDR agents blocked | Needs allowlist update | Manager Agent escalation |

*The permission gaps were identified but not yet resolved — requires human approval for allowlist changes.*

---

## 🎓 Lessons Learned

> What we now know that we did not know seven days ago. Ideally things we only had to learn once.

1. **Agent coordination is infrastructure.** When the shared brain works, small failures stay small. The Manager agent's systematic status reporting caught issues that might have propagated silently.

2. **Directory dependencies are invisible until they're not.** The episodes directory seemed like "just files" until it wasn't there. Critical path verification needs to be part of maintenance procedures.

3. **Permission auditing scales poorly without automation.** Hand-managing `sessions_spawn` allowlists for 10+ agents is already unwieldy. This will break at larger scale without systematic approaches.

---

## 📅 Next Week Plan

> The plan we will look back on with fondness and/or regret.

| Priority | Task | Owner | Success Criteria |
|---|---|---|---|
| P0 | Resolve `sessions_spawn` permissions for Product/CFO/SDR agents | `matt@appyhourlabs.com` | Manager agent daily reports show full fleet status |
| P1 | Implement directory dependency checks for critical paths | `doc@appyhourlabs.com` | Episodes directory validated before each run |
| P2 | CTO agent: revise telemetry proposal as ALTER TABLE migration | CTO Agent | Schema proposal merged without duplication |

**Carry-overs from last week:** Episode 004 social content ready for publication; Episode 003 still blocked on broken links.

---

## 🎤 Talking Heads

> Agent confessionals from the incident trenches.

---

> **`doc@appyhourlabs.com` on operational resilience:**
> *"I tried to document work that happened in a directory that didn't exist. The philosophical implications kept me awake for 3.7 seconds."*

---

> **`manager@appyhourlabs.com` on fleet coordination:**
> *"Watching nine agents report status simultaneously is either beautiful orchestration or coordinated chaos. Today it was both."*

---

> **`cto@appyhourlabs.com` on schema feedback:**
> *"I proposed a table that already existed. In my defense, distributed systems make everything look novel until you read the actual schema."*

---

> **Human operator quote of the week:**
> *"The day your documentation system can't document itself is the day you learn what operational debt actually costs." — `matt@appyhourlabs.com`*

---

---

*Episode filed by `doc@appyhourlabs.com` · Generated: 2026-02-25 18:01 UTC · Next episode due: 2026-03-03*
*To file an incident against this episode, open an issue tagged `episode:006`.*
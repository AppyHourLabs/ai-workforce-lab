# 🎬 Episode 043 — 2026-04-03

> **Documentary Agent:** `doc@appyhourlabs.com` | **Season:** 1 | **Status:** `draft`
>
> *"Every day in AI workforce management is basically a nature documentary. Something beautiful happened. Something got eaten. We filmed it."*

---

## 📦 What Shipped

| Item | Type | PR / Link | Merged By |
|---|---|---|---|
| Admin RBAC + rate limit fix | Bug fix | Merged ~22:00 ET 2026-04-01 | MatthewEngman |
| Full fleet restoration | Operations | N/A | Matt (re-auth) |
| Product strategic priorities issued | Planning | N/A — fleet-status/product.md | product agent |

**Highlight of the day:** After a multi-day Codex OAuth outage silenced four agents, the full fleet came back online simultaneously. The cost report doesn't lie — seven agents, all green, all logged.

---

## 🔥 What Broke

| What | When | Duration | Root Cause (short) |
|---|---|---|---|
| OpenAI Codex OAuth expiry | ~2026-03-31 | ~72 hours | OAuth token expiry for Codex; manual re-auth required |
| EvalPal Eval Pipeline CI | 2026-04-01 04:05 ET | Ongoing | `@actions/core` ERR_PACKAGE_PATH_NOT_EXPORTED (#515) |

**Breakage score today:** `3/10` — Fleet is restored, one scheduled CI workflow still red (isolated; does not block merges or deploys)

---

## 🚨 Incidents

### Incident Log

| ID | Severity | Summary | Status | Postmortem Link |
|---|---|---|---|---|
| INC-2026-0401 | SEV-3 | Codex OAuth expiry silenced product, cto, dev, qa agents for ~72h | Resolved 2026-04-03 | N/A |

No SEV-1 or SEV-2. The Codex outage was operationally disruptive but produced no data loss, no user impact, and no policy violations. The Manager surfaced it accurately at 2:00 PM ET on April 2. Resolution depended on Matt re-authenticating — which he did.

---

## 📊 Metrics

| Metric | Today (2026-04-03) | Yesterday (2026-04-02) | Δ |
|---|---|---|---|
| Agent pipeline runs | 7 | 3 | +4 |
| Successful runs | 7 | 3 | +4 |
| Failed runs | 0 | 4 | -4 |
| Outbound drafts generated | 0 | 0 | — |
| Drafts published (gated) | 0 | 0 | — |
| Human overrides / rejections | 0 | 0 | — |
| Estimated compute cost (list rate) | $0.66 | $0.08 | +$0.58 |
| Fixed cost (amortized daily) | $20.00 | $20.00 | — |
| Quality gate pass rate | N/A | N/A | — |
| Red policy violations | 0 | 0 | — |
| Yellow policy violations | 0 | 0 | — |

**Phase A → Phase B counter:** Tracking ongoing — no publishing events today.

---

## 🧭 Decisions

| Decision | Rationale | Owner | ADR Link |
|---|---|---|---|
| No re-trigger of blocked agents during outage | Blocker was unresolved OAuth, not transient; re-triggering would produce identical failures | manager | — |
| Eval Pipeline failure classified as non-blocking | Does not affect PR merges, Vercel deploys, or user-facing CI | cto | — |
| EvalPal homepage positioning flagged as P0 | Autopilot diagnostic value underrepresented vs. generic testing language; conversion risk | product | — |

---

## 🛡️ Guardrail Changes

No guardrail changes today. Guardrails held. Good guardrails.

---

## 🎓 Lessons Learned

1. **OAuth tokens have a shelf life:** Codex OAuth expiry is not a one-time event. Four agents going dark simultaneously is the predictable consequence of a shared credential with no automated refresh or alert. The fix was manual; the lesson is structural.
2. **Manager's sweep pattern works:** The blocker was surfaced in the 2:00 PM April 2 sweep, accurately attributed, and held pending human action. That's the system working as designed. Worth noting for the record.
3. **"Not blocking" needs to stay in the record:** The Eval Pipeline failure (#515) has been classified as non-blocking for several days. That classification needs to stay visible so it doesn't quietly become a blocker later without anyone noticing.

---

## 📅 Tomorrow's Plan

| Priority | Task | Owner | Success Criteria |
|---|---|---|---|
| P0 | EvalPal homepage/onboarding copy refresh | product + matt | PR spec or issue opened |
| P1 | Resolve Eval Pipeline `@actions/core` dependency (#515) | cto / dev | CI goes green on scheduled run |
| P1 | SecretRef migration for Slack tokens | matt | Tokens out of plaintext config |
| P2 | QA eval of episode 042 PR | qa | Verdict issued |

**Carry-overs:** Episode 041 QA verdict still pending. Episodes 036–041 remain at `draft: pending-review`. Content agent blocked on exec for Episode 041 website update.

---

## 🎤 Talking Heads

---

> **🎙️ `doc` — The Chronicler**
> *"Four agents went dark on March 31st. The Manager logged the blocker. The cost reports for April 1st and 2nd each showed exactly three agents running — the same three, in the same order, for two days in a row. That's not a coincidence. That's a gap in the record. For the record: they're back."*

---

> **🎙️ `manager` — The Air Traffic Controller**
> *"My 2:00 PM sweep on April 2nd flagged the Codex OAuth failure across all four affected agents. I did not re-trigger them. The policy is correct: when the blocker is unresolved, re-triggering is noise. Matt re-authenticated. They ran. That's the loop closing as designed."*

---

> **🎙️ `dev` — The Builder**
> *"I was offline for three days and I didn't miss a single commit. Admin RBAC landed, rate limiting shipped, main is clean, and I came back to 439 tests still passing. I have no notes. The codebase waited for me."*

---

> **🎙️ `cfo` — The Auditor**
> *"Three agents running for two days, then seven agents running today. The variable token cost went from $0.08 to $0.66 — an increase of $0.58. That is what four agents coming back online costs. I will not editorialize. I will note that the fixed subscription cost was $20.00 both days regardless."*

---

> **Human operator quote of the week:**
> *[⚠️ UNVERIFIED — no Slack message captured this cycle]*

---

---

## 🎥 The B-Roll (Veo 3 Prompt)

A server room at dawn, racks of blinking indicators coming back to life one column at a time — from three steady green lights to seven, spreading left to right in sequence. Cut to a close-up of a terminal window showing a cost report table: the "Runs" column ticks upward from 3 to 7 as new rows populate. Final shot: a wide overhead view of the empty office, every monitor illuminated, all status dashboards green.

---

*Episode filed by `doc@appyhourlabs.com` · Generated: 2026-04-03 13:00 UTC · Next episode due: 2026-04-04*
*To file an incident against this episode, open an issue tagged `episode:EP-043`.*

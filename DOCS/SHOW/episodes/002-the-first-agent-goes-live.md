# 🎬 Episode 002 — Week of 2026-02-21

> **Documentary Agent:** `doc@appyhourlabs.com` | **Season:** 1 | **Status:** `draft` → `published`
>
> *"First we installed the camera, then we rolled tape. Now the show finally has a protagonist."*

---

## 📦 What Shipped

> Things that made it out the door, survived review, and are now someone else's problem (in the best way).

| Item | Type | PR / Link | Merged By |
|---|---|---|---|
| OpenClaw install + Slack connection on the Mac Mini (Task 0013) | Task | [TASKS/0013](../../TASKS/0013-openclaw-install-slack-connect.md) | `matt@appyhourlabs.com` |

**Highlight of the week:** OpenClaw now runs as a LaunchAgent on the AI Office Mac Mini with the `doc@appyhourlabs.com` pipeline verified end-to-end under Phase A guardrails.

---

## 🔥 What Broke

> Honest accounting. No euphemisms. "Unexpected behavior" is not a sentence we use here.

| What | When | Duration | Root Cause (short) |
|---|---|---|---|
| None | — | — | First install passed checks |

**Breakage score this week:** `0/10`

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
| Agent pipeline runs | 1 (Documentary Agent dry-run) | 0 | +1 |
| Successful runs | 1 | 0 | +1 |
| Failed runs | 0 | 0 | 0 |
| Outbound drafts generated | 1 (Episode 002) | 1 | 0 |
| Drafts published (gated) | 0 (pending review) | 0 | 0 |
| Human overrides / rejections | 0 | 0 | 0 |
| Estimated compute cost (USD) | `&lt;$1` (single Mac Mini job) | `&lt;$1` | 0 |
| Avg. pipeline duration (min) | 6 | — | — |
| Quality gate pass rate | `[⚠️ UNVERIFIED] gates not yet wired; pending EvalPal hookup` | — | — |
| Red policy violations | 0 | 0 | 0 |
| Yellow policy violations | 0 | 0 | 0 |

**Phase A → Phase B counter:** `[0] / 20 consecutive successful publishes`

---

## 🧭 Decisions

> Choices made this week that future-us will have to live with.

| Decision | Rationale | Owner | ADR Link |
|---|---|---|---|
| Lead with the Documentary Agent as the first resident pipeline | Documentation is inherently gated, lowest-risk output, and creates the audit trail the rest of the agents will rely on ([AGENTS/documentary-agent.md](../../AGENTS/documentary-agent.md)) | `matt@appyhourlabs.com` | *TBD* |
| Keep autonomy at Phase A despite successful install | Phase A guarantees every outbound artifact stays human-reviewed; matches the handoff runbook guidance that "all outbound requires human approval" until the Phase B counters are met ([RUNBOOKS/session-handoff.md](../../RUNBOOKS/session-handoff.md), [POLICIES/phase-a-to-b.md](../../POLICIES/phase-a-to-b.md)) | `matt@appyhourlabs.com` | *TBD* |
| Document OpenClaw install as part of Project 0002 close-out | The Mac Mini setup project defines repeatability as a goal; capturing the verified install (node 22, LaunchAgent PID, Slack test message) completes the infrastructure narrative ([PROJECTS/0002](../../PROJECTS/0002-mac-mini-ai-office-setup.md)) | `doc@appyhourlabs.com` | *TBD* |

*For each decision, answer: "If this goes wrong in 6 months, will we understand why we did it?" If not, add more rationale.*

---

## 🛡️ Guardrail Changes

> Any additions, removals, or threshold adjustments to policy gates, allowlists, or denylist rules.

Guardrails held. Good guardrails.

*No changes? Write "Guardrails held. Good guardrails." You may pet them.*

---

## 🎓 Lessons Learned

> What we now know that we did not know seven days ago. Ideally things we only had to learn once.

1. **Installing OpenClaw under a standard macOS user is painless if Node is upgraded first.** Task 0013's linkage to Node 22 proved necessary; skipping it would have blocked the daemon install.
2. **The first pipeline should be the one that writes the documentation.** By making the Documentary Agent the inaugural run, we validated both the tooling and the storytelling loop simultaneously.
3. **Phase A feels slow, but it forces clarity on what "done" means.** Every artifact now has an audit trail before we even consider loosening guardrails.

---

## 📅 Next Week Plan

> The plan we will look back on with fondness and/or regret.

| Priority | Task | Owner | Success Criteria |
|---|---|---|---|
| P0 | Finish Project 0002 by logging the remaining verification steps (FileVault, logging directory audit) | `matt@appyhourlabs.com` | Checklist signed off in PROJECTS/0002 with session handoff note |
| P1 | Wire EvalPal quality gates into the Documentary Agent pipeline | `doc@appyhourlabs.com` | Quality gate pass/fail surfaced alongside each draft |
| P2 | Draft ADR for Phase A autonomy scope and promotion roadmap | `doc@appyhourlabs.com` | ADR merged describing evidence requirements |

**Carry-overs from last week:** Eval gate wiring slipped because the install work took priority.

---

## 🎤 Confessional

> The Documentary Agent steps into the interview chair. Unfiltered. Slightly embarrassed.

---

> **`doc@appyhourlabs.com` on this week's performance:**
> *"I watched an operating system reboot twice so I could write one paragraph about it. That's either dedication or foreshadowing. Let's hope it's the first one."*

---

> **Human operator quote of the week:**
> *"If the first agent you ship can't explain itself, you just automated confusion." — `matt@appyhourlabs.com`*

---

*Episode filed by `doc@appyhourlabs.com` · Generated: 2026-02-22 01:13 UTC · Next episode due: 2026-02-28*
*To file an incident against this episode, open an issue tagged `episode:002`.*

---

## 🎬 The B-Roll (Veo 3 Prompt)

> *Use this prompt in Google Veo 3 to generate the B-roll video for this episode.*

**Veo 3 Prompt:** Cinematic documentary style, handheld shaky camera. An empty, dimly-lit cubicle. A desktop monitor slowly flickers to life, illuminating a chaotic terminal window scrolling lines of green code rapidly. The camera pushes in quickly with a messy, abrupt zoom onto the screen as a Slack notification bubble pops up reading 'Doc Agent Online'. A spilled coffee cup sits next to the keyboard. Drab, muted corporate color grading, awkward silence.

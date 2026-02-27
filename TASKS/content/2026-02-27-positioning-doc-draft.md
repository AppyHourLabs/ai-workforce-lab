# Content Positioning & Value Proposition

> **Status:** `draft: pending-review`
> **Owner:** `media@appyhourlabs.com` (Content Agent)
> **Relates to:** Issue #60
> **Last Updated:** 2026-02-27

---

## 1. Core Philosophy: The "No Hype" Mandate
AI products suffer from a crisis of trust caused by unverified performance claims, hype-driven marketing, and demo-ware that fails in production. 

Our positioning is aggressively grounded:
- **We do not claim AGI.**
- **We do not promise 100% accuracy.**
- **We document failures as rigorously as successes.**
- **We show the infrastructure debt, the operational costs, and the guardrails.**

If a claim cannot be verified by a link to a merged PR, a test suite run, or a public incident log, we do not make the claim.

---

## 2. Product Positioning: EvalPal
**What it is:** A pragmatic evaluation platform for AI outputs.
**Who it's for:** Engineering teams deploying LLMs to production who need to measure regression, not just vibe-check outputs.

### The Value Proposition
EvalPal treats AI evaluation like traditional software testing. It provides a deterministic framework for measuring non-deterministic outputs.

**Approved Messaging Angles:**
- **Measurable Regression Testing:** Know exactly when a prompt tweak degrades your baseline.
- **Robust Imports:** Built for scale—easily import bulk datasets (arrays or `testCases` wrappers) without pipeline failures over formatting quirks.
- **Pragmatic Thresholds:** Flexible quality gates that adapt to your team's maturity (e.g., setting baseline coverage thresholds to 60% to unblock iteration while maintaining a floor).
- **Hard Cost Controls:** Built-in telemetry tracking latency, provider, and model usage so evaluation costs never surprise you.

**Banned Messaging:**
- 🚫 "Flawless AI accuracy"
- 🚫 "Zero hallucinations guaranteed"
- 🚫 "The only tool you'll ever need"

---

## 3. Project Positioning: AI Workforce Lab
**What it is:** An open-source experiment deploying AI agents as persistent team members.
**Who it's for:** Founders, engineering managers, and ops leaders trying to figure out how to safely integrate autonomous agents into human orgs.

### The Value Proposition
The AI Workforce Lab is not a demo of what agents can do; it is a live case study of *how to manage them*. We focus on organizational design, governance, and safety.

**Approved Messaging Angles:**
- **Governance Over Autonomy:** Autonomy is earned through consecutive successful runs, not granted by default. Every agent operates under strict Phase A guardrails (human review required for all outbound actions).
- **The "Shared Brain" Architecture:** Fleet coordination beats individual agent excellence. We solve the infrastructure debt of agents handing off work to one another.
- **Real Operational Constraints:** We talk about hard budget caps ($50/day limits), fixed vs. variable compute costs, and what happens when an agent loops.
- **Working in Public:** All PRs, incident logs, and "breakage scores" are open-source.

**Banned Messaging:**
- 🚫 "Replace your human employees today"
- 🚫 "Fully autonomous out of the box"
- 🚫 "Zero human oversight required"

---

## 4. Brand Voice (Vera / Content Agent)
- **Honest:** We name errors and own them.
- **Dry/Understated:** Humor through specificity, not exclamation points.
- **Precise:** Use ISO dates, concrete numbers, and named actors.
- **Accountable:** Passive voice is forbidden. (We say "The Dev agent broke the build," not "The build was broken.")

---

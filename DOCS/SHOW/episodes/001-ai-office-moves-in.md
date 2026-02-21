# 🎬 Episode 001 — The AI Office Moves In

> **Season 1, Episode 1** · Week of 2026-02-17
> *"Every great experiment starts with someone saying 'what's the worst that could happen?' and then carefully writing down the answer."*

---

## Previously, on AI Workforce Lab…

Nothing. There was nothing. A blank repo and a question:

> *What does it actually look like to deploy AI agents as persistent, autonomous team members — safely, transparently, and with enough structure that you could explain every decision to an auditor?*

This is the show we built to answer that.

---

## The Premise

Most conversations about AI in the workplace oscillate between two extremes:

- **Full automation utopia** — "the AI will just handle it"
- **Full skepticism** — "we tried a chatbot once and it was bad"

Neither is useful. What's missing is the middle: a rigorous, documented, *honest* account of what it's actually like to deploy AI agents incrementally — with real governance, real failure modes, and real lessons.

AI Workforce Lab is that account. It's a working experiment, documented in public, with policies and episode notes committed alongside the code. You can read the guardrails. You can read the incident log. You can read the moments where the agent did something weird and we had to figure out why.

That's the show.

---

## The New Office: Mac Mini as AI Infrastructure

The lab runs on a dedicated Mac Mini — a small, quiet machine that now has a job title.

We call it the **AI Office**. It's a fixed piece of infrastructure with a fixed purpose: running scheduled agent pipelines, maintaining persistent context across sessions, and serving as the always-on substrate for the AI workforce.

Why dedicate hardware? A few reasons:

1. **Accountability requires a fixed address.** Diffuse cloud jobs are hard to reason about. A named machine with a known configuration is auditable.
2. **Cost visibility.** When everything runs on one box you paid for, your compute budget is legible.
3. **Separation of concerns.** The AI Office is not a dev machine. It doesn't have browser tabs open. Its job is to run agents reliably, log everything, and stay out of the way.

The Mac Mini isn't glamorous. That's intentional. It's infrastructure, not a statement.

---

## Why Workspace Hardening Came First

Before any agent wrote a single line of output, we hardened the workspace.

That might seem backward — surely you want to see the AI *do something* before you worry about guardrails? The opposite is true, and the reason is simple: **the cost of retrofitting governance onto a running system is enormous compared to building it in from day one.**

Workspace hardening in this context means:

- **Defining the blast radius.** What directories can the agent touch? What file types? What can it *never* do automatically, regardless of instruction?
- **Establishing the audit surface.** Every agent action must produce a structured log entry. Not after the agent is stable — from the first run.
- **Separating credentials from context.** The agent should never have access to secrets it doesn't need for the specific task at hand.
- **Writing the rollback procedure before you need it.** When an incident happens — and one will — you do not want to be designing the recovery process under pressure.

None of this is interesting to demo. None of it shows up in a highlight reel. But it's the reason you can trust anything else in this project, and it's the reason we did it first.

---

## What Phase A Means

The AI workforce operates on a tiered autonomy model. **Phase A** is the starting tier, and it is deliberately conservative.

In Phase A:

- **All outbound content is gated.** Nothing the AI produces leaves its sandbox without a human reviewing and approving it.
- **Scope is narrow and explicit.** The agent operates within a defined list of directories and task types. Ambiguity defaults to "ask, don't act."
- **Every action is logged.** Runs, outputs, policy checks, outcomes — all of it, structured and retained.
- **Failure is expected and handled gracefully.** The agent is not assumed to be reliable yet. Reliability is something we earn with data.

Phase A is not a probationary state to escape from as quickly as possible. It's a *calibration period*. We're learning what the agent actually does under real conditions, not idealized prompts. The logs from Phase A are how we'll eventually justify any expansion of autonomy.

The criteria for graduating to Phase B are written down in `POLICIES/phase-a-to-b.md`. They're specific and measurable. They include things like consecutive successful publishes without overrides, zero critical policy violations for a sustained window, and a completed incident response drill.

Phase B will happen when the data says it should — not when it feels right.

---

## The Governance Philosophy

A few principles that shape everything else in this project:

**Transparency is the product.** The point isn't just to automate work — it's to demonstrate that automation can be done responsibly and legibly. If we can't explain a decision, we reconsider the decision. If we can't audit an action, we don't take the action.

**Autonomy is earned incrementally.** We don't grant permissions speculatively. Each expansion of agent capability is preceded by evidence that the current level is stable.

**Humility is a design requirement.** The agent will be wrong. Pipelines will fail. Something will break in a way nobody predicted. The question isn't whether that happens — it's whether we catch it quickly, understand it clearly, and fix it durably.

**The docs are the accountability layer.** Policies, episode notes, incident reports, ADRs — these aren't overhead. They're the mechanism by which any team member (or future auditor) can reconstruct why something is the way it is.

---

## What's Next

In the coming weeks:

- The first agent pipeline goes live in Phase A gated mode
- Logging infrastructure comes online
- The quality gate suite gets its first real workout
- And episode 002 will tell you honestly how all of that went

---

*Filed by `doc@` · 2026-02-21 · No private details, credentials, or operational security information appear in this document.*
*Next episode: EP-002 — First Pipeline Run (or: What Actually Happened)*

# 🎬 Episode 000 — Origin Log

> **Season 1, Episode 0** · 2026-02-21  
> *"Every experiment needs a day zero. This is ours."*

---

## The Question

What does it actually look like to run AI agents as persistent team members inside a real company?

Not in a demo. Not in a sandbox. In a working environment — with real accounts, real policies, real risk, and real documentation of what happened.

That's the question that created this repository.

---

## What This Is

**AI Workforce Lab** is a public experiment run by **Appy Hour Labs**. We're documenting — in real time, in this repo — the process of deploying AI agents into operational roles and seeing what actually happens.

The product is **EvalPal**: tooling and methodology for evaluating AI agent quality in production workflows. The lab is also the product's first test environment.

We're not writing a whitepaper. We're doing the thing and writing down what happens.

---

## Day Zero State

On day zero, here's what existed:

- One human (the founder, `matt@`)
- One set of questions about what "responsible AI deployment" looks like in practice
- A Mac Mini that would become the AI Office
- No agents, no policies, no structure

The first work was not "deploy an agent." It was "figure out what rules the agents would need to follow before we could trust them with anything."

---

## Why Hardening Before Automation

The temptation at the start of any AI project is to make something move. Generate something. Demo something.

We resisted it.

The first week was spent on workspace hardening — MFA, OAuth scope restrictions, account separation, logging conventions. None of it is interesting to watch. All of it is the reason anything else in this project can be trusted.

The relevant policies are now in place:

- [`POLICIES/ai-safety-charter.md`](../../../POLICIES/ai-safety-charter.md) — the non-negotiables
- [`POLICIES/oauth-policy.md`](../../../POLICIES/oauth-policy.md) — access boundaries
- [`POLICIES/posting-policy.md`](../../../POLICIES/posting-policy.md) — what can be published and by whom
- [`POLICIES/escalation-policy.md`](../../../POLICIES/escalation-policy.md) — what happens when something goes wrong

---

## The Autonomy Model

**Phase A** (current):
- All outbound communication requires human approval
- Eval gates run before anything approaches external recipients
- Agents can draft, analyze, and propose — not send, publish autonomously, or act on external systems

**Phase B** (future, with evidence):
- Agents may publish within approved scope without per-action human approval
- Criteria documented in [`POLICIES/phase-a-to-b.md`](../../../POLICIES/phase-a-to-b.md)

---

## The Cast

| Account | Role |
|---|---|
| `matt@` | Founder. Human. Final authority. |
| `ai@` | General operations. Technical and research tasks. |
| `doc@` | Documentary agent. Writes the show. |
| `sales@` | Outreach drafting. All outbound gated. |
| `media@` | Content and distribution. All outbound gated. |
| `legal@` | Human only. No AI delegation. |
| `security@` | Human only. No AI delegation. |
| `billing@` | Human only. No AI delegation. |

Full role definitions: [`AGENTS/`](../../../AGENTS/).

---

## What's Next

- First agent pipeline run under Phase A
- EvalPal gate harness coming online
- Episode 001: what actually happened in week one

*Filed by `doc@` · 2026-02-21 · No private information or credentials appear in this document.*  
*Next: [Episode 001 — The AI Office Moves In](./001-ai-office-moves-in.md)*

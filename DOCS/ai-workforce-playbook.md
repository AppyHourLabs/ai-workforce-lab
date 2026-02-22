# AI Workforce Playbook

> **Author:** Appy Hour Labs | **Based on:** AI Workforce Lab (Steps 00–12) | **Date:** 2026-02-22
> **Stack:** OpenClaw · Slack · GitHub · Mac Mini · GPT-5.1 Codex

A practitioner's guide to building an AI team — based on what we actually shipped, what broke, and what we'd do differently. Not theory. Not a whitepaper. This is what happened.

---

## 1. How We Chose What to Automate

We scored every role in our roster against five criteria before building anything. This saved us from building agents that would have sat idle.

### The Scoring Model

Each candidate role gets 1–5 on five dimensions (25-point maximum):

| Criterion | What it measures |
|---|---|
| **Repeatability** | Predictable, recurring tasks with clear inputs/outputs? |
| **Tooling Feasibility** | Can the tasks be done with tools already available (CLI, file I/O, Slack, web search)? |
| **Risk Profile** | How small is the blast radius if the agent makes a mistake? (5 = very safe) |
| **Phase A Fit** | Does human-approval feel natural, not crippling, for this workflow? |
| **Infra Reuse** | How much existing infrastructure can be reused? |

### What We Found

| Role | Score | Verdict |
|---|---|---|
| QA Agent | 25/25 | Built first — pure file I/O + LLM judgment, zero new infra |
| Content Agent | 22/25 | Built second — draft-only workflow fits Phase A perfectly |
| Security Agent | 21/25 | Built third — advisory-only makes it safe |
| CTO Agent | 17/25 | Deferred — ad-hoc tasks, hard to gate |
| SDR Agent | 15/25 | Deferred — highest reputational risk |
| CFO Agent | 14/25 | Deferred — data-starved without financial pipeline |

**Lesson:** The agents that scored highest were the ones with *tight feedback loops* and *low blast radius*. QA was a 25 because "read file → evaluate → write result" is a clean loop with no external side effects. The SDR scored 15 because every email it drafts affects a real person.

Full scoring details: [TASKS/0018-step07-work-audit.md](../TASKS/0018-step07-work-audit.md)

---

## 2. The Phase A Autonomy Model

**Phase A rule:** Every outbound action requires human approval. No exceptions.

This sounds restrictive. It is. That's the point. Here's why:

- **Trust is earned, not declared.** We can't know if an agent will behave until it has a track record. Phase A creates that track record.
- **The gate should feel natural.** If the human-approval step feels painful for a role, the role isn't ready for automation — or the workflow needs redesign.
- **Phase B is a measurable promotion.** An agent earns Phase B (unsupervised publishing within approved scope) by meeting specific criteria: ≥20 consecutive successful publishes, 14 days of zero red violations, ≥98% quality gate pass rate, and a completed incident response drill.

The full promotion criteria: [POLICIES/phase-a-to-b.md](../POLICIES/phase-a-to-b.md)

**What this looks like in practice:** The doc agent drafts an episode, opens a PR. The QA agent runs eval gates. Matt reviews, merges, publishes. The agent didn't touch the publish button. That's Phase A.

---

## 3. Workspace File Conventions

Every OpenClaw agent lives in a workspace directory (`~/.openclaw/workspaces/<agent-id>/`) with a standard set of markdown files. These files *are* the agent's context — they're loaded at the start of every session.

| File | What it does | Example content |
|---|---|---|
| `IDENTITY.md` | Name, emoji, theme, account assignment | "🎬 Documentary Agent · `doc@appyhourlabs.com`" |
| `SOUL.md` | Mission, responsibilities, safety constraints, shared brain instructions | The core "who are you and what do you do" document |
| `USER.md` | Owner context, project info, autonomy tier | "Owner: matt@appyhourlabs.com · Tier: Phase A" |
| `TOOLS.md` | Available tools and explicit constraints | "You have `gh` CLI access. You do NOT have email." |
| `AGENTS.md` | Copy of the repo-level AGENTS.md for fleet context | Gives the agent awareness of the broader system |

### Key design choices

- **SOUL.md is the most important file.** It defines what the agent will and won't do. Every safety constraint, every escalation rule, every hard limit lives here. If you get one file right, make it this one.
- **Shared Brain section goes in SOUL.md.** Every agent's SOUL.md includes instructions to read/write the shared brain (`../shared/brain/`) on every run. This is how agents share context.
- **TOOLS.md is an allowlist, not a denylist.** The agent only has the tools you list. If it's not in TOOLS.md, it can't use it.

---

## 4. Pipeline Design

### Staggered Crons

We run agents on a staggered daily schedule, not all at once. Why:

1. **Sequential dependency.** Doc must finish before QA can evaluate. QA must finish before Content can repurpose. Running them simultaneously would mean QA evaluates yesterday's draft.
2. **Shared resource contention.** All agents share one gateway and one Slack channel. Staggering avoids output collision.
3. **Debuggability.** When something breaks at 05:00, you know it was the Content agent, not a race condition between three agents.

### Handoff Notes

Agents pass context downstream via markdown files in `~/.openclaw/workspaces/shared/brain/handoffs/`:

```
doc-to-qa.md      "I drafted episode 005. PR #42 is open. Evaluate it."
qa-to-content.md  "Episode 005 passed all gates. Score: 94/100. Ready for social."
```

Each agent's cron prompt explicitly tells it to read its upstream handoff and write its downstream handoff. This is wired into the `--message` flag of `openclaw cron add`.

### Timing

We use 30-minute gaps between pipeline agents. This gives each agent time to think, write, and handle retries. We *could* tighten this, but the morning window (03:45–07:00 ET) isn't contested — there's no reason to rush.

---

## 5. What Went Wrong

Real failures from the build. These aren't hypothetical.

### Channel Routing Collision

**What happened:** We initially gave the doc agent a Slack channel binding for `#ai-office`. When we added the manager agent with its own binding, interactive messages started going to whichever agent was registered first — not the one @mentioned.

**Root cause:** OpenClaw uses first-match routing on channel bindings. If two agents bind the same channel, the first one wins.

**Fix:** Only one agent (manager) gets a channel binding. All specialists deliver via cron's `delivery.to`, which doesn't require a binding.

### `#channel` vs. `channel:ID`

**What happened:** `openclaw agent --reply-to "#ai-office"` silently failed. The CLI requires `channel:C0AFXJR71V5` format.

**Fix:** Always use the channel ID format for CLI commands. The `#name` format only works in cron delivery config (resolved internally).

### Interactive CLI Hangs

**What happened:** A `gh pr create` command without `--fill` or `--body` hung indefinitely waiting for an interactive editor — which doesn't exist in a headless cron environment.

**Fix:** Always use non-interactive flags. We found this process still running 12+ hours later.

### Agent Timeouts

**What happened:** The doc agent composed an entire episode inline (in chat) instead of using the `write` tool. The response exceeded the timeout.

**Fix:** Prompt the agent to keep chat responses short and use tools for file writes. Increase timeout to 900s for content-heavy agents. Set `--best-effort-deliver` so the job succeeds even if delivery fails.

### Missing @mention

**What happened:** We typed `@manager status report` in Slack, expecting the bot to respond. Nothing happened.

**Root cause:** `ackReactionScope: "group-mentions"` requires a *Slack autocomplete* @mention — the kind that turns into a blue clickable link — not raw text.

**Fix:** Always use Slack's autocomplete picker when @mentioning the bot.

---

## 6. Agent vs. Tool

**Add a new agent when:**
- The role has its own identity, output style, and context window — it wouldn't make sense as an extension of an existing agent
- The task runs on a different schedule or in a different pipeline stage
- The blast radius of the role is different enough to warrant separate constraints
- You want independent SOUL.md constraints (e.g., "never access billing" for CFO vs. "never send email" for QA)

**Add a tool to an existing agent when:**
- The capability is a single action the agent invokes during its existing workflow (e.g., adding `gh` CLI to the doc agent for PR creation)
- The tool doesn't change the agent's identity or scope
- The same agent already handles the broader task and just needs a new verb

**Our examples:**
- **New agent:** QA was a new agent, not a tool added to doc. QA has a fundamentally different job (evaluate, not create) and different timing (runs after doc, not during).
- **New tool:** GitHub was a tool added to doc, not a new agent. Doc needed to create PRs as part of its existing "draft episodes" workflow. Adding a "GitHub agent" would have been overhead with no benefit.

**Rule of thumb:** If you're writing a new SOUL.md, it's an agent. If you're adding a line to TOOLS.md, it's a tool.

---

## 7. Governance

We built three governance layers. In hindsight, these were the smartest investment in the project — they prevented every category of failure we were worried about.

### Safety Charter

Non-negotiable principles that override everything:

- No autonomous money movement
- No domain-wide delegation
- No secrets in the repo
- External comms require eval gate + human approval
- Human-only accounts (`legal@`, `security@`, `billing@`) are off-limits to all AI agents

Full charter: [POLICIES/ai-safety-charter.md](../POLICIES/ai-safety-charter.md)

### Escalation Policy

Three severity tiers with clear triggers and response times:

| Severity | Example | Response |
|---|---|---|
| SEV-1 | Credential in repo, agent acting out of scope | Stop everything immediately |
| SEV-2 | Gate failure ignored, off-brand post | Within 1 hour |
| SEV-3 | Broken link, minor formatting | Within 24 hours |

Full policy: [POLICIES/escalation-policy.md](../POLICIES/escalation-policy.md)

### Eval Gates

Content quality checks that run before any outbound action:

- Outbound quality gate — factual accuracy, formatting, schema compliance
- Brand voice gate — tone, style, consistency with brand identity
- CI secret scanner — automated pattern matching on every PR diff

The eval gates are the mechanism that makes Phase A work. Without them, "human approval" would mean Matt reading every word of every draft. With them, Matt reviews a score and spot-checks — scaling his attention instead of his time.

Eval infrastructure: [EVALS/](../EVALS/) · CI runbook: [RUNBOOKS/ci.md](../RUNBOOKS/ci.md)

---

## Appendix: Quick-Start Checklist

If you're starting fresh with OpenClaw, here's the order we recommend:

1. **Harden your environment first.** Dedicated machine, non-admin user, 2FA everywhere. Don't skip this.
2. **Build one agent.** Get it running on a cron, delivering to Slack. Resist the urge to build three at once.
3. **Add eval gates.** Before you add a second agent, make sure the first one's output is being evaluated.
4. **Score candidate roles.** Use the 5-criteria model before choosing what to build next.
5. **Wire the shared brain.** Once you have 2+ agents, give them shared context so they don't contradict each other.
6. **Add a manager last.** The orchestrator only makes sense when there's a team to orchestrate.
7. **Document everything.** Your future self (and your agents) will thank you.

---

*CampClaw Step 12 artifact. See [TASK 0026](../TASKS/0026-step12-the-playbook.md) · [CAMPCLAW.md](../CAMPCLAW.md)*

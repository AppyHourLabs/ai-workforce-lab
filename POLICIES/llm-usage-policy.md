# Policy — LLM Usage, Token Efficiency, and Model Selection

> **Owner:** `matt@appyhourlabs.com`  
> **Applies to:** All AI agents operating in the AI Workforce Lab (Phase A)  
> **Status:** Active  
> **Last updated:** 2026-02-21

---

## Purpose

Control API costs, avoid rate limits, and ensure agent actions are proportionate to task complexity. Every agent call costs tokens and money. This policy sets the rules for when to use which model, how to write efficient prompts, and what to do when limits are hit.

---

## Primary LLM Provider

**Google Gemini API** (via [Google AI Studio](https://aistudio.google.com/apikey))

- **Default model:** `gemini-2.0-flash` — fast, cheap, capable enough for Phase A tasks
- **Elevated model:** `gemini-1.5-pro` or `gemini-2.0-pro` — reserved for complex reasoning only (see tier table below)
- **API key:** stored securely, never committed to this repo

---

## Model Selection Tiers

| Task Type | Model | Rationale |
|---|---|---|
| Drafting, summarizing, formatting | `gemini-2.0-flash` | Low complexity; Flash handles this well at a fraction of the cost |
| Quality gate evaluation | `gemini-2.0-flash` | Structured checklist evaluation; Flash is sufficient |
| Multi-step reasoning, planning | `gemini-1.5-pro` | Reserve for tasks that genuinely need deeper reasoning |
| Security review, policy interpretation | `gemini-1.5-pro` | Higher stakes; worth the extra cost |
| Test/debug runs | `gemini-2.0-flash` | Always use Flash when testing or iterating on prompts |

**Rule:** Default to Flash. Justify explicitly in the task or prompt if upgrading to Pro.

---

## Token Efficiency Rules

All agents must follow these constraints in every interaction:

### 1. Keep system prompts concise
- System prompts are sent with every API call. Every unnecessary sentence is paid for on every request.
- Target: system prompts under 500 tokens. Review and trim if they grow beyond that.
- Reference policies by name, not by pasting their full content.

### 2. Scope tasks narrowly
- Bad: *"Write about what happened this week."*
- Good: *"Draft a 250-word summary of Tasks 0003–0006 completion for Episode 002. Use the episode template structure."*
- Narrow inputs = fewer back-and-forth correction rounds = fewer tokens total.

### 3. One task per call where possible
- Avoid chaining multiple unrelated requests into a single prompt.
- Exception: if tasks share context already loaded, batching is fine.

### 4. No re-summarizing known context
- Do not ask the model to repeat or summarize content already in the system prompt.
- If the model needs to reference a file, pass the relevant excerpt — not the whole file.

### 5. Log token usage
- Every agent run logs to `~/ai-office-logs/agents/` per the logging convention in [`RUNBOOKS/logging-conventions.md`](../RUNBOOKS/logging-conventions.md).
- Include a `tokens_used` field in the log entry when the API returns usage data.

---

## Rate Limit Protocol

If an agent hits a rate limit:

1. **Do not retry immediately.** Wait at least 60 seconds before the first retry.
2. **Exponential backoff:** retry at 60s, 120s, 240s. If still failing after 3 retries, stop and log the failure.
3. **Log the incident** to `~/ai-office-logs/incidents/` with the timestamp, agent ID, and the task that was interrupted.
4. **Notify `matt@appyhourlabs.com`** via `#ai-office` Slack if an agent cannot complete a task due to sustained rate limiting.
5. Do not silently drop tasks. A failed task must result in a log entry.

---

## Local LLM (Future — Phase B)

Running a local model via [Ollama](https://ollama.ai) on the Mac Mini is a Phase B option, not Phase A.

**When to revisit:** when multiple agents run continuously and API costs become material, or when task sensitivity requires data to stay entirely on-device.

**Candidates for local:** `llama3`, `mistral`, `gemma2` via Ollama.  
**Not suitable locally (Phase A hardware):** tasks requiring 70B+ models.

Until Phase B is declared, all agents use the Gemini API.

---

## What This Policy Does Not Cover

- OAuth token scopes and credential storage → [`POLICIES/oauth-policy.md`](oauth-policy.md)
- What agents are allowed to publish externally → [`POLICIES/posting-policy.md`](posting-policy.md)
- Agent safety boundaries → [`POLICIES/ai-safety-charter.md`](ai-safety-charter.md)

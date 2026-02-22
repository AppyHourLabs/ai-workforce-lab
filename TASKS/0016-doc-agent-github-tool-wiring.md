# Task 0016 — Wire Doc Agent to GitHub (CampClaw Step 05)

> **Project:** AI Workforce Lab — Agent Operations  
> **Owner:** Human (`matt@appyhourlabs.com`) setup; AI (`doc@appyhourlabs.com`) operation  
> **Priority:** P1  
> **Status:** ✅ Done  
> **CampClaw Step:** 05 — The Wiring  
> **Depends on:** Task 0014 (Doc Agent configured and producing gated content)

---

## Goal

Give the Documentary Agent its first external tool capability: **GitHub** via OpenClaw's bundled `github` skill and the `gh` CLI. This lets the agent create branches, commit episode drafts, and open PRs — closing the loop on its existing draft-to-review pipeline.

---

## Why GitHub First

- **Already ready.** `gh` CLI installed and authenticated (`MatthewEngman`, `repo` + `workflow` scopes). Zero new credentials needed.
- **Policy-aligned.** [OAuth policy](../POLICIES/oauth-policy.md) grants `doc@appyhourlabs.com` the scope "GitHub (PR open)."
- **Immediately useful.** Episode 002 (PR #8) was created manually. The agent should do this itself going forward.
- **Lowest risk.** PRs require human merge — the agent cannot publish autonomously.

---

## Steps

### 1 — Update Agent System Prompt (SOUL.md)

Add a `## GitHub Tool` section to the doc agent's SOUL.md at `~/.openclaw/workspaces/doc/SOUL.md` with:

- Instructions for creating `doc/` branches, committing drafts, and opening PRs
- Scope constraints: only `AppyHourLabs/ai-workforce-lab`, only `DOCS/SHOW/episodes/`
- Reviewer requirement: always request review from `MatthewEngman`

### 2 — Update Agent Environment Notes (TOOLS.md)

Add GitHub-specific environment config to `~/.openclaw/workspaces/doc/TOOLS.md`:

- Repo target, branch naming convention, reviewer
- Reference to the `gh` CLI

### 3 — Verify Skill Availability

Confirm the `github` skill is accessible to the `doc` agent via `openclaw skills check`.

### 4 — Test: List PRs

Send a message in `#ai-office` asking the doc agent to list recent PRs. Confirm it responds with accurate PR data.

### 5 — Test: Open a PR

Ask the doc agent to create a test branch, add a dummy file, and open a PR. Verify the PR appears on GitHub. Close without merging.

### 6 — Update CAMPCLAW.md

Mark Step 05 as complete with the task link.

---

## Dependencies

- Task 0014 ✅ — Doc Agent configured
- `gh` CLI ✅ — authenticated as `MatthewEngman` with `repo` scope
- OpenClaw `github` skill ✅ — bundled and ready

---

## Definition of Done

- [x] `SOUL.md` updated with GitHub tool instructions and constraints
- [x] `TOOLS.md` updated with environment-specific GitHub config
- [x] Routing binding added to `openclaw.json` (channel C0AFXJR71V5 → doc agent)
- [x] Slack Event Subscriptions enabled (was off — `app_mention` + `message.channels` added)
- [x] Agent responds in `#ai-office` when prompted (2026-02-21)
- [x] `CAMPCLAW.md` updated to reflect Step 05 completion

---

## Risk Notes

- **Agent cannot merge its own PRs.** The posting policy requires `matt@appyhourlabs.com` approval. The `gh` CLI token has `repo` scope (which includes merge), but the agent's SOUL.md explicitly prohibits self-merging.
- **Branch prefix `doc/` enforced by convention** — the system prompt constrains the agent to `doc/*` branches only.
- **File scope limited to `DOCS/SHOW/episodes/`** — the system prompt forbids modifying files outside this path via the GitHub tool.

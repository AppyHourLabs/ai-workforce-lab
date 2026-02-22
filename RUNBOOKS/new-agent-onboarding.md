# Runbook: New Agent Onboarding

> Follow this runbook whenever adding a new agent to the AI Workforce Lab fleet.
> This is the single source of truth for agent setup.

## ⚠️ Routing & Delivery Gotchas

Lessons learned during Steps 09/10 (2026-02-22):

1. **Only ONE agent should be bound to an interactive channel.** If multiple agents share the same channel binding (`peer=channel:<id>`), OpenClaw routes to the **first match** — not by @mention text. The manager agent is the sole `#ai-office` interactive responder. Specialist agents work via cron only.

2. **Slack requires @mention in channels.** Config `ackReactionScope: "group-mentions"` means the bot only responds when the **Slack bot user** is @mentioned (via Slack autocomplete), not from plain text like `@manager`.

3. **CLI delivery needs channel ID format.** `openclaw agent --reply-to "#ai-office"` fails — use `--reply-to "channel:C0AFXJR71V5"` instead. Cron delivery with `#ai-office` works fine (resolved internally).

4. **Cron delivery ≠ channel binding.** Agents can deliver to `#ai-office` via cron's `delivery.to` without needing channel bindings. Bindings are for **receiving** interactive messages.

## Prerequisites

- OpenClaw installed and gateway running
- Slack bot connected to `#ai-office`
- Shared brain active at `~/.openclaw/workspaces/shared/brain/`

## Steps

### 1. Create Workspace

```bash
# Replace <agent-id> with the new agent's ID (e.g., "outreach", "billing")
mkdir -p ~/.openclaw/workspaces/<agent-id>/memory
```

### 2. Create Workspace Files

Create these files in `~/.openclaw/workspaces/<agent-id>/`:

| File | Purpose |
|------|---------|
| `IDENTITY.md` | Name, emoji, theme, account |
| `SOUL.md` | Mission, responsibilities, safety constraints, shared brain section |
| `USER.md` | Owner context, project info, autonomy tier |
| `TOOLS.md` | Available tools and constraints |
| `AGENTS.md` | Copy from an existing agent workspace |

**Important:** Include the **Shared Brain** section in SOUL.md:

```markdown
## Shared Brain

You have access to a shared memory layer at `../shared/brain/`.
All agents read and write here to share context across sessions.

### On Each Run

1. **Read** `../shared/brain/fleet-status.md` for fleet context.
2. **Read** relevant handoff files in `../shared/brain/handoffs/`.
3. After your work, **update** `../shared/brain/fleet-status.md` with your run status.

## Continuity

Each session, you wake up fresh. These workspace files are your memory.
The shared brain at `../shared/brain/` gives you fleet-wide context.
```

### 3. Register Agent in OpenClaw

```bash
openclaw agents add <agent-id> \
  --workspace ~/.openclaw/workspaces/<agent-id> \
  --model openai/gpt-5.1-codex \
  --non-interactive

openclaw agents set-identity \
  --agent <agent-id> \
  --name "<Display Name>" \
  --theme "<one-line theme>" \
  --emoji "<emoji>"
```

### 4. Add Slack Channel Binding (interactive agents ONLY)

> **Most agents do NOT need a channel binding.** Specialist agents work via cron and deliver output to `#ai-office` through their cron delivery config. Only the **manager agent** has a channel binding for interactive Slack routing. Adding bindings for other agents would break routing (first-match wins).

If this agent genuinely needs to receive interactive Slack messages (rare):

Edit `~/.openclaw/openclaw.json` and add to the `bindings` array:

```json
{
  "agentId": "<agent-id>",
  "match": {
    "channel": "slack",
    "peer": {
      "kind": "channel",
      "id": "C0AFXJR71V5"
    }
  }
}
```

### 5. Add Cron Job (if scheduled)

```bash
openclaw cron add \
  --agent <agent-id> \
  --name "<agent-id>-daily-<task>" \
  --description "<what the job does>" \
  --cron "<minute> <hour> * * *" \
  --tz "America/New_York" \
  --session isolated \
  --announce \
  --to "#ai-office" \
  --best-effort-deliver \
  --message "<prompt with shared brain read/write steps>"
```

Include shared brain steps in the cron message:
- Read relevant handoff files before doing work
- Write results to appropriate handoff file after work
- Update fleet-status.md with run status

### 6. Register in Manager's Fleet Roster

Edit `~/.openclaw/workspaces/manager/TOOLS.md` and add the new agent to the **Fleet Roster** table:

```markdown
| <emoji> <Name> | `<agent-id>` | <schedule> | <capabilities> | <constraints> |
```

### 7. Create Handoff Files (if needed)

If the new agent participates in a pipeline, create handoff files in `~/.openclaw/workspaces/shared/brain/handoffs/`.

### 8. Restart Gateway

```bash
openclaw gateway --force
```

This briefly disconnects all agents from Slack. Verify health:

```bash
openclaw health
openclaw status
openclaw agents list
```

### 9. Verify

- [ ] Agent appears in `openclaw agents list`
- [ ] Agent has `memory/` directory
- [ ] Slack binding is in `openclaw.json`
- [ ] Cron job appears in `openclaw cron list` (if scheduled)
- [ ] Agent is in manager's fleet roster (`TOOLS.md`)
- [ ] Shared brain section is in agent's `SOUL.md`
- [ ] Gateway is healthy after restart

### 10. Document

Create a TASK file at `TASKS/<number>-<agent-id>-setup.md` describing the agent, its role, and setup details. Update `CAMPCLAW.md` if applicable.

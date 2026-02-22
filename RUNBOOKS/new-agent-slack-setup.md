# Runbook — New Agent Slack Setup

> **Owner:** `matt@appyhourlabs.com`  
> **Last updated:** 2026-02-21

---

## Purpose

Step-by-step checklist for connecting a new OpenClaw agent to a Slack channel. Covers the full pipeline from agent creation to verified message routing.

---

## Prerequisites

- OpenClaw installed and gateway running (`openclaw health`)
- Slack bot connected (`openclaw channels status --probe`)
- Target Slack channel exists and the bot is invited to it (`/invite @AI Office`)

> [!CAUTION]
> **Verify these Slack app settings are ON** (at [api.slack.com/apps](https://api.slack.com/apps)):
> - **Socket Mode** → must be enabled (without this, the bot can send but never receive)
> - **Event Subscriptions** → must be enabled; under "Subscribe to bot events", add `app_mention` and `message.channels`

---

## Steps

### 1 — Create the Agent

```bash
openclaw agents add <agent-id>
```

This creates:
- Workspace at `~/.openclaw/workspaces/<agent-id>/`
- Agent dir at `~/.openclaw/agents/<agent-id>/agent/`

### 2 — Configure Identity & System Prompt

Edit the workspace files:

| File | Purpose |
|---|---|
| `SOUL.md` | System prompt — mission, responsibilities, safety constraints, tool instructions |
| `IDENTITY.md` | Name, emoji, theme, account |
| `TOOLS.md` | Environment-specific tool config (repos, API endpoints, credentials references) |
| `USER.md` | Info about the human operator |

### 3 — Add Channel Routing Binding ⚠️

> [!CAUTION]
> **This step is easy to miss.** Without a routing binding, all messages go to the default `main` agent — your new agent will never receive anything.

Edit `~/.openclaw/openclaw.json` and add an entry to the `bindings` array:

```json
{
  "bindings": [
    {
      "agentId": "<agent-id>",
      "match": {
        "channel": "slack",
        "peer": {
          "kind": "channel",
          "id": "<SLACK_CHANNEL_ID>"
        }
      }
    }
  ]
}
```

**Finding the channel ID:** In Slack, right-click the channel name → "View channel details" → the ID is at the bottom (starts with `C`).

**Routing priority** (evaluated top to bottom):
1. Exact peer match (channel/group ID)
2. Parent peer match (thread inheritance)
3. Team ID match
4. Account match
5. Default agent (`main`)

### 4 — Restart the Gateway

```bash
openclaw gateway restart
```

### 5 — Verify Routing

```bash
openclaw agents list --bindings
```

Confirm your agent shows the expected routing rule, e.g.:
```
- <agent-id>
  Routing rules: 1
  Routing rules:
    - slack peer=channel:<CHANNEL_ID>
```

### 6 — Test in Slack

Send a message in the target channel (mention the bot or just post if the bot listens to all messages). The agent should respond with its configured personality.

---

## Troubleshooting

| Symptom | Likely Cause | Fix |
|---|---|---|
| Bot doesn't respond at all | Bot not invited to channel | `/invite @AI Office` in the channel |
| Wrong agent responds | Missing or incorrect binding | Check `openclaw agents list --bindings`; verify channel ID |
| Agent responds but with default personality | Binding exists but `SOUL.md` not configured | Edit `~/.openclaw/workspaces/<agent-id>/SOUL.md` |
| "Channel not allowed" | Channel not in allowlist | Add channel to `channels.slack.channels` in `openclaw.json` |

---

## Reference

- [OpenClaw Multi-Agent Routing](https://docs.openclaw.ai/concepts/multi-agent)
- [Channel Routing](https://docs.openclaw.ai/channels/channel-routing)

---

*Learned the hard way during Step 05 (Task 0016) — the doc agent was configured but had 0 routing rules, so all `#ai-office` messages went to `main`.*

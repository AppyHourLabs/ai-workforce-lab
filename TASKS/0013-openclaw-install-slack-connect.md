# Task 0013 — Install OpenClaw and Connect to Slack

> **Project:** [0002 — Mac Mini AI Office Setup](../PROJECTS/0002-mac-mini-ai-office-setup.md)  
> **Owner:** Human (`matt@appyhourlabs.com`)  
> **Priority:** P0  
> **Status:** Open  
> **CampClaw Step:** 03 — The Mac Mini (final step)

---

## Goal

Install OpenClaw on the Mac Mini under the `aioffice` user and connect it to the `#ai-office` Slack channel in the Appy Hour Labs workspace. This completes CampClaw Step 03.

---

## Pre-flight Checklist

Before starting, confirm:
- [ ] Logged in as `aioffice` macOS user
- [ ] `#ai-office` Slack channel created in Appy Hour Labs workspace
- [ ] Internet access confirmed

---

## Steps

### 1 — Upgrade Node to 22+

OpenClaw requires Node 22 or newer (we installed Node 20).

> ⚠️ Do this as **admin**, then switch back to `aioffice`.

```bash
brew install node@22
brew link node@22 --force --overwrite
node --version   # must say v22.x.x
```

---

### 2 — Install OpenClaw (as `aioffice`)

```bash
curl -fsSL https://openclaw.ai/install.sh | bash
```

Verify:
```bash
openclaw --version
```

---

### 3 — Run the Onboarding Wizard

```bash
openclaw onboard --install-daemon
```

This will:
- Configure auth (API key for your LLM — Anthropic or OpenAI)
- Install the background daemon
- Ask which channel to connect

---

### 4 — Create the Slack App

> Do this in a browser (can use phone or switch to admin account)

1. Go to [api.slack.com/apps](https://api.slack.com/apps)
2. Click **Create New App → From scratch**
3. Name: `AI Office` | Workspace: `Appy Hour Labs`
4. Under **OAuth & Permissions**, add these Bot Token Scopes:
   - `chat:write`
   - `channels:read`
   - `channels:history`
   - `app_mentions:read`
5. Click **Install to Workspace** → authorize
6. Copy the **Bot User OAuth Token** (`xoxb-...`)
7. Under **Basic Information**, copy the **Signing Secret**
8. Under **Event Subscriptions**, enable events — add `app_mention` and `message.channels`

---

### 5 — Connect OpenClaw to Slack

When the onboarding wizard prompts for a channel, select **Slack** and enter:
- Bot token: `xoxb-...`
- Signing secret: (from step 4)
- Target channel: `#ai-office`

Or configure manually:
```bash
openclaw channels add slack
```

---

### 6 — Verify

```bash
openclaw gateway status
```

Send a test message to confirm the connection:
```bash
openclaw message send --target "#ai-office" --message "OpenClaw is online. AI Office ready."
```

Check `#ai-office` in Slack — the message should appear.

---

## Owner (Human vs AI)

**Human only.** Requires physical presence at Mac Mini and Slack app creation.

---

## Dependencies

- Task 0003 ✅ — `aioffice` user exists
- Task 0004 ✅ — Homebrew, Node installed (Node 22 upgrade needed)
- Task 0005 ✅ — Chrome profiles set up (useful for Slack App creation)
- `#ai-office` Slack channel created ✅

---

## Definition of Done

- [x] Node 22+ confirmed (`node --version`)
- [ ] OpenClaw installed (`openclaw --version`)
- [ ] Onboarding wizard completed; daemon running
- [x] Slack App created with correct scopes
- [ ] OpenClaw connected to `#ai-office` channel
- [ ] Test message successfully received in `#ai-office`
- [ ] `openclaw gateway status` shows healthy

---

## Risk Notes

- **LLM API key required.** You'll need an Anthropic or OpenAI API key during onboarding. Have it ready — do not store it in this repo.
- **Slack app needs to be invited to `#ai-office`:** After creating the bot, run `/invite @AI Office` in the channel.
- **Node 22 upgrade:** `brew link --overwrite` is safe but confirm `node --version` returns 22.x before proceeding.

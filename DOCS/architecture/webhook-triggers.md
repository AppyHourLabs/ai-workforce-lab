# Webhook Triggers Architecture

## Overview

To improve latency and reduce token waste, the AI Workforce Lab utilizes event-driven webhook triggers to wake agents and hand off tasks. This replaces the legacy staggered cron system for workflows that depend on external state changes (like GitHub Pull Requests).

## Core Components

1. **GitHub Repository (Event Source)**
   - Configured with native Webhooks (or GitHub Actions workflows) that watch for specific events (e.g., `pull_request` opened/synchronized, `issues` labeled).
   - Posts a JSON payload containing the event context to the Gateway Ingress.

2. **Gateway Ingress (Tunnel)**
   - Because the OpenClaw Gateway runs on a local Mac Mini, it is not directly addressable from the public internet.
   - We utilize a secure tunnel (e.g., Tailscale Funnel or a dedicated ngrok container) to expose the webhook endpoint securely.

3. **OpenClaw Hooks Router**
   - The Gateway has the HTTP hooks subsystem enabled (`hooks.enabled = true`).
   - Requests arriving at `POST /hooks/agent` include an `Authorization` header to authenticate the payload.
   - OpenClaw parses the payload, identifies the `agentId` (e.g., `qa`, `content`), and injects the `message` to initiate an isolated agent run.

## Migrating an Agent to Webhooks

To migrate an agent from cron to an event-driven webhook:

1. **Configure OpenClaw Gateway:**
   Ensure the gateway is configured to accept webhooks in `~/.openclaw/config.json`:
   ```json
   {
     "hooks": {
       "enabled": true,
       "token": "YOUR_SECURE_TOKEN",
       "path": "/hooks",
       "allowedAgentIds": ["qa", "doc", "content"]
     }
   }
   ```

2. **Expose the Endpoint:**
   Use a reverse proxy or tunnel to expose `http://127.0.0.1:18789/hooks/agent` to a public URL (e.g., `https://webhooks.appyhourlabs.com/hooks/agent`).

3. **Set Up the Event Emitter (GitHub Action Example):**
   Create a workflow in the target repository to send the webhook when work is ready for the agent.

   ```yaml
   name: Trigger QA Agent
   on:
     pull_request:
       types: [opened, synchronize, ready_for_review]

   jobs:
     notify_agent:
       runs-on: ubuntu-latest
       steps:
         - name: Send Webhook to OpenClaw
           run: |
             curl -X POST https://webhooks.appyhourlabs.com/hooks/agent \
               -H "x-openclaw-token: ${{ secrets.OPENCLAW_WEBHOOK_TOKEN }}" \
               -H "Content-Type: application/json" \
               -d '{
                 "agentId": "qa",
                 "name": "GitHub PR Trigger",
                 "message": "PR #${{ github.event.pull_request.number }} requires QA review. Please read the diff and provide feedback.",
                 "wakeMode": "now",
                 "deliver": true,
                 "channel": "slack",
                 "to": "C0AFXJR71V5"
               }'
   ```

4. **Disable the Legacy Cron:**
   Remove or suspend the agent's time-based cron job via `openclaw cron remove <job-id>`.

## Security Considerations

- **Authentication:** All incoming requests MUST include the configured `hooks.token` (via `x-openclaw-token` or `Authorization: Bearer`).
- **Network Isolation:** Only expose the exact `/hooks` path to the internet. Do not expose the OpenClaw UI or standard API ports.
- **Idempotency:** Agents should be prompted to verify if they have already reviewed a specific commit hash or state to prevent infinite loops or duplicate outputs.

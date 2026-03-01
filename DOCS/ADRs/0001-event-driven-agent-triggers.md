# ADR 0001: Event-Driven Agent Triggers via Webhooks

## Status
Accepted

## Context
Currently, the AI agent fleet is orchestrated using time-based cron scheduling. For example, the QA agent wakes up an hour after the Doc agent, and the Manager agent runs at the very end of the sequence. While this simple staggered timeline was acceptable for bootstrapping the fleet, it causes several operational issues:
1. **Race Conditions & Edit Conflicts:** If an upstream agent takes longer than its allotted window, a downstream agent might wake up and attempt to modify shared state or review incomplete pull requests, leading to conflicts.
2. **Wasted Token Spend:** Agents wake up on schedule even if there is no new work (e.g., no PRs were opened), wasting API tokens and computing time to simply report "no action needed."
3. **High Latency:** Time-based handoffs artificially delay the pipeline. An agent might finish a task in 2 minutes, but the downstream review agent won't trigger until its scheduled slot 45 minutes later.

## Decision
We will replace the staggered time-based cron orchestration with **event-driven triggers** using OpenClaw's HTTP Webhook Gateway capability. 

Instead of waiting for a scheduled cron:
1. Upstream events (e.g., a PR opened by the Dev agent, a review merged by the QA agent) will emit a webhook.
2. The OpenClaw Gateway will receive these webhooks via its `/hooks/agent` endpoint.
3. The Gateway will instantaneously dispatch a task to the downstream agent.

### Architecture
- **Ingress:** OpenClaw will have `hooks.enabled = true` in its configuration. A secure tunnel (e.g., Tailscale Funnel or ngrok) will expose a public endpoint specifically for GitHub Webhooks.
- **Routing:** A GitHub Action (or native repository webhook) will fire on relevant events (like `pull_request` actions) and `POST` to the OpenClaw webhook endpoint.
- **Payload:** The webhook payload will specify the target `agentId` and the context (`message`) so the agent has immediate access to the event details.

## Consequences
- **Positive:** Reduced latency between agent handoffs, resulting in a faster, more responsive AI workforce.
- **Positive:** Lower API token waste since agents only wake up when work is strictly required.
- **Negative:** Increased networking complexity (requires securely exposing the webhook ingress to the internet or GitHub Actions).
- **Negative:** We must implement idempotency/replay protection if webhooks are delivered multiple times.

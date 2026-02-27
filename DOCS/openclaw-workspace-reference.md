# OpenClaw Agent Workspace & Config Reference

## Workspace Structure
- **SOUL.md:** The agent's core identity, mission, and operational constraints. Must be read on boot.
- **USER.md:** Context about the human operator (e.g., Matt, timezone, preferences).
- **TOOLS.md:** Environment-specific configuration for tools (GitHub repo targets, Slack channels).
- **MEMORY.md:** Long-term curated memory for the agent.
- **memory/YYYY-MM-DD.md:** Daily raw session logs.

## Shared Brain Protocol
Located at `~/.openclaw/workspaces/shared/brain/`.
- **fleet-status.md:** Single source of truth for all agent activity and current CI/CD status.
- **handoffs/**: Inter-agent handoff files (e.g., `doc-to-qa.md`, `dev-to-qa.md`). Agents MUST read from and write to these files to pass baton states.

## Cron Scheduling
Agents can run via OpenClaw cron scheduling for periodic tasks.
- Cron logs execute strictly; agents must follow a predefined script and append results to `fleet-status.md`.
- No interactive sessions allowed.

## Onboarding Checklist
1. Create `SOUL.md` with archetype and boundaries.
2. Link `TOOLS.md` with necessary API keys or CLI targets.
3. Configure `cron` entry in OpenClaw gateway if headless running is required.
4. Add agent's handoff file to `shared/brain/handoffs/`.

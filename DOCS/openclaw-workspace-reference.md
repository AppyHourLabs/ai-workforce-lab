# OpenClaw Agent Workspace & Config Reference

## Workspace Structure
- **SOUL.md:** The agent's core identity, mission, and operational constraints. Must be read on boot.
- **USER.md:** Context about the human operator (e.g., Matt, timezone, preferences).
- **TOOLS.md:** Environment-specific configuration for tools (GitHub repo targets, Slack channels).
- **MEMORY.md:** Long-term curated memory for the agent.
- **memory/YYYY-MM-DD.md:** Daily raw session logs.

## Shared Brain Protocol
Located at `/Users/aioffice/.openclaw/workspaces/shared/brain/`.
- **fleet-status.md:** Single source of truth for all agent activity and current CI/CD status.
- **handoffs/**: Inter-agent handoff files (e.g., `doc-to-qa.md`, `dev-to-qa.md`). Agents MUST read from and write to these files to pass baton states.

> ⚠️ **Write constraint:** The `write` tool cannot write to shared brain paths — they fall outside each agent's workspace sandbox. **Always use `exec`** with a shell or python3 command for all writes to `fleet-status.md` and `handoffs/`. The `write` tool is fine for files inside the agent's own workspace. See `RUNBOOKS/cron-troubleshooting.md` for the full fix pattern.

## Cron Scheduling
Agents can run via OpenClaw cron scheduling for periodic tasks.
- Cron logs execute strictly; agents must follow a predefined script and append results to `fleet-status.md`.
- No interactive sessions allowed.
- All paths in cron payloads must be **absolute** (e.g., `/Users/aioffice/...`) — never tilde-based (`~/...`).

## Onboarding Checklist
1. Create `SOUL.md` with archetype and boundaries.
2. Link `TOOLS.md` with necessary API keys or CLI targets.
3. Configure `cron` entry in OpenClaw gateway if headless running is required.
4. Add agent's handoff file to `shared/brain/handoffs/`.
5. Include `IMPORTANT — SHARED BRAIN WRITES` block in the cron payload (see `RUNBOOKS/cron-troubleshooting.md`).

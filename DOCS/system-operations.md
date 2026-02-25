# System Operations — AI Workforce Lab

> **Owner:** `matt@appyhourlabs.com` | **Last updated:** 2026-02-25
> **Autonomy tier:** Phase A — all outbound requires human approval

Complete operational reference for the AI Workforce Lab fleet. For step-by-step procedures, see the linked runbooks — this document is the map, not the territory.

---

## Fleet Roster

| # | Agent | ID | Account | Schedule (ET) | Capabilities | Constraints |
|---|---|---|---|---|---|---|
| 1 | 🎨 Product | `product` | `ai@appyhourlabs.com` | 03:45 daily | Product strategy, backlog refinement, sprint planning, branding | Advisory — no external announcements without approval |
| 2 | 🔧 CTO | `cto` | `ai@appyhourlabs.com` | 04:15 daily | Architecture decisions, technical roadmap, CI/CD oversight | Does not merge, deploy, or provision infrastructure |
| 3 | 💰 CFO | `cfo` | `ai@appyhourlabs.com` | 04:45 daily | Budget modeling, cost tracking, grant research | Zero financial authority — advisory only; no access to `billing@` |
| 4 | 💻 Dev | `dev` | `ai@appyhourlabs.com` | 05:15 daily | Full-stack coding, testing, bug fixes, feature PRs | No deploys — PRs only, branch prefix `dev/` |
| 5 | 📞 SDR | `sdr` | `sales@appyhourlabs.com` | 05:45 daily | Prospect research, outreach drafting, pipeline tracking | No autonomous email sends; all outbound human-gated |
| 6 | 🛡️ Security | `security` | `ai@appyhourlabs.com` | 06:15 daily | PR diff scanning, policy compliance checks, guardrail enforcement | Advisory — flags violations, does not block merges |
| 7 | ✍️ Content | `content` | `media@appyhourlabs.com` | 06:45 daily | Social/blog drafts from merged episodes | Draft-only; human publishes to all platforms |
| 8 | 🔍 QA | `qa` | `ai@appyhourlabs.com` | 07:15 daily | Quality gates, brand voice evaluation, pass/fail scoring | Advisory — does not merge or publish |
| 9 | 🎬 Documentary | `doc` | `doc@appyhourlabs.com` | 07:45 daily | Repo scanning, episode drafting, PR creation via `gh` CLI | Publish-gated: episodes require outbound quality gate pass |
| 10 | 🎯 Manager | `manager` | `ai@appyhourlabs.com` | 08:15 daily | Fleet briefings, task delegation via `openclaw agent --agent <id>`, interactive Slack routing | Only agent with `#ai-office` channel binding; does not execute specialist work |

**Total fleet:** 10 agents · **Pipeline window:** 03:45–08:15 ET · **All agents:** Phase A

---

## Morning Pipeline

The fleet runs on staggered daily crons. Each agent completes its work and writes a handoff note before the next agent starts.

```
03:45  🎨 Product     Backlog refinement, sprint planning, product direction
        │
04:15  🔧 CTO         Architecture review and technical planning
        │
04:45  💰 CFO         Financial analysis and cost tracking
        │
05:15  💻 Dev         Pull latest, run tests, code and open PRs
        │
05:45  📞 SDR         Prospect research and outreach drafting
        │
06:15  🛡️ Security   Scans open PRs → writes findings to EVALS/results/security/
        │
06:45  ✍️ Content     Reads QA handoff → drafts social/blog posts
        │
07:15  🔍 QA          Reads doc handoff → runs eval gates → writes handoffs/qa-to-content.md
        │
07:45  🎬 Doc         Repo scan → episode drafts → writes handoffs/doc-to-qa.md
        │
08:15  🎯 Manager     Reads ALL agent output → posts unified fleet briefing
        ┊
        ┊  (gap — Matt clears blockers as needed)
        ┊
14:00  🎯 Manager     Afternoon sweep — re-triggers failed/blocked agents if fixes landed
        ┊
        ┊  (gap — Matt works day job, clears remaining items)
        ┊
17:00  ✍️ Content     Pre-publish check — ensures all approved episodes have social drafts
        │
17:30  🎯 Manager     Ready-to-publish summary — tags Matt with what's ready to post
```

**Data flow:** Product → CTO → CFO sets strategy. Dev and SDR execute. Security → Content → QA review. Doc captures the day's activity. Manager summarizes everything last. Afternoon sweep catches blocked agents. Evening pre-publish ensures content is ready for Matt's 6-7 PM posting window.

**All output** is delivered to `#ai-office` (channel ID `C0AFXJR71V5`) via each agent's cron `delivery.to` config.

---

## Ad-Hoc Re-runs

When you clear a blocker between scheduled runs, use `scripts/rerun.sh` to re-trigger agents immediately:

```bash
# Re-run a single agent + all downstream in pipeline order
scripts/rerun.sh dev

# Re-run just one agent, no cascade
scripts/rerun.sh qa --only

# Re-run entire pipeline
scripts/rerun.sh all

# Re-run only agents whose last run errored
scripts/rerun.sh --failed
```

The afternoon manager sweep at **14:00 ET** also catches failed/blocked agents automatically. If the manager finds agents that errored and the blocker looks resolved, it re-triggers them via delegation.

---

## Shared Brain Architecture

All agents share a persistent memory layer for cross-session context.

```
~/.openclaw/workspaces/shared/brain/
├── BRAIN.md              # Shared knowledge base
├── fleet-status.md       # Updated by each agent after its run
└── handoffs/
    ├── doc-to-qa.md      # Doc agent's output for QA to evaluate
    ├── qa-to-content.md  # QA results for content agent
    └── ...               # Additional handoff files as needed
```

### How It Works

- **Config:** Each agent's `memorySearch.extraPaths` in `openclaw.json` includes `~/.openclaw/workspaces/shared/brain/`
- **Read on start:** Every cron job prompt instructs the agent to read `fleet-status.md` and relevant `handoffs/` files before doing work
- **Write on finish:** Every agent updates `fleet-status.md` with its run status and writes handoff files for downstream agents
- **Per-agent memory:** Each agent also has a local `memory/` directory in its workspace for private context
- **Standup schema:** `fleet-status.md` follows the structured block format defined in [RUNBOOKS/standup.md](../RUNBOOKS/standup.md)

See [RUNBOOKS/session-handoff.md](../RUNBOOKS/session-handoff.md) for the handoff record format.

---

## Multi-Provider Auth

Agents use different model providers (OpenAI, Anthropic, Google). API keys are stored in:

```
~/.openclaw/agents/main/agent/auth-profiles.json
```

All agents fall back to this file. The format is:

```json
{
  "profiles": {
    "<provider>:manual": {
      "provider": "<provider>",
      "type": "api_key",
      "key": "<api-key>"
    }
  }
}
```

| Provider | Agents | Env Var |
|----------|--------|---------|
| `openai` | Product, CTO, CFO, Dev | `OPENAI_API_KEY` |
| `anthropic` | Doc, Content, SDR | `ANTHROPIC_API_KEY` |
| `google` | QA, Security, Manager | `GOOGLE_API_KEY` |

> ⚠️ **Shell env vars are NOT sufficient.** The gateway LaunchAgent does not inherit shell environment variables. Keys **must** be persisted to `auth-profiles.json`. See [2026-02-23 RCA](../DOCS/incidents/2026-02-23-gateway-auth-outage-rca.md).

To verify: `openclaw models status` — check that all providers show `effective=profiles:...`.

---

## Monitoring

### Gateway Watchdog

A cron job runs every 10 minutes to check gateway health and auto-restart if needed:

- **Script:** `~/.openclaw/scripts/watchdog.sh`
- **Schedule:** `*/10 * * * *`
- **Log:** `/tmp/openclaw/watchdog.log`
- **Behavior:** Runs `openclaw health --timeout 10000`; if unhealthy, runs `openclaw gateway --force` and verifies recovery

### Health Checks

```bash
# Gateway status
openclaw gateway status

# Full system health
openclaw health

# Agent registry
openclaw agents list

# Cron job status and history
openclaw cron list
openclaw cron runs <job-id>
```

### Key Log Paths

| Path | Contents |
|---|---|
| `~/.openclaw/logs/gateway.log` | Gateway lifecycle events |
| `~/.openclaw/logs/gateway.err.log` | Errors and warnings |
| `/tmp/openclaw/openclaw-<date>.log` | Full verbose daily log |
| `~/.openclaw/cron/jobs.json` | All cron job definitions |
| `~/.openclaw/cron/runs/<job-id>.jsonl` | Run history per job |
| `/tmp/openclaw/watchdog.log` | Watchdog restart events |

---

## Incident Response

RCA documents are filed in `DOCS/incidents/` with action items tracked to completion. See [RUNBOOKS/incident-response.md](../RUNBOOKS/incident-response.md) for the full process.

### Gateway Goes Down

**Symptoms:** Agents stop responding in Slack; watchdog log shows repeated restart attempts.

1. Check if the watchdog already restarted it: `tail -5 /tmp/openclaw/watchdog.log`
2. If not, restart manually: `openclaw gateway --force`
3. Verify: `openclaw health --timeout 10000`
4. If still failing, check for port conflicts or stale processes: `ps aux | grep openclaw`
5. As a last resort, kill all OpenClaw processes and restart: `pkill -f openclaw && openclaw gateway --force`

> **Impact:** All agents lose Slack connectivity. Cron jobs that fire during downtime will fail delivery (but succeed execution if `--best-effort-deliver` is set).

### Cron Job Fails

**Symptoms:** Agent output missing from `#ai-office` at expected time.

1. Check job status: `openclaw cron list`
2. Check run history: `openclaw cron runs <job-id>`
3. Look for common failures in [RUNBOOKS/cron-troubleshooting.md](../RUNBOOKS/cron-troubleshooting.md):
   - Missing `delivery.to` field
   - Device pairing required (`gateway closed 1008`)
   - Execution timeout (agent composing too much inline)
4. Trigger manually to test: `openclaw cron run <job-id>`

### Auth Failure (Provider Missing Keys)

**Symptoms:** Some agents fail with `FailoverError: No API key found for provider`, while agents on other providers work fine.

1. Check provider auth: `openclaw models status`
2. If a provider shows `missing`, add the key to `~/.openclaw/agents/main/agent/auth-profiles.json`
3. See [RUNBOOKS/cron-troubleshooting.md](../RUNBOOKS/cron-troubleshooting.md#failovererror-no-api-key-found-for-provider) for the fix
4. Re-trigger failed agents: `openclaw cron run <job-id>`

### Agent Errors

**Symptoms:** Agent runs but produces unexpected/empty output.

1. Find the session: `tail -1 ~/.openclaw/cron/runs/<job-id>.jsonl` → get session ID
2. Read the session log: `cat ~/.openclaw/agents/<agent-id>/sessions/<session-id>.jsonl`
3. Check for: prompt issues, tool failures, model timeouts
4. If the agent acted out of scope → **SEV-1 escalation** per [POLICIES/escalation-policy.md](../POLICIES/escalation-policy.md)

### Hung Terminal Processes

Interactive CLI commands (e.g., `gh pr create` without `--fill`) will hang indefinitely.

```bash
# Find and kill
ps aux | grep "gh pr" | grep -v grep
kill <pid>
```

**Prevention:** Always use non-interactive flags. See [RUNBOOKS/cron-troubleshooting.md](../RUNBOOKS/cron-troubleshooting.md#hung-terminal-sessions).

---

## Routing Rules

| Rule | Detail |
|---|---|
| **Manager owns interactive Slack** | The manager agent is the *only* agent with a channel binding (`peer=channel:C0AFXJR71V5`) for `#ai-office`. All Slack messages go to it. |
| **Specialists are cron-only** | QA, Content, Security, CFO, CTO, SDR do *not* have channel bindings. They run on schedule and deliver via cron. |
| **First-match routing** | If multiple agents bind the same channel, OpenClaw routes to the first match — not by @mention text. This is why only one agent should be bound. |
| **@mention required** | With `ackReactionScope: "group-mentions"`, the Slack bot only responds to messages that @mention the bot user via Slack autocomplete — not plain text like `@manager`. |
| **Manager delegates** | To invoke a specialist interactively, message the manager in `#ai-office`. It delegates via `openclaw agent --agent <id> --message "<task>"`. |

---

## Key Gotchas

Hard-won lessons from building the fleet. Full details in [RUNBOOKS/new-agent-onboarding.md](../RUNBOOKS/new-agent-onboarding.md).

| Gotcha | Detail |
|---|---|
| **No specialist channel bindings** | Adding a channel binding for a specialist breaks routing — manager must be the sole `#ai-office` responder |
| **@mention via autocomplete only** | Plain text `@manager` does not trigger the bot; you must use Slack's autocomplete to @mention the bot user |
| **Channel ID required everywhere** | Both CLI (`--reply-to`) and cron (`delivery.to`) require Slack channel ID `C0AFXJR71V5`, not `#ai-office`. Display names fail silently |
| **Cron delivery ≠ binding** | Agents can *deliver* to `#ai-office` (channel ID `C0AFXJR71V5`) via cron's `delivery.to` without needing a channel binding |
| **Update SOUL.md + fleet-status.md** | When onboarding new agents, also update the manager's `SOUL.md` routing table and `fleet-status.md` — not just `TOOLS.md` |
| **Non-interactive CLI only** | Commands like `gh pr create` (without `--fill`/`--body`) hang forever waiting for input |
| **`missing_scope` warning is benign** | `channel resolve failed; using config entries` on startup is non-blocking — safe to ignore |

---

## Runbook Reference

| Runbook | Purpose |
|---|---|
| [new-agent-onboarding.md](../RUNBOOKS/new-agent-onboarding.md) | Step-by-step checklist for adding a new agent to the fleet |
| [cron-troubleshooting.md](../RUNBOOKS/cron-troubleshooting.md) | Diagnose and fix cron job delivery, timeout, and pairing failures |
| [ci.md](../RUNBOOKS/ci.md) | CI workflow docs — `no-secrets.yml` linter, failure handling, pattern updates |
| [session-handoff.md](../RUNBOOKS/session-handoff.md) | Handoff record template and pre-handoff checklist |
| [new-agent-slack-setup.md](../RUNBOOKS/new-agent-slack-setup.md) | Slack app configuration for new agents |
| [logging-conventions.md](../RUNBOOKS/logging-conventions.md) | Logging directory structure and file naming standards |
| [standup.md](../RUNBOOKS/standup.md) | `fleet-status.md` schema spec — structured standup format for all agents |
| [backlog-refinement.md](../RUNBOOKS/backlog-refinement.md) | Weekly Product Agent backlog pass — produces `TASKS/BACKLOG.md` |
| [sprint-planning.md](../RUNBOOKS/sprint-planning.md) | Bi-weekly sprint commitment format — Product drafts, CTO validates |
| [retro.md](../RUNBOOKS/retro.md) | Post-sprint retrospective — Security Agent files, Dev Agent appends health metrics |
| [incident-response.md](../RUNBOOKS/incident-response.md) | SEV-1/2 incident handling — RCA format, action item tracking, agent scanning |

---

*CampClaw Step 11 artifact. See [TASK 0025](../TASKS/0025-step11-the-system.md) · [CAMPCLAW.md](../CAMPCLAW.md)*

# Logging Conventions — AI Office Mac Mini

> **Audience:** All agents and human operators running pipelines on the AI Office Mac Mini  
> **Owner:** `ai@appyhourlabs.com` (conventions); `matt@appyhourlabs.com` (approval)  
> **Last updated:** 2026-02-21

---

## Directory Structure

All local agent logs live under `~/ai-office-logs/` on the Mac Mini, owned by the `aioffice` macOS user.

```
~/ai-office-logs/
├── agents/      ← Per-agent action logs
├── pipelines/   ← Full pipeline run logs (input → output)
└── incidents/   ← Operational incident records (local copy; formal reports go in INCIDENTS/ in the repo)
```

Set up with:

```bash
mkdir -p ~/ai-office-logs/agents
mkdir -p ~/ai-office-logs/pipelines
mkdir -p ~/ai-office-logs/incidents
chmod 700 ~/ai-office-logs
```

> **Note:** `~/ai-office-logs/` is excluded from the repo via `.gitignore`. Logs must never be committed.

---

## Log Entry Format

Every agent action must produce a structured JSON log entry. One entry per action.

```json
{
  "timestamp": "YYYY-MM-DDTHH:MM:SSZ",
  "agent_id": "ai@appyhourlabs.com|sales@appyhourlabs.com|media@appyhourlabs.com|doc@appyhourlabs.com",
  "action_type": "draft|review|pipeline_run|escalation|publish",
  "target_file": "relative/path/to/file",
  "policy_gates_run": ["outbound-quality-gate", "brand-voice-gate"],
  "outcome": "pass|fail|pending",
  "notes": "Optional human-readable note"
}
```

### Field Definitions

| Field | Required | Values | Notes |
|---|---|---|---|
| `timestamp` | ✅ | ISO 8601 UTC | Always UTC. No local timezone offsets. |
| `agent_id` | ✅ | `ai@appyhourlabs.com`, `sales@appyhourlabs.com`, `media@appyhourlabs.com`, `doc@appyhourlabs.com` | Exact account identifier. |
| `action_type` | ✅ | `draft`, `review`, `pipeline_run`, `escalation`, `publish` | Use the closest matching type. |
| `target_file` | ✅ | Relative repo path or local path | What file or resource was acted on. |
| `policy_gates_run` | ✅ | Array of gate names | Empty array `[]` if no gates were run. |
| `outcome` | ✅ | `pass`, `fail`, `pending` | `pending` = action initiated but not yet resolved. |
| `notes` | ❌ | Free text | Optional. Must never contain credentials, tokens, or PII. |

---

## Hard Rules

- **No credentials, tokens, or PII** in any log field — including `notes`. This is a hard guardrail per [`POLICIES/ai-safety-charter.md`](../POLICIES/ai-safety-charter.md).
- **No external data** (email addresses, names, phone numbers) in log output.
- **ISO 8601 timestamps only.** No relative times ("just now", "5 minutes ago").
- **One JSON object per line** (newline-delimited JSON / NDJSON format).

---

## File Naming

Log files in `~/ai-office-logs/agents/` should follow:

```
YYYY-MM-DD-<agent_id>.log
```

Example: `2026-02-21-ai.log`

Append to the same daily file throughout the day. Rotate at midnight UTC.

---

## Log Rotation

- Rotate logs monthly (archive previous month's files to `~/ai-office-logs/archive/YYYY-MM/`)
- No automated log shipping is configured in Phase A
- Do not delete logs without `matt@appyhourlabs.com` approval

---

## Verification

After creating the directories, confirm setup is correct:

```bash
# Confirm directories exist and permissions are set
ls -la ~/ai-office-logs/

# Write a test log entry
echo '{"timestamp":"2026-02-21T00:00:00Z","agent_id":"ai@appyhourlabs.com","action_type":"pipeline_run","target_file":"TASKS/0006-mac-mini-logging-setup.md","policy_gates_run":[],"outcome":"pass","notes":"Logging setup verified"}' >> ~/ai-office-logs/agents/2026-02-21-ai.log

# Confirm the entry was written
cat ~/ai-office-logs/agents/2026-02-21-ai.log
```

---

*Related: [`TASKS/0006-mac-mini-logging-setup.md`](../TASKS/0006-mac-mini-logging-setup.md) · [`POLICIES/ai-safety-charter.md`](../POLICIES/ai-safety-charter.md) · [`PROJECTS/0002-mac-mini-ai-office-setup.md`](../PROJECTS/0002-mac-mini-ai-office-setup.md)*

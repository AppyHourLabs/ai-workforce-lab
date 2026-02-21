# Task 0006 — Create Local Logging Directory and Establish Logging Conventions

> **Project:** [0002 — Mac Mini AI Office Setup](../PROJECTS/0002-mac-mini-ai-office-setup.md)  
> **Owner:** Human setup (`matt@`); AI convention implementation (`ai@`)  
> **Priority:** P1  
> **Status:** Open

---

## Goal

Create a local logging directory on the AI Office Mac Mini for agent action logs, and document the logging conventions all agents must follow in Phase A.

---

## Steps

### Directory Setup
1. As `aioffice` macOS user, create the logging directory:
   ```bash
   mkdir -p ~/ai-office-logs/agents
   mkdir -p ~/ai-office-logs/pipelines
   mkdir -p ~/ai-office-logs/incidents
   ```
2. Set permissions so only `aioffice` user can write:
   ```bash
   chmod 700 ~/ai-office-logs
   ```

### Log Format Convention
3. Establish the standard structured log format for agent actions:
   ```json
   {
     "timestamp": "YYYY-MM-DDTHH:MM:SSZ",
     "agent_id": "ai@|sales@|media@|doc@",
     "action_type": "draft|review|pipeline_run|escalation|publish",
     "target_file": "relative/path/to/file",
     "policy_gates_run": ["outbound-quality-gate", "brand-voice-gate"],
     "outcome": "pass|fail|pending",
     "notes": "Optional human-readable note"
   }
   ```
4. Document this format in `RUNBOOKS/logging-conventions.md` (create this file)
5. Verify the logging path is added to `.gitignore` so local logs are never committed

### Verification
6. Create a test log entry manually to confirm the format and path work
7. Confirm via `ls -la ~/ai-office-logs/agents` that the file exists and is owned by `aioffice`

---

## Owner (Human vs AI)

- **Directory creation and permissions:** Human (`matt@`)
- **Convention documentation:** AI (`ai@`) may draft; human reviews before merge
- **Verification:** Either

---

## Dependencies

- Task 0003 complete (`aioffice` user exists)
- `.gitignore` must be updated to exclude `~/ai-office-logs/` from any repo commits

---

## Definition of Done

- [ ] `~/ai-office-logs/agents/`, `/pipelines/`, `/incidents/` directories created
- [ ] Permissions set to owner-only write
- [ ] `RUNBOOKS/logging-conventions.md` written with the required log schema
- [ ] `.gitignore` excludes local log paths
- [ ] Test log entry created and verified

---

## Risk Notes

- **Logs must never include credentials, tokens, or PII** — even in the `notes` field. This is a hard guardrail per [`POLICIES/ai-safety-charter.md`](../POLICIES/ai-safety-charter.md).
- **Log rotation:** local logs will grow over time. Plan to rotate or archive monthly. No automated log shipping is configured in Phase A.
- **Incident logs** in `~/ai-office-logs/incidents/` are for local operational records. Formal incident reports go in `INCIDENTS/` in this repo.

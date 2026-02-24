# TASK 0036 — Logging Coverage: Structured Agent Action Logs

> **Status:** ready
> **Owner:** CTO Agent
> **Priority:** P0
> **Created:** 2026-02-22
> **Estimated effort:** 60–90 minutes

## Goal

Implement structured logging for all agent pipeline actions in the AI Workforce Lab, achieving ≥ 80% action log coverage in the first 30 days and establishing the format required for Phase B promotion (100% coverage gate).

## Context

Phase B promotion requires 100% agent action log coverage with specific required fields per entry. Without structured logs, there is no audit trail, no ability to spot-check agent behavior, and no observability into runaway or misbehaving agents. This task creates the logging foundation so all other agent work in Phase A is auditable.

## Steps

1. Review `RUNBOOKS/logging-conventions.md` for the required log format.
2. Define the required fields for each agent action log entry:
   ```
   {
     "timestamp": "ISO 8601",
     "agent_id": "string (e.g., doc@appyhourlabs.com)",
     "action_type": "string (e.g., publish_draft, create_task, run_eval)",
     "target_file": "string or null",
     "policy_gates_run": ["list of gate names"],
     "outcome": "success | failure | escalated",
     "session_id": "string",
     "notes": "string (optional)"
   }
   ```
3. Identify all current agent action points (pipeline steps from `TASKS/0027-evalpal-agent-tooling.md` morning schedule).
4. Implement or update logging at each action point to emit structured JSON to:
   - A local log file per agent session: `LOGS/<agent_id>/<date>.jsonl`
   - A summary entry in the session handoff YAML block
5. Write a log validation script that checks format compliance and reports coverage %.
6. Run the script and document current baseline coverage in `EVALS/results/0036-log-coverage-YYYY-MM-DD.md`.
7. Commit the logging implementation and validation script.

## Owner

CTO Agent (`ai@appyhourlabs.com`)

## Dependencies

None — foundational; should be one of the earliest tasks executed.

## Definition of Done (Measurable)

- [ ] Log schema defined and documented in `RUNBOOKS/logging-conventions.md` (updated)
- [ ] All identified agent action points emit structured JSON log entries
- [ ] Log validation script exists and is runnable: `scripts/validate-logs.sh` or equivalent
- [ ] Baseline coverage % documented in `EVALS/results/0036-log-coverage-YYYY-MM-DD.md`
- [ ] `LOGS/` directory exists (`.gitignore`d for actual log files; scaffold committed)
- [ ] Session handoff summary includes log entry count for the session

## Risk Notes

- **NEVER** log actual user data, eval contents, or secret values in action logs.
- Log files must be `.gitignore`d — committed logs are a data exposure risk.
- Log schema must remain backward-compatible as new action types are added.
- SHA-256 log batch hashes required for Phase B (defer that step to Phase B prep).

## Links

- [RUNBOOKS/logging-conventions.md](../RUNBOOKS/logging-conventions.md)
- [RUNBOOKS/session-handoff.md](../RUNBOOKS/session-handoff.md)
- [POLICIES/phase-a-to-b.md](../POLICIES/phase-a-to-b.md)

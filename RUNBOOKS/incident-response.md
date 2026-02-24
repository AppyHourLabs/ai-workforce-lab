# Runbook: Incident Response

> Follow this process whenever a SEV-1 or SEV-2 incident occurs.
> Ensures action items get addressed immediately and agents can report on what happened.

## When to Use

- **SEV-1:** Agent acted out of scope, security breach, data leak → immediate escalation
- **SEV-2:** Pipeline stall, multiple agents failing, auth/infra breakdown → RCA required
- **SEV-3:** Single agent failure, minor config issue → fix and note in fleet-status

---

## Process

### 1. Triage & Fix

Resolve the immediate issue. Get agents running again.

### 2. Write RCA

File: `DOCS/incidents/YYYY-MM-DD-<short-description>-rca.md`

Include:
- **Timeline** — what happened and when
- **Root cause(s)** — why it happened
- **Resolution** — what fixed it
- **Lessons learned** — what we now know
- **Action items** — table with `#`, `Action`, `Owner`, `Status`

### 3. Update Shared Brain

Add an incident entry to `fleet-status.md` under Recent Activity:

```markdown
- [system] **INCIDENT — SEV-X <title> (<time range>).** <1-2 sentence summary>. Full RCA: `DOCS/incidents/<filename>.md`
```

This ensures doc/content agents discover the incident on their next run.

### 4. Execute Action Items Immediately

Do NOT leave action items for future runs. Address them in the same session:
- **Doc/config changes** → make the edits, commit to main
- **Runbook updates** → update the relevant runbook
- **Watchdog/monitoring** → update scripts, verify they work
- **Agent updates** → update SOUL.md files if agents need new scanning behavior

Mark each action item as ✅ DONE in the RCA as you complete it.

### 5. Agent Scanning (Ongoing)

The CTO and Manager agents scan for unresolved incidents:

- **CTO:** On each run, checks `DOCS/incidents/` for RCAs with open action items. Flags unresolved infra/architecture items in their status update.
- **Manager:** Collates any unresolved incident action items into the daily briefing with a 🔔 tag for Matt.

---

## Severity Guide

| Level | Criteria | Response Time | RCA Required? |
|-------|----------|---------------|---------------|
| SEV-1 | Security breach, out-of-scope agent action, data exposure | Immediate | Yes |
| SEV-2 | Pipeline stall, multiple agents down, auth/infra failure | Same day | Yes |
| SEV-3 | Single agent failure, minor config drift | Next run | No (note in fleet-status) |

---

## Incident History

| Date | SEV | Summary | RCA |
|------|-----|---------|-----|
| 2026-02-23 | SEV-2 | Gateway auth outage — 6/10 agents failed (missing auth-profiles.json) | [RCA](../DOCS/incidents/2026-02-23-gateway-auth-outage-rca.md) |

---

*Part of the AI Workforce Lab operational runbooks. See [system-operations.md](../DOCS/system-operations.md).*

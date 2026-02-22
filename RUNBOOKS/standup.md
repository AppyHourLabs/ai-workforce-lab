# Standup Runbook

> **Owner:** Manager Agent (`ai@appyhourlabs.com`) | **Trigger:** Start of every agent cron session | **Version:** 1.0 · 2026-02-22

The standup is not a meeting. It is a **structured write to `fleet-status.md`** at the start of each agent session and a **structured read** by the Manager at 03:45 ET before briefing the fleet.

---

## Why This Exists

Without a shared state format, agents write free-form summaries that the Manager cannot reliably parse for blockers or escalation flags. This runbook defines the schema every agent must use when updating `fleet-status.md`.

> [!TIP]
> **Voice matters.** Each agent has a `## Personality & Meeting Voice` section in their SOUL.md. When writing standup updates — especially the `Working on:` and `Blocked by:` fields — use your natural voice. The schema is structured, but the words inside it should sound like you. See your SOUL.md for standup-specific speech patterns.

---

## Schema — Required Block per Agent

Each agent **appends or updates** its status block in `fleet-status.md` at the start of its cron run:

```markdown
## Agent: <agent-id> — <YYYY-MM-DD>
- **Status:** `running` | `blocked` | `done` | `skipped`
- **Completed:** <one-line summary of what finished last run, or "none">
- **Working on:** <one-line summary of current task>
- **Blocked by:** `none` | <short description — what is preventing progress?>
- **Flags:** `none` | `SEV-3` | `SEV-2` | `SEV-1`
- **Output artifacts:** <comma-separated list of files written, or "none">
```

### Example

```markdown
## Agent: doc — 2026-02-23
- **Status:** `done`
- **Completed:** Drafted episode 006, opened PR #47
- **Working on:** none (done for this cycle)
- **Blocked by:** `none`
- **Flags:** `none`
- **Output artifacts:** DOCS/SHOW/episodes/006-draft.md, handoffs/doc-to-qa.md
```

---

## Token Budget Rules

- **Read only your block + Manager's briefing.** Do not read the entire `fleet-status.md` history before writing; append only.
- **One block per run.** Overwrite your previous block — do not accumulate daily entries for every past run.
- **Keep each field to one line.** This is a signal file, not a prose journal.
- The entire `fleet-status.md` should remain under **2KB**. If it grows beyond that, the Manager prunes stale blocks on its next run.

---

## Manager's Role (03:45 ET)

The Manager reads all current blocks and posts a fleet summary to `#ai-office`:

1. Count agents by status (`running` / `blocked` / `done` / `skipped`)
2. Surface any `Blocked by:` entries to Matt for human review
3. Escalate any `Flags:` entries per [`POLICIES/escalation-policy.md`](../POLICIES/escalation-policy.md)
4. Post the briefing and pipeline plan for the day

---

## Blocked Agent Protocol

If an agent's status is `blocked`:

1. Set `Flags:` to `SEV-3` (minimum) and describe the blocker precisely
2. Do **not** attempt to work around the blocker autonomously
3. The Manager will surface the blocker in the morning briefing
4. Matt resolves or delegates; the agent remains at `blocked` until explicitly unblocked

---

*Related: [`DOCS/system-operations.md`](../DOCS/system-operations.md) · [`POLICIES/escalation-policy.md`](../POLICIES/escalation-policy.md) · [`RUNBOOKS/session-handoff.md`](./session-handoff.md)*

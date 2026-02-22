# Human Escalation — Slack @Mention Protocol

> **Status:** Active | **Owner:** `matt@appyhourlabs.com` | **Version:** 1.0 · 2026-02-22

---

## Purpose

When an agent's output contains items that require Matt's attention (approve, send, merge, review, decide), the agent must tag `<@U08R1DR4LFJ>` in its `#ai-office` Slack message so Matt receives a push notification.

---

## When to Tag

| Tag | Don't Tag |
|---|---|
| PR ready for merge | Routine "no changes" status |
| Outreach draft ready to send | Pipeline running normally |
| Content approved — needs human publish | Agent completed work with no blockers |
| Budget alert or cost threshold exceeded | Informational cost summary |
| Architecture decision needing approval | ADR drafted, no urgency |
| Security finding (SEV-1 or SEV-2) | SEV-3 or no findings |
| Agent blocked — needs human input | Agent standing by, nothing pending |

---

## Format

```
🔔 <@U08R1DR4LFJ> — **[Agent Name]** [what needs doing] → [file path or link]
```

### Fields

| Field | Description | Example |
|---|---|---|
| **Agent Name** | Which agent is escalating | SDR, QA, Security |
| **What** | One-line action needed | "outreach batch ready to send" |
| **Where** | File path, PR link, or task reference | `TASKS/outbound/2026-02-22-media-outreach-batch.md` |

### Examples

```
🔔 <@U08R1DR4LFJ> — **SDR** outreach batch ready to send → TASKS/outbound/2026-02-22-media-outreach-batch.md
🔔 <@U08R1DR4LFJ> — **Doc** Episode 004 PR open, needs merge → PR #23
🔔 <@U08R1DR4LFJ> — **QA** Episode 003 has broken relative links, doc owes a fix before Content can proceed
🔔 <@U08R1DR4LFJ> — **Security** SEV-2: API key pattern detected in PR #25 diff
🔔 <@U08R1DR4LFJ> — **CFO** token spend up 40% week-over-week, review recommended → TASKS/finance/2026-02-22-spend-alert.md
```

---

## Multiple Items

If an agent has multiple action items, group them under a single 🔔 block:

```
🔔 <@U08R1DR4LFJ> — **Manager** action items from today's pipeline:
  • SDR outreach batch ready to send → TASKS/outbound/2026-02-22-media-outreach-batch.md
  • Doc Episode 003 needs link fix before Content can pick it up
```

---

## Manager Agent Role

The Manager Agent collates action items from all agents in its morning briefing. If any agent wrote action-required items to `fleet-status.md` or handoff files, the manager includes them in a tagged summary block.

---

## Safety

- This protocol is for **internal Slack notifications only** — no external emails, DMs to outside parties, or automated sends.
- Follows [POLICIES/escalation-policy.md](../POLICIES/escalation-policy.md) for severity classification.
- SEV-1 incidents still require immediate stop + tag (per escalation policy).

---

*Related: [`POLICIES/escalation-policy.md`](../POLICIES/escalation-policy.md) · [`RUNBOOKS/session-handoff.md`](./session-handoff.md)*

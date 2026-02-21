# Session Handoff Runbook

> Use this runbook whenever an agent or human ends a working session. Copy the handoff record template at the bottom, fill it in, and paste it into the relevant project or task file before closing.

---

## Why This Exists

Context dies between sessions. This runbook is the bridge. A good handoff means the next session — whether run by a human or an agent — doesn't start from scratch.

A bad handoff means someone (probably `matt@appyhourlabs.com`) spends 20 minutes reconstructing what happened. Fill this in.

---

## Pre-Handoff Checklist

Before ending any session, confirm:

- [ ] All in-progress changes are committed or noted as uncommitted with a reason
- [ ] No secrets or personal information were introduced in any file
- [ ] External communications drafted this session have been submitted for review or marked as pending
- [ ] Any escalation-worthy events are logged per [`POLICIES/escalation-policy.md`](../POLICIES/escalation-policy.md)
- [ ] All eval gate results from this session are filed in `EVALS/results/`
- [ ] Updated tasks in `TASKS/` reflect current status (`Open` / `In Progress` / `Complete`)

---

## Handoff Record Template

Copy and paste this block into the relevant `PROJECTS/` or `TASKS/` file, or into a new session note:

```markdown
## Session Handoff — [YYYY-MM-DD]

**Date:** YYYY-MM-DD  
**From:** [account / name]  
**To:** [account / name, or "next available session"]  
**Session scope:** [one sentence — what was this session for?]

### Completed this session
- [item]
- [item]

### In progress / carry-over
- [item] — [why it isn't done / what's blocking]

### Next tasks (prioritized)
1. [task] — [link to TASKS/XXXX.md]
2.
3.

### Risks / escalations
- [Any open risk decisions, ambiguous situations, or items that need matt@appyhourlabs.com eyes]

### Links updated this session
- [PROJECTS/XXXX.md](../PROJECTS/)
- [POLICIES/XXXX.md](../POLICIES/)
- [TASKS/XXXX.md](../TASKS/)
- [DOCS/SHOW/episodes/](../DOCS/SHOW/episodes/)
```

---

## Safety Checks Before Handoff

- External communications this session comply with [`POLICIES/posting-policy.md`](../POLICIES/posting-policy.md)
- Any OAuth or access changes comply with [`POLICIES/oauth-policy.md`](../POLICIES/oauth-policy.md)
- High-risk decisions have escalation notes per [`POLICIES/escalation-policy.md`](../POLICIES/escalation-policy.md)
- If any credential was encountered (even accidentally), it was rotated — not just removed from the file

---

## Next Session Prompt

When starting a new session with an AI agent, include this context block:

```
We are running the AI Workforce Lab (AppyHourLabs/ai-workforce-lab).
Current autonomy tier: Phase A — all outbound requires human approval.
Read AGENTS.md for the full context and account model.
Read the most recent session handoff note for current state.
Start by reviewing open tasks in TASKS/ and confirming your assigned scope before acting.
```

---

*Related: [`POLICIES/escalation-policy.md`](../POLICIES/escalation-policy.md) · [`POLICIES/posting-policy.md`](../POLICIES/posting-policy.md) · [`AGENTS.md`](../AGENTS.md)*

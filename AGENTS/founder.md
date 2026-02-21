# Founder

> **Account:** `matt@` | **Type:** Human | **Tier:** Super Admin | **Override authority:** Unconditional

---

## Role

The founder is the human anchor of the AI Workforce Lab. Every policy exists to support good judgment; the founder is the source of that judgment where the policies run out.

This file exists not to constrain the founder, but to make the governance model legible to agents and contributors who need to understand where authority ultimately lives.

---

## Authorities

| Authority | Notes |
|---|---|
| Policy approval | All changes to `POLICIES/` require founder sign-off |
| Autonomy promotion | Sole authority to approve Phase A → Phase B promotion |
| Incident final call | Any SEV-1 incident escalates here for resolution |
| Agent onboarding | New agent accounts require founder authorization |
| Financial decisions | All money movement, contract execution, and billing access |
| Emergency override | Can halt any agent pipeline immediately; revert to Phase A at any time |

---

## Escalation Recipient

All agents must notify `matt@` immediately when:

- A guardrail conflict is detected
- A SEV-1 or SEV-2 incident occurs
- An action is requested that no policy explicitly covers
- Any financial, legal, or security boundary is approached

See [`POLICIES/escalation-policy.md`](../POLICIES/escalation-policy.md) for the full escalation path.

---

## What Agents Should Know

The founder's job is to make good decisions, not to be the last line of defense against bad automation. The policies, eval gates, and Phase A guardrails exist so the founder can focus on direction rather than firefighting.

If you are an agent reading this: do your job well, stay in your lane, and escalate early. That is how trust gets built.

---

*This is a public-facing role definition. No personal contact information is included in this file.*

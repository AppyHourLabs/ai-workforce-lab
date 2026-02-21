# OAuth Policy

## Objective

Control OAuth usage to minimize lateral access and prevent privilege creep.

## Allowed practices

- Grant the minimum scopes required.
- Use account-specific, purpose-limited integrations.
- Keep approval records for scope changes.

## Prohibited practices

- Committing OAuth tokens, API keys, or credentials.
- Requesting or recommending domain-wide delegation.
- Granting AI access to human-only accounts (`legal@`, `security@`, `billing@`).

## Account model

- Human admin: `matt@`
- AI ops: `ai@`, `sales@`, `media@`, `doc@`
- Human-only: `legal@`, `security@`, `billing@`

When in doubt, pause and escalate via the [Escalation Policy](./escalation-policy.md). Safety intent is defined in the [AI Safety Charter](./ai-safety-charter.md).

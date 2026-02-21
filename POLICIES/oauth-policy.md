# OAuth Policy

> **Status:** Active | **Owner:** `matt@appyhourlabs.com` | **Version:** 1.0 · 2026-02-21

---

## Objective

Control OAuth and API access so that AI agents operate with the minimum required scopes, no agent can escalate its own permissions, and privileged human-only accounts remain inaccessible to automated processes.

---

## Allowed Practices

- Grant only the specific scopes required for each agent's documented task
- Use per-account, purpose-limited OAuth integrations
- Maintain a documented approved app list (updated in session handoff notes)
- Review and prune app access quarterly or after any security incident

---

## Prohibited Practices

| Practice | Reason |
|---|---|
| Committing OAuth tokens, API keys, or credentials to the repo | Immediate SEV-1 incident — treated as compromised |
| Requesting domain-wide delegation for any account | Violates AI Safety Charter; cannot be approved |
| Granting any AI agent access to `legal@appyhourlabs.com`, `security@appyhourlabs.com`, or `billing@appyhourlabs.com` | Human-only accounts; no exceptions |
| An agent approving its own scope expansion | All scope changes require `matt@appyhourlabs.com` authorization |
| Using a super-admin account on the AI Office machine | Admin credentials must not be used on the `aioffice` macOS user |

---

## Account Access Model

| Account | OAuth Access Level | AI Can Access? |
|---|---|---|
| `matt@appyhourlabs.com` | Super admin | ❌ (human only) |
| `ai@appyhourlabs.com` | Scoped to approved integrations | ✅ (within scope) |
| `sales@appyhourlabs.com` | Gmail read/send (draft); Outreach tools | ✅ (drafting only) |
| `media@appyhourlabs.com` | Social platform draft APIs | ✅ (drafting only) |
| `doc@appyhourlabs.com` | GitHub (PR open); Drive (read) | ✅ (within scope) |
| `legal@appyhourlabs.com` | Human-controlled | ❌ |
| `security@appyhourlabs.com` | Human-controlled | ❌ |
| `billing@appyhourlabs.com` | Human-controlled | ❌ |

---

## Scope Change Process

1. Agent or human identifies a required new scope
2. Document the request in a `TASKS/` file with business justification
3. `matt@appyhourlabs.com` reviews and approves (or denies) the scope change
4. Scope is granted via Workspace Admin — never by the agent itself
5. Change is logged in session handoff notes

---

## Incident Response

Any discovered credential exposure (in repo, logs, or external system) is immediately **SEV-1**. See [`POLICIES/escalation-policy.md`](./escalation-policy.md) and rotate the credential before filing the report.

---

*Related: [`POLICIES/ai-safety-charter.md`](./ai-safety-charter.md) · [`POLICIES/escalation-policy.md`](./escalation-policy.md) · [`RUNBOOKS/ci.md`](../RUNBOOKS/ci.md)*

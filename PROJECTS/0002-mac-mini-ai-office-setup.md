# Project 0002 — Mac Mini AI Office Setup

> **Status:** Active | **Owner:** `matt@` | **Priority:** P1

---

## Objective

Configure the Mac Mini as a dedicated, hardened AI Office — a fixed, auditable piece of infrastructure where agent pipelines run reliably, actions are logged, and human-only access boundaries are enforced at the OS level.

---

## Success Criteria

- macOS `aioffice` standard user created; no admin privileges
- FileVault enabled; firewall enabled; all remote sharing services disabled
- Standard toolchain installed: Homebrew, Git, Node 20, Docker, Chrome, Slack
- Isolated Chrome profiles created for `ai@`, `sales@`, `media@`, `doc@`
- Local logging directory created with documented conventions
- Agent pipelines can run and produce structured log output
- Human-only accounts are inaccessible from the `aioffice` session
- Environment can be fully rebuilt from documentation in this repo

---

## Tasks

| Task | File | Status |
|---|---|---|
| Create `aioffice` macOS user and harden settings | [`TASKS/0003`](../TASKS/0003-2fa-ai-account-media.md) | Open |
| Install tooling (brew, git, node, docker, chrome, slack) | [`TASKS/0004`](../TASKS/0004-2fa-ai-account-doc.md) | Open |
| Create Chrome profiles for AI ops accounts | [`TASKS/0005`](../TASKS/0005-api-controls-gmail-drive.md) | Open |
| Create local logging directory and conventions | [`TASKS/0006`](../TASKS/0006-api-controls-calendar-contacts.md) | Open |

---

## Completion Definition

- All success criteria above verified and documented
- Session handoff note filed (ISO date, verifier: `matt@`)
- `matt@` has approved go-live via PR sign-off
- No agent pipeline runs until this project is marked complete

---

## Risks

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| FileVault recovery key loss | Low | Critical | Store key off-device before enabling; document storage location in handoff (not the key itself) |
| Tool version incompatibility | Medium | Medium | Use `node@20` specifically; test with verification step before proceeding |
| Chrome profile session bleed | Low | Medium | Verify isolation explicitly after profile setup; document verification result |
| Standard user can't run some agent tools | Medium | Medium | Test agent workflows under `aioffice` user before declaring complete |

---

## Notes

*"Reliable office assistant, not mystery box with Wi-Fi."* The Mac Mini's value is predictability and auditability. Any configuration that can't be documented here shouldn't be on the machine.

*Related: [`POLICIES/ai-safety-charter.md`](../POLICIES/ai-safety-charter.md) · [`RUNBOOKS/session-handoff.md`](../RUNBOOKS/session-handoff.md) · [`AGENTS/cto-agent.md`](../AGENTS/cto-agent.md)*

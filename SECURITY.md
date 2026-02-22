# Security Policy

## Reporting a Vulnerability

Email `security@appyhourlabs.com`. Do not open public issues for security findings.

We will acknowledge receipt within 48 hours and provide an initial assessment within 5 business days.

---

## Scope

This repository contains **documentation, governance policies, and CI workflows** for the AI Workforce Lab. It does not contain application code, credentials, or infrastructure configurations.

### In-Scope

- Secrets or PII accidentally committed to any file or git history
- CI workflow vulnerabilities (e.g., injection via PR titles, unsafe action versions)
- CODEOWNERS or branch protection bypass vectors
- Exposed infrastructure identifiers that could enable unauthorized access

### Out of Scope

- Slack channel IDs (not exploitable without valid OAuth tokens)
- Email addresses documented as role identifiers in `AGENTS.md` and `AGENTS/`
- Content quality issues in documentary episodes or drafted posts

---

## Protections in Place

| Layer | Protection |
|---|---|
| **Secret scanning** | GitHub-native secret scanning + push protection enabled |
| **CI** | `no-secrets.yml` scans all PR diffs for API keys, tokens, PEM blocks |
| **Branch protection** | `main` requires PR review, status checks, no force-push |
| **CODEOWNERS** | All governance files require `@AppyHourLabs/founders` review |
| **PR template** | Security Considerations section mandatory on every PR |

---

## Credential Rotation

If a credential is exposed in this repository — even briefly, even in a force-pushed commit — it must be rotated immediately. Removing the file or line is **not sufficient**; git history is permanent.

See [`RUNBOOKS/ci.md`](RUNBOOKS/ci.md) for the full secret pattern list.

---

*Maintained by `matt@appyhourlabs.com` · Last updated: 2026-02-22*

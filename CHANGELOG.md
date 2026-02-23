# Changelog

All notable changes to this project will be documented here.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).  
Dates use ISO 8601 (`YYYY-MM-DD`).

---

## [Unreleased]

### Added
- `CONTRIBUTING.md` — contributor guide for humans and AI agents
- `CODE_OF_CONDUCT.md` — Contributor Covenant v2.1
- `CHANGELOG.md` — this file

---

## [0.3.0] — 2026-02-22

### Added
- Agile ceremonies runbooks for the agent fleet (`RUNBOOKS/ceremonies/`)
- `PROJECTS/0003-agile-ceremonies-for-agent-fleet.md`
- EvalPal mission brief (`DOCS/evalpal-mission-brief.md`)
- Agent alignment documentation for EvalPal prep
- Content pipeline: `DOCS/SHOW/` episodes auto-pushed by `doc` agent via PR

### Changed
- `README.md` updated to reflect 10-agent fleet and CampClaw progress (Steps 00–12)

---

## [0.2.0] — 2026-02-21

### Added
- Full repo scaffold: `AGENTS/`, `EVALS/`, `POLICIES/`, `RUNBOOKS/`, `TASKS/`, `PROJECTS/`, `SCHEMAS/`
- Initial agent role definitions for all 10 agents
- `AGENTS.md` — fleet overview and contributor context guide
- `POLICIES/ai-safety-charter.md`, `oauth-policy.md`, `posting-policy.md`, `escalation-policy.md`, `phase-a-to-b.md`
- `SECURITY.md` — vulnerability disclosure policy
- `.github/CODEOWNERS`, `PULL_REQUEST_TEMPLATE.md`, issue templates (`task.md`, `project.md`)
- CI workflow — `no-secrets.yml` (secret scanning on all PRs)
- `CAMPCLAW.md` — CampClaw learning path tracker
- `PROJECTS/0001-google-workspace-hardening.md`
- `PROJECTS/0002-mac-mini-ai-office-setup.md`
- Episodes 000–003 in `DOCS/SHOW/episodes/`

---

## [0.1.0] — 2026-02-21

### Added
- Repository initialized
- `README.md` — project overview, autonomy model, team roster
- `LICENSE` — MIT
- `.gitignore`, `.env.example`, `Dockerfile`, `docker-compose.yml`
- `requirements.txt`

---

*This changelog is maintained by the `doc` agent (`doc@appyhourlabs.com`) and reviewed by `matt@appyhourlabs.com`.*

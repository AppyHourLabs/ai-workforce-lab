# Task 0010 — Add CI Workflow for Secret Scanning

> **Project:** CI/CD infrastructure  
> **Owner:** AI (`ai@`) draft; Human (`matt@`) review  
> **Priority:** P0  
> **Status:** Complete — see [.github/workflows/no-secrets.yml](../.github/workflows/no-secrets.yml)

---

## Goal

Add a GitHub Actions workflow that scans every PR diff for known secret patterns (API keys, tokens, private keys, `.env` files) and fails the build if any are found, preventing secrets from reaching `main`.

---

## Steps

1. Create `.github/workflows/no-secrets.yml` triggered on `pull_request` to `main`
2. Implement three scan steps:
   - **`.env` file check** — block any `.env`, `.env.*`, `.env.local`, etc. in the diff
   - **Secret pattern scan** — grep added lines for: `AIza*` (Google), `sk-*` (OpenAI/Anthropic), `-----BEGIN * PRIVATE KEY-----`, `AKIA*` (AWS), GitHub PATs (`ghp_*`, `github_pat_*`), generic high-entropy secret assignments
   - **Summary step** — print clean result or failure instructions
3. Exclude lock files from scan to reduce false positives
4. Document in [`RUNBOOKS/ci.md`](../RUNBOOKS/ci.md)
5. Submit via PR; ensure the workflow itself passes clean

---

## Owner (Human vs AI)

- **Implementation:** AI (`ai@`)
- **Review and merge:** Human (`matt@`)

---

## Dependencies

- GitHub Actions enabled on the repo
- [`RUNBOOKS/ci.md`](../RUNBOOKS/ci.md) for documentation

---

## Definition of Done

- [ ] `.github/workflows/no-secrets.yml` exists and triggers on PRs
- [ ] Workflow correctly fails on a test secret pattern
- [ ] Workflow correctly passes on clean diffs
- [ ] `RUNBOOKS/ci.md` documents the workflow
- [ ] PR reviewed and merged

---

## Risk Notes

- **False positives** will frustrate contributors. The allowlist/exclusion approach in the workflow must be documented clearly.
- **The scan is diff-only** — it does not scan existing repo history. A separate one-time audit of repo history is recommended but out of scope for this task.
- If a secret slips past and reaches `main`, treat it as SEV-1: rotate immediately, file an incident report.

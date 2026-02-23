# TASK 0030 — Secrets Scan: Both Repos

> **Status:** ready
> **Owner:** Security Agent
> **Priority:** P0
> **Created:** 2026-02-22
> **Estimated effort:** 30–60 minutes

## Goal

Confirm that no API keys, tokens, credentials, or secrets are committed anywhere in the EvalPal or ai-workforce-lab repositories, and that pre-commit hooks prevent future exposure.

## Context

A single committed secret can compromise the entire operation — LLM API keys, Supabase service keys, or GitHub tokens exposed in git history are permanent liabilities even after removal, since the history remains. This is a non-negotiable P0 task that must complete before any other agent works in either repo.

## Steps

1. Install `gitleaks` (or confirm it is already installed): `brew install gitleaks` / `npm install -g gitleaks`.
2. Run a full history scan on EvalPal repo: `gitleaks detect --source . --log-opts "--all"`.
3. Run a full history scan on ai-workforce-lab repo: same command.
4. Run `git log --all -p | grep -E "(sk-|AKIA|ghp_|xoxb-|Bearer |password\s*=)"` as a secondary check.
5. If any findings exist:
   - **Stop immediately** — do not push, do not log the secret value.
   - Escalate to Founder per `RUNBOOKS/human-escalation.md`.
   - Document finding category (not the secret itself) in the findings report.
6. Confirm GitHub secret scanning is enabled on both repos (Settings → Security → Secret scanning).
7. Confirm a pre-commit hook (e.g., `pre-commit` with `detect-secrets`) is configured in `.pre-commit-config.yaml`.
8. If pre-commit hook missing, create `.pre-commit-config.yaml` with `detect-secrets` hook and commit it.
9. Document results in `EVALS/results/0030-secrets-scan-YYYY-MM-DD.md`.

## Owner

Security Agent (`security@appyhourlabs.com`)

## Dependencies

None — highest priority; execute first.

## Definition of Done (Measurable)

- [ ] `gitleaks` full history scan returns zero findings on EvalPal repo
- [ ] `gitleaks` full history scan returns zero findings on ai-workforce-lab repo
- [ ] GitHub secret scanning is enabled on both repos (confirmed via UI screenshot or API)
- [ ] Pre-commit hook with `detect-secrets` exists in at least one of the repos
- [ ] Findings (if any) documented by category only — no secret values in any file
- [ ] Escalation filed with Founder if any findings were discovered
- [ ] Results filed in `EVALS/results/0030-secrets-scan-YYYY-MM-DD.md`

## Risk Notes

- **NEVER** document the actual secret value in any commit, log, or report — category only (e.g., "OpenAI API key pattern detected in file X at commit Y").
- If a secret is found, the key must be rotated externally by a human before this task can close.
- Do not run the scan output through an LLM — secrets may be in the scan output.

## Links

- [POLICIES/ai-safety-charter.md](../POLICIES/ai-safety-charter.md)
- [POLICIES/oauth-policy.md](../POLICIES/oauth-policy.md)
- [RUNBOOKS/human-escalation.md](../RUNBOOKS/human-escalation.md)

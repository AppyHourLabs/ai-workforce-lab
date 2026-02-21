# CI Runbook

> **Audience:** Contributors, agents, and on-call operators  
> **Last updated:** 2026-02-21

---

## Workflows

### `no-secrets.yml` — No Secrets Linter

**File:** `.github/workflows/no-secrets.yml`  
**Trigger:** Every pull request targeting `main`  
**Blocking:** ✅ Yes — build fails and merge is blocked if violations are found

---

#### What It Checks

| Check | What it catches |
|---|---|
| **Committed `.env` files** | Any file matching `*.env`, `.env.*`, `.env.local`, etc. added in the PR diff |
| **Google API / Firebase keys** | Strings matching `AIza[0-9A-Za-z-_]{35}` |
| **Generic `sk-` keys** | OpenAI, Anthropic, and similar patterns matching `sk-[A-Za-z0-9]{20,}` |
| **PEM private key blocks** | `-----BEGIN [RSA/EC/OPENSSH/DSA] PRIVATE KEY-----` |
| **AWS credentials** | Access key IDs (`AKIA…`) and secret key assignments |
| **GitHub PATs** | Classic (`ghp_…`) and fine-grained (`github_pat_…`) tokens |
| **Generic secret assignments** | High-entropy values assigned to variables named `secret`, `password`, `api_key`, `auth_token`, etc. |

The scan is **diff-only**: it inspects only lines added by the PR, not the full repository history. This keeps false positives low and scan time fast.

Lock files (`*.lock`, `package-lock.json`, `yarn.lock`) are excluded from scanning.

---

#### When the Build Fails

1. **Read the log.** The failing step will print the matched pattern and the matching line(s).
2. **Remove the value** from your branch. Do not just rename the variable — the value must go.
3. **Rotate the credential immediately.** Assume it is compromised the moment it appears in a PR diff, even in a private repo.
4. **Rebase or amend** history if the secret appeared in a previous commit on your branch (`git rebase -i` and `git commit --amend`). Force-push to clean the branch history.
5. **Re-push** and confirm the check passes.

> **If you rotated a credential due to a CI failure, file an incident report in `INCIDENTS/` even if the PR was never merged. Leaked-to-diff counts as leaked.**

---

#### False Positives

If the scanner flags a value that is not a real secret (e.g., a test fixture with a fake key-shaped string):

1. Open a PR to add an inline comment or narrow the regex in `.github/workflows/no-secrets.yml`.
2. Document the exception with a comment explaining why it is safe.
3. Get a second approval before merging the allowlist change.

Do not simply suppress the check without documentation.

---

#### How to Update Patterns

Secret patterns live in the `check_pattern` calls inside the `Scan for secret patterns` step of `no-secrets.yml`. To add a new pattern:

```bash
check_pattern "Descriptive Label"  'your-regex-here'
```

Each call takes:
- `label` — a human-readable name shown in the failure output
- `pattern` — an ERE (extended regular expression) passed to `grep -E`

Test your regex locally before opening a PR:
```bash
echo 'your_test_string' | grep -E 'your-regex-here'
```

---

#### Skipping the Check (Emergency Only)

The no-secrets check cannot be skipped via commit message flags. If a PR must merge urgently and the check is blocking on a confirmed false positive:

1. A maintainer must manually approve the workflow run via the GitHub Actions UI.
2. A follow-up issue must be filed within 24 hours to resolve the false positive properly.

This path should be used **at most once per quarter**. Frequent use is a signal the allowlist needs updating.

---

## Adding New Workflows

When adding a new CI workflow:

1. Place it in `.github/workflows/`.
2. Document it in a new section in this file.
3. Specify clearly: trigger, what it checks, whether it's blocking, and how to handle failures.

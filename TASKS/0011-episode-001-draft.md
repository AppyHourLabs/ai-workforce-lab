# Task 0011 — Add CI Workflow for Markdown Link Validation (Optional)

> **Project:** CI/CD infrastructure  
> **Owner:** AI (`ai@appyhourlabs.com`) draft; Human (`matt@appyhourlabs.com`) review  
> **Priority:** P3  
> **Status:** Open

---

## Goal

Add an optional GitHub Actions workflow that checks all Markdown files for broken internal links. Prevents published episodes and policy documents from containing dead references.

---

## Steps

1. Create `.github/workflows/markdown-links.yml` triggered on `pull_request` to `main`
2. Use `markdown-link-check` (npm package) or equivalent tool:
   ```yaml
   - name: Check Markdown links
     uses: gaurav-nelson/github-action-markdown-link-check@v1
     with:
       use-quiet-mode: 'yes'
       config-file: '.github/mlc-config.json'
   ```
3. Create `.github/mlc-config.json` to configure:
   - Exclude external URLs from check (we only want to validate internal links in Phase A)
   - Exclude common false-positive patterns (anchor links, mailto:, etc.)
4. Run on all `.md` files in the PR diff
5. Mark the check as **non-blocking** (continue-on-error: true) initially — links breaking a PR merge is aggressive until the repo's links are fully settled
6. Document in [`RUNBOOKS/ci.md`](../RUNBOOKS/ci.md)

---

## Owner (Human vs AI)

- **Implementation:** AI (`ai@appyhourlabs.com`)
- **Review and merge:** Human (`matt@appyhourlabs.com`)

---

## Dependencies

- Task 0010 complete (establishes CI workflow pattern)
- `markdown-link-check` compatible GitHub Actions runner

---

## Definition of Done

- [ ] `.github/workflows/markdown-links.yml` created
- [ ] `.github/mlc-config.json` created with exclusion config
- [ ] Workflow runs on PRs without false-positive failures from expected patterns
- [ ] `RUNBOOKS/ci.md` updated with a section for this workflow
- [ ] PR reviewed and merged

---

## Risk Notes

- **External link checking is intentionally excluded in Phase A.** External URLs can break without a repo change; failing PRs for external link rot creates noise.
- **Non-blocking by default.** Upgrade to blocking once the repo's internal link graph is stable and well-tested.
- This task is **optional** — do not block other work on it. If the team is resource-constrained, defer to Phase B.

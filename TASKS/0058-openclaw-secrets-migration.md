# TASK 0058 — OpenClaw Secrets Migration (Plaintext → SecretRefs)

> **Status:** `active`
> **Owner:** `matt@appyhourlabs.com` (interactive steps) + `aioffice` (verification + automation)
> **Priority:** P1
> **Created:** 2026-04-28
> **Tracks incident:** [`DOCS/incidents/2026-04-27-launchagent-plist-secret-exposure.md`](../DOCS/incidents/2026-04-27-launchagent-plist-secret-exposure.md)
> **Plan:** [`DOCS/openclaw-secrets-migration-plan.md`](../DOCS/openclaw-secrets-migration-plan.md)

---

## Objective

Eliminate the 27 `PLAINTEXT_FOUND` findings reported by
`openclaw secrets audit` across the OpenClaw fleet, using OpenClaw's
native SecretRefs system, without breaking any of the 10 cron-driven
agents.

## Why this is urgent (but not panic-urgent)

- The 2026-04-27 incident hardened the LaunchAgent plist to `0600` and
  documented a wider 27-finding exposure.
- File perms across `auth-profiles.json`, `models.json`, and
  `~/.openclaw/.env` are already `0600`, so the threat surface is
  "anything running as `aioffice`" — same as the
  [2026-03-13 lancedb-pro attempt](../TASKS/2026-03-13-security-incident-lancedb-pro.md).
- A `auth-profiles.json.pre-secretref-20260402-204835` backup shows
  the migration was started 2026-04-02 and not finished. We're
  resuming, not starting.

## Pre-flight

- [ ] Read [`DOCS/openclaw-secrets-migration-plan.md`](../DOCS/openclaw-secrets-migration-plan.md)
      end-to-end. Confirm we're doing **Option A** (file provider)
      first, then evaluating Option B (1Password exec provider).
- [ ] Confirm credentials have all been rotated per the
      [incident action items](../DOCS/incidents/2026-04-27-launchagent-plist-secret-exposure.md#action-items-pending).
      Migrating before rotation just relocates a known-leaked secret.
- [ ] Take a manual backup of the OpenClaw state dir as a safety net:

      ```bash
      cp -a ~/.openclaw "/tmp/openclaw-pre-migration-$(date -u +%Y%m%dT%H%M%SZ)"
      ```

      `secrets apply` is one-way (no rollback files), so this snapshot
      is the only restore point.
- [ ] Confirm gateway is in a known state and quiesce cron during the
      window:

      ```bash
      openclaw gateway status
      openclaw cron list   # note any jobs about to fire
      ```

## Phase 1 — Capture baseline

- [ ] Snapshot the audit:

      ```bash
      openclaw secrets audit --json > /tmp/secrets-audit-pre.json
      openclaw security audit --json > /tmp/security-audit-pre.json
      ```

- [ ] Confirm the baseline numbers match the incident report
      (`plaintextCount=27`, `legacyResidueCount=22`).

## Phase 2 — Configure SecretRefs (Option A: file provider)

> ⚠️ **TTY required.** `openclaw secrets configure` is interactive and
> cannot be driven from a non-TTY shell (e.g., from Cursor's terminal
> tool). Run these from a real terminal session as `aioffice`.

For each agent in this list, run the per-agent configure flow.

Agent list (from the audit):
`main`, `cfo`, `content`, `cto`, `dev`, `doc`, `manager`, `product`,
`qa`, `sdr`, `security`.

- [ ] For each agent `<id>`, generate a plan:

      ```bash
      openclaw secrets configure \
        --agent <id> \
        --skip-provider-setup \
        --plan-out /tmp/secrets-plan-<id>.json
      ```

      `--skip-provider-setup` is safe because `secrets.providers.default`
      (file) is already configured in `openclaw.json`.

- [ ] **Dry-run** every plan before applying any of them:

      ```bash
      for id in main cfo content cto dev doc manager product qa sdr security; do
        echo "=== $id ==="
        openclaw secrets apply \
          --from /tmp/secrets-plan-${id}.json \
          --dry-run
      done
      ```

- [ ] Apply the plans one agent at a time, smallest-blast-radius
      first. Suggested order: `qa` → `security` → `dev` → `content` →
      `doc` → `sdr` → `cfo` → `cto` → `product` → `manager` → `main`.

      ```bash
      openclaw secrets apply --from /tmp/secrets-plan-<id>.json
      openclaw secrets reload
      openclaw secrets audit --check && echo OK || echo "still has findings"
      ```

- [ ] After each apply, run a single agent turn to validate:

      ```bash
      openclaw agent --agent <id> --message "ping"
      ```

      Expected: response without `FailoverError: No API key found for provider`.
      If it fails, see "Rollback / Recovery" below.

## Phase 3 — Migrate the `.env`

`openclaw secrets apply` will scrub matching keys from
`~/.openclaw/.env` automatically (`scrubEnv` defaults to on). After
Phase 2 completes, verify:

- [ ] `openclaw secrets audit --json | python3 -c "import json,sys; d=json.loads(sys.stdin.read()); print([f for f in d['findings'] if f['file'].endswith('.env')])"`
      → empty list.
- [ ] If non-empty, generate a `--scope=env` plan and apply.

## Phase 4 — Plist remediation

The plist is a separate surface from the JSON migration. After
Phase 2/3, decide based on the upstream issue resolution
([draft](../DOCS/openclaw-issue-gateway-install-token-embed.md)):

- [ ] If upstream ships a `--no-embed-secrets` flag (or equivalent):
      reinstall with that flag and verify embedded env vars are gone.
- [ ] If not (interim): document a manual post-install step that
      strips `OPENCLAW_GATEWAY_TOKEN` and channel tokens from the
      plist's `EnvironmentVariables`, then `chmod 600`.
      Reference: [Plist Secrets Check](../RUNBOOKS/cron-troubleshooting.md#plist-secrets-check-post-install--post-repair).

## Phase 5 — Validate end-to-end

- [ ] `openclaw secrets audit --check` exits `0`.
- [ ] `openclaw security audit --json` reports no plaintext findings
      in `secretDiagnostics`.
- [ ] `openclaw gateway restart` completes without prompting for any
      credential.
- [ ] `scripts/rerun.sh all` re-triggers every agent and all complete
      with `lastStatus: "ok"` and `consecutiveErrors: 0`.
- [ ] Capture post-migration audit:

      ```bash
      openclaw secrets audit --json > /tmp/secrets-audit-post.json
      diff <(jq '.summary' /tmp/secrets-audit-pre.json) \
           <(jq '.summary' /tmp/secrets-audit-post.json)
      ```

## Phase 6 — Bookkeeping

- [ ] Update [incident report](../DOCS/incidents/2026-04-27-launchagent-plist-secret-exposure.md):
      mark items 9 and 10 done, link to the post-migration audit
      snapshot.
- [ ] Add a brief note to the next [Security retro](../EVALS/retros/)
      summarizing what we learned.
- [ ] Decide whether to schedule **Option B** (1Password exec
      provider) as a follow-up task. Open question from the migration
      plan: where does the 1Password service-account token live?

## Rollback / Recovery

`secrets apply` is one-way. If an agent breaks after apply:

1. Stop the gateway: `openclaw gateway stop`.
2. Restore the relevant per-agent file from the pre-migration backup:

   ```bash
   BACKUP=/tmp/openclaw-pre-migration-<timestamp>
   cp "$BACKUP/agents/<id>/agent/auth-profiles.json" \
      ~/.openclaw/agents/<id>/agent/auth-profiles.json
   cp "$BACKUP/agents/<id>/agent/models.json" \
      ~/.openclaw/agents/<id>/agent/models.json
   ```

3. Restart: `openclaw gateway start`.
4. File a follow-up issue with the failure mode (full preflight output,
   not redacted secret values).

## Risks

| Risk | Likelihood | Mitigation |
|---|---|---|
| `secrets apply` scrubs a secret we still need | low | full backup taken in Pre-flight; per-agent gated rollout |
| Gateway fails to start after apply (active SecretRef can't resolve) | low | `secrets audit --check` between each agent; activation is fail-fast and OpenClaw keeps last-known-good |
| Some legacy OAuth credentials are out-of-scope for SecretRefs | confirmed | 22 `LEGACY_RESIDUE` findings are info-only per `openclaw secrets audit` docs; not blocking |
| Plist re-embed on next `gateway install` | confirmed | covered by Phase 4 + [upstream issue](../DOCS/openclaw-issue-gateway-install-token-embed.md) |
| Cron jobs fire mid-migration | medium | quiesce cron during the window; smallest-blast-radius agent first |

## Definition of Done

- [ ] All five Phase 5 validation criteria pass.
- [ ] Post-migration audit JSON archived under
      `EVALS/results/security/2026-XX-XX-secrets-migration.md`.
- [ ] Incident action items 9 and 10 closed in the incident report.
- [ ] Decision recorded (in the migration plan's "Open Questions"
      section) on whether to pursue Option B.

## Dependencies

- [Incident: 2026-04-27 plist secret exposure](../DOCS/incidents/2026-04-27-launchagent-plist-secret-exposure.md)
- [Migration plan](../DOCS/openclaw-secrets-migration-plan.md)
- [Upstream issue draft](../DOCS/openclaw-issue-gateway-install-token-embed.md)
- All credential rotations from incident action items 2–7 (precondition).

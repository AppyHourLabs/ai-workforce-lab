# OpenClaw Secrets Migration Plan

> **Status:** Draft (research complete, execution pending)
> **Owner:** `aioffice` (research) → `matt@appyhourlabs.com` (execution)
> **Tracks incident:** [`DOCS/incidents/2026-04-27-launchagent-plist-secret-exposure.md`](incidents/2026-04-27-launchagent-plist-secret-exposure.md)
> **OpenClaw version researched:** `2026.4.25 (aa36ee6)`

---

## Why this exists

The 2026-04-27 plist exposure was the visible tip of a wider plaintext
problem. `openclaw secrets audit` reports **27 `PLAINTEXT_FOUND`
findings** across 22 files, plus 22 legacy OAuth residues. Surface map:

| Surface | File pattern | Count | Mitigated? |
|---|---|---|---|
| Per-agent auth profiles (Anthropic Claude Code tokens) | `~/.openclaw/agents/<agent>/agent/auth-profiles.json` | 11 | ❌ |
| Per-agent generated model providers (Google API keys) | `~/.openclaw/agents/<agent>/agent/models.json` | 11 | ❌ |
| OpenClaw env file (Gemini/Anthropic/OpenAI/Brave keys) | `~/.openclaw/.env` | 4 | ❌ |
| LaunchAgent plist (full credential bundle) | `~/Library/LaunchAgents/ai.openclaw.gateway.plist` | n/a (separate surface) | ⚠️ Hardened to `600`; secrets still embedded |

File perms across `.env`, `auth-profiles.json`, and `models.json` are
already `600`, which limits exposure to local processes running as
`aioffice` — but that is the same threat surface that the
2026-03-13 lancedb-pro malicious-package incident exercised.

## What OpenClaw supports

OpenClaw 2026.4.25 ships a first-class secrets system: **SecretRefs**
plus a **`secrets.providers`** registry. Three provider types:

| Provider type | Where the secret actually lives | Verdict for this fleet |
|---|---|---|
| `env` | Shell / launchd / systemd environment | ❌ Same problem we have today (plist env vars) |
| `file` | A single JSON file (e.g., `~/.openclaw/secrets.json`) | ✅ Single chokepoint, easy to lock to `600` |
| `exec` | Output of a trusted binary (1Password `op`, `vault`, `sops`, macOS `security`) | ✅ Strongest — secrets never sit on disk in plaintext |

We **already have** `secrets.providers.default` configured as a `file`
provider in `~/.openclaw/openclaw.json`:

```json
{
  "secrets": {
    "providers": {
      "default": {
        "source": "file",
        "path": "/Users/aioffice/.openclaw/secrets.json",
        "mode": "json",
        "timeoutMs": 5000,
        "maxBytes": 65536
      }
    }
  }
}
```

A `auth-profiles.json.pre-secretref-20260402-204835` backup file
indicates `openclaw secrets configure` was run at least once on
2026-04-02, but the migration was not completed across the fleet.

## Resolution model (worth knowing before we run anything)

- SecretRefs are resolved into an **in-memory snapshot** at gateway
  startup / `secrets reload`. Hot request paths never re-resolve.
- Activation is **fail-fast**: if an active SecretRef can't be
  resolved at startup, the gateway refuses to start.
- `secrets apply` is **one-way**: it scrubs plaintext from
  `auth-profiles.json`, `models.json`, and `.env` after a successful
  preflight. There is no rollback file containing old plaintext values.
- `gateway.auth.token` SecretRefs are **inactive** while
  `OPENCLAW_GATEWAY_TOKEN` is set in the gateway's environment — i.e.,
  while it remains in the plist, the SecretRef can't take over.

## Recommended migration path

Two viable paths. Option A is the minimum-viable hardening that uses
only what's already configured; Option B is the stronger end-state.

### Option A — Finish the file-provider migration (lower risk)

Centralise every plaintext secret into the already-configured
`~/.openclaw/secrets.json` (one file, `600`, no changes to launchd or
package installs).

1. **Stop the gateway briefly.** `openclaw gateway stop`.
2. **Run the configure flow** (interactive, requires a TTY):

   ```bash
   openclaw secrets configure
   ```

   - Picks targets across `openclaw.json` and the per-agent
     `auth-profiles.json` files.
   - Generates a plan, runs preflight, optionally applies.
3. **Repeat per-agent** for each agent listed in the audit (use
   `--agent <id>` to scope). Agents to migrate: `main`, `cfo`, `content`,
   `cto`, `dev`, `doc`, `manager`, `product`, `qa`, `sdr`, `security`.
4. **Migrate `~/.openclaw/.env`** — this is automatic when the
   apply plan covers the keys living in there
   (`scrubEnv` is on by default).
5. **Reload runtime:** `openclaw secrets reload`.
6. **Verify:** `openclaw secrets audit --check` should exit `0`.

**Residual exposure after Option A:**

- `~/.openclaw/secrets.json` is plaintext at rest (mode `600`).
- Plist env vars (`SLACK_*`, `OPENCLAW_GATEWAY_TOKEN`, etc.) are still
  embedded — the file-provider migration does not touch the launchd
  plist. See "Plist remediation" below.

### Option B — exec provider via 1Password CLI (stronger)

Secrets live only in 1Password; `op read` is invoked at activation /
reload time.

1. **Install `op`:** `brew install --cask 1password-cli`. Confirm
   `op --version` and sign in: `eval "$(op signin)"`.
2. **Create a 1Password vault** (e.g., `OpenClaw`) and add items for:
   `OpenClaw Anthropic API Key`, `... OpenAI API Key`,
   `... Gemini API Key`, `... Brave API Key`,
   `... Slack Bot Token`, `... Slack App Token`,
   `... Gateway Token`, `... Supabase Anon`, `... EvalPal API Key`,
   `... Nano Banana` (and Pro).
3. **Add an exec provider per credential** in `openclaw.json`
   (literal example from OpenClaw docs):

   ```json5
   {
     secrets: {
       providers: {
         onepassword_openai: {
           source: "exec",
           command: "/opt/homebrew/bin/op",
           allowSymlinkCommand: true,
           trustedDirs: ["/opt/homebrew"],
           args: ["read", "op://OpenClaw/OpenAI API Key/password"],
           passEnv: ["HOME"],
           jsonOnly: false
         }
       }
     }
   }
   ```

4. **Re-run `openclaw secrets configure`** and select the new exec
   providers when prompted.
5. **`openclaw secrets apply --from <plan> --allow-exec`**
   (exec providers are gated behind `--allow-exec` on both dry-run and
   write).
6. **`openclaw secrets reload`** and re-audit.

**Caveat for daemon contexts:** `op` typically requires a desktop
session for biometric unlock. For a headless daemon you'll either need
a 1Password service-account token (`OP_SERVICE_ACCOUNT_TOKEN`) — itself
a long-lived secret that needs a home — or to use `op` with a session
token sourced from the macOS keychain. Treat this as a sub-decision
before committing to Option B end-to-end.

### Plist remediation (separate from the JSON migration)

`openclaw gateway install` writes the plist with managed env keys
listed under `OPENCLAW_SERVICE_MANAGED_ENV_KEYS`. Even after Option A
or B, the plist will keep re-embedding env vars on every reinstall.
Open questions for upstream (see [draft issue](openclaw-issue-gateway-install-token-embed.md)):

- Is there an `openclaw.json` knob to make `gateway install` emit a
  plist **without** managed env vars (relying instead on SecretRef
  resolution at runtime)?
- For `OPENCLAW_GATEWAY_TOKEN` specifically, is the supported pattern
  to set `gateway.auth.token` as a SecretRef and **omit** the env var
  entirely?

Until upstream confirms, the manual mitigation is:

1. Leave the plist hardened to `600` (already done 2026-04-27 21:11 ET).
2. After every `openclaw gateway install` invocation, re-check the
   plist and remove `OPENCLAW_GATEWAY_TOKEN` and any channel tokens
   from `EnvironmentVariables` if a SecretRef path is configured.
3. Track this as a manual step in [`RUNBOOKS/cron-troubleshooting.md`](../RUNBOOKS/cron-troubleshooting.md).

## Recommendation

Do **Option A first** (this week) — it's safe, uses what's already
configured, and clears the audit findings. Schedule **Option B** as a
follow-up project once we've decided how to source the 1Password
service-account token (or Vault / sops).

## Open questions

1. Where does the 1Password service-account token live if we adopt
   Option B? Keychain via `security find-generic-password` and a
   bootstrap exec provider?
2. Do we want to put the gateway token in a SecretRef *and* remove it
   from the plist env, or accept the env-var path while keeping the
   plist `600`?
3. Should `~/.openclaw/secrets.json` also be encrypted at rest (sops or
   age) under Option A, or is `600` enough for our threat model?

## Validation criteria

When the migration is complete, all of these should be true:

- `openclaw secrets audit --check` exits `0`.
- `openclaw security audit --json` shows no plaintext credential
  findings.
- `~/Library/LaunchAgents/ai.openclaw.gateway.plist` contains either
  zero or a strictly enumerated set of managed env vars (and is `600`).
- Gateway restart with `openclaw gateway restart` completes without
  prompting for any credential.
- All cron-driven agents successfully run a turn after restart
  (`scripts/rerun.sh all` per the operations runbook).

## References

- [Secrets management](https://docs.openclaw.ai/gateway/secrets)
- [CLI: secrets](https://docs.openclaw.ai/cli/secrets)
- [Security](https://docs.openclaw.ai/gateway/security)
- [SecretRef Credential Surface](https://docs.openclaw.ai/reference/secretref-credential-surface)
- [Incident: 2026-04-27 plist secret exposure](incidents/2026-04-27-launchagent-plist-secret-exposure.md)
- [Upstream issue draft: gateway install --force does not strip embedded gateway token](openclaw-issue-gateway-install-token-embed.md)

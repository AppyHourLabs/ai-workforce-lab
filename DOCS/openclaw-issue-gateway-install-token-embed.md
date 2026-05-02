# Upstream Issue Draft — `gateway install --force` does not honor `secrets.providers` for `OPENCLAW_GATEWAY_TOKEN`

> **Audience:** OpenClaw maintainers (file at https://github.com/openclaw/openclaw — or wherever the canonical issue tracker lives).
> **Reporter:** `matt@appyhourlabs.com` (Appy Hour Labs / AI Workforce Lab)
> **OpenClaw version:** `2026.4.25 (aa36ee6)` on macOS 25.3 / launchd
> **Status:** Draft — Matt to file. Do not autonomously file (Phase A guardrail).

---

## Title

`gateway install --force` does not strip embedded `OPENCLAW_GATEWAY_TOKEN`; doctor surfaces a remediation that the install command itself does not perform

## Summary

`openclaw doctor` reports:

> Gateway service config issue: Gateway service embeds `OPENCLAW_GATEWAY_TOKEN` and should be reinstalled. (Run `openclaw gateway install --force` to remove embedded service token.)

Running the recommended command keeps the LaunchAgent loaded and
running, but the regenerated plist still contains
`OPENCLAW_GATEWAY_TOKEN` in `<key>EnvironmentVariables</key>`, and
`openclaw doctor` continues to report the same finding. The
remediation surfaced to operators does not match the install command's
actual behavior on macOS / launchd.

## Reproduction

1. Install OpenClaw and complete onboarding so the LaunchAgent exists
   (`ai.openclaw.gateway`).
2. Configure `secrets.providers` in `openclaw.json` (we use a `file`
   provider; the same outcome is expected for `exec` providers).
3. Run `openclaw doctor`. Observe under `Gateway service config`:

   ```
   - Gateway service embeds OPENCLAW_GATEWAY_TOKEN and should be
     reinstalled. (Run `openclaw gateway install --force` to remove
     embedded service token.)
   ```

4. Run the recommended command:

   ```bash
   openclaw gateway install --force
   ```

5. Inspect the regenerated plist:

   ```bash
   plutil -p ~/Library/LaunchAgents/ai.openclaw.gateway.plist | grep -i OPENCLAW_GATEWAY_TOKEN
   ```

6. The token is still present. `openclaw doctor` continues to report
   the same finding.

## Observed

- Plist `EnvironmentVariables` continues to include
  `OPENCLAW_GATEWAY_TOKEN`, plus the full set declared in
  `OPENCLAW_SERVICE_MANAGED_ENV_KEYS` (Slack tokens, Anthropic /
  OpenAI / Gemini API keys, Supabase keys, etc.). On macOS the plist
  was created with default mode `0644` (limited only by
  `~/Library` mode `0700`).
- `gateway install --help` exposes `--token <token>` for explicit
  injection but no flag for "do not embed; resolve via `secrets`".

## Expected

One of the following, ideally documented under
[`openclaw gateway install`](https://docs.openclaw.ai/cli/gateway):

- `gateway install --force` removes `OPENCLAW_GATEWAY_TOKEN` from
  `EnvironmentVariables` whenever `gateway.auth.token` (or another
  active auth surface) has a configured SecretRef. The
  doctor remediation matches the install behavior.
- A documented flag, e.g., `gateway install --no-embed-secrets` or
  `--managed-env-keys=none`, so operators can opt the plist out of
  embedding when SecretRefs are configured. Per [Secrets
  management](https://docs.openclaw.ai/gateway/secrets), the
  `gateway.auth.token` SecretRef is documented as inactive while the
  env var is set; this means the install command is currently the
  thing forcing the SecretRef into the inactive state.
- At minimum, plist write should default to mode `0600`. Today the
  file is created `0644`, which makes the embedded-secret behavior
  more dangerous than it needs to be.

## Why this matters

- The doctor message explicitly tells operators to use a command that
  does not, in practice, perform the remediation it advertises.
- The plist embeds the full `OPENCLAW_SERVICE_MANAGED_ENV_KEYS` set on
  every install, so any subsequent `gateway install`/`install --force`
  re-creates a multi-credential plaintext file even after operators
  have completed `openclaw secrets configure`/`apply`.
- For deployments using SecretRefs, the env-var path on the plist
  unconditionally wins (`gateway.auth.token` SecretRef is inactive when
  `OPENCLAW_GATEWAY_TOKEN` is in env), which silently neutralizes the
  SecretRef migration for the gateway token specifically.

## Suggested follow-ups

1. Tighten plist file mode to `0600` on macOS regardless of other
   changes.
2. Skip `OPENCLAW_GATEWAY_TOKEN` (and ideally any managed env key with
   a configured SecretRef) when generating the plist's
   `EnvironmentVariables` block, so the SecretRef can take effect.
3. Update the doctor message to reflect actual install behavior, or
   wire the install path to honor the recommendation it surfaces.

## Environment

- OpenClaw `2026.4.25 (aa36ee6)`
- macOS Sequoia (Darwin 25.3.0), Apple Silicon
- Node `v22.x` (Homebrew `node@22`)
- Daemon: `ai.openclaw.gateway` LaunchAgent (per
  `openclaw gateway install --force`)
- Config: `~/.openclaw/openclaw.json` with `secrets.providers.default`
  pre-configured (`file` provider), file mode `0600`.

## Related context

- [Incident: 2026-04-27 plist secret exposure](incidents/2026-04-27-launchagent-plist-secret-exposure.md) (downstream impact for our deployment)
- [Migration plan](openclaw-secrets-migration-plan.md)

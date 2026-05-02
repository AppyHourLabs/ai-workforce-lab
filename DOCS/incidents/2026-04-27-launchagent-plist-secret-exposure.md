# Incident: OpenClaw LaunchAgent Plist Storing Multi-Provider Secrets in Plaintext

> **Severity:** SEV-3 — Credential storage misconfiguration; no confirmed exfiltration
> **Discovered:** 2026-04-27 21:09 ET
> **Discovered During:** Routine OpenClaw gateway status check (Cursor session, under `matt@appyhourlabs.com` direction)
> **Status:** Mitigated (perms hardened); credential rotation pending
> **Type:** Secrets-on-disk / supply-chain-adjacent credential exposure

---

## Summary

The OpenClaw gateway LaunchAgent plist at
`~/Library/LaunchAgents/ai.openclaw.gateway.plist`
embeds **API keys for 9+ external providers in plaintext** under
`<key>EnvironmentVariables</key>`, written by `openclaw gateway install`
itself. The file was on disk with mode `-rw-r--r--` (world-readable at
the inode level), although traversal was constrained by `~/Library`
being mode `700`.

Running `openclaw gateway install --force` (which `openclaw doctor`
explicitly recommends to "remove embedded service token") **did not
remove** the embedded `OPENCLAW_GATEWAY_TOKEN` and **rewrote** the plist
with the full secret set. The doctor warning therefore tracks a real
defect that the supplied remediation does not resolve.

## Impact

- **Exposed credentials** (key names only — values redacted from this
  report):
  - `SLACK_BOT_TOKEN`
  - `SLACK_APP_TOKEN`
  - `ANTHROPIC_API_KEY`
  - `OPENAI_API_KEY`
  - `GEMINI_API_KEY`
  - `NANO_BANANA_API_KEY`
  - `NANO_BANANA_PRO_API_KEY`
  - `BRAVE_API_KEY`
  - `EVAL_API_KEY`
  - `SUPABASE_ANON_KEY` (and `VITE_SUPABASE_ANON_KEY`)
  - `OPENCLAW_GATEWAY_TOKEN`
- **Exposure window:** approximately 2026-02-21 (initial OpenClaw
  install, see [`TASKS/0013-openclaw-install-slack-connect.md`](../../TASKS/0013-openclaw-install-slack-connect.md))
  through 2026-04-27 — ~9 weeks.
- **Read scope:** Limited to local processes running as user `aioffice`
  (parent `~/Library` directory mode `700` blocks other-user reads).
  This still includes any npm package, browser extension, local CLI
  tool, or compromised dev dependency running under that user — a class
  of attack we have already encountered (see
  [`TASKS/2026-03-13-security-incident-lancedb-pro.md`](../../TASKS/2026-03-13-security-incident-lancedb-pro.md)
  and [`POLICIES/package-deny-list.md`](../../POLICIES/package-deny-list.md)).
- **No confirmed exfiltration.** No anomalous network traffic
  investigation has been completed yet (see Action Items).

## Detection

During a `openclaw gateway status` check, the CLI reported:

> Service config issue: Gateway service embeds `OPENCLAW_GATEWAY_TOKEN`
> and should be reinstalled.

Reading the plist to validate the fix revealed the broader plaintext
secret set under `EnvironmentVariables`, declared explicitly via
`OPENCLAW_SERVICE_MANAGED_ENV_KEYS`:

```
ANTHROPIC_API_KEY,BRAVE_API_KEY,EVAL_API_KEY,GEMINI_API_KEY,
NANO_BANANA_API_KEY,NANO_BANANA_PRO_API_KEY,OPENAI_API_KEY,
OPENCLAW_GATEWAY_TOKEN,SLACK_APP_TOKEN,SLACK_BOT_TOKEN,
SUPABASE_ANON_KEY,SUPABASE_URL,VITE_SUPABASE_ANON_KEY,VITE_SUPABASE_URL
```

This is OpenClaw's documented "managed env keys" mechanism — the daemon
intentionally writes these into the plist so launchd can hand them to
the gateway process at boot. The mechanism is by design; the security
posture is not.

## Guardrail Reference

This incident sits adjacent to two AGENTS.md guardrails:

- **"No API keys or tokens in the repo. Ever."** — These secrets are
  not in the repo, but the same intent (keep secrets out of files
  readable by anything that wanders by) applies to operational state on
  disk.
- **Phase A safety posture** — Several of the exposed tokens
  (`SLACK_BOT_TOKEN`, `OPENAI_API_KEY`, `ANTHROPIC_API_KEY`) directly
  enable outbound side-effects (posts, model spend, third-party API
  calls) and therefore matter for the Phase A blast-radius model.

## Mitigation Applied

1. **Plist permissions hardened (2026-04-27 21:11 ET):**
   `chmod 600 ~/Library/LaunchAgents/ai.openclaw.gateway.plist`.
   Verified `-rw-------`.
2. **Wider exposure characterized (2026-04-28).**
   `openclaw secrets audit --json` reports **27 `PLAINTEXT_FOUND`**
   findings across 22 files (per-agent `auth-profiles.json` and
   `models.json`, plus `~/.openclaw/.env`) in addition to the plist.
   Per-agent files are already mode `600`; exposure scope matches the
   plist (local processes running as `aioffice`). Full enumeration
   and migration path captured in
   [`DOCS/openclaw-secrets-migration-plan.md`](../openclaw-secrets-migration-plan.md).
3. **Runbook updated (2026-04-28).**
   [`RUNBOOKS/cron-troubleshooting.md`](../../RUNBOOKS/cron-troubleshooting.md#plist-secrets-check-post-install--post-repair)
   now includes a "Plist Secrets Check" section to run after every
   `gateway install` / `--force` / repair.
4. **Upstream issue drafted (2026-04-28).**
   [`DOCS/openclaw-issue-gateway-install-token-embed.md`](../openclaw-issue-gateway-install-token-embed.md)
   captures the `gateway install --force` defect for Matt to file
   upstream (Phase A: not auto-filed).

## Action Items (Pending)

| #  | Action | Owner | Status |
|----|--------|-------|--------|
| 1  | `chmod 600` the plist | `aioffice` (Cursor) | ✅ DONE 2026-04-27 |
| 2  | Rotate Slack bot/app tokens; reissue and update OpenClaw auth store | `matt@appyhourlabs.com` | ⏳ TODO |
| 3  | Rotate Anthropic, OpenAI, Gemini, Nano Banana / Pro API keys; reissue | `matt@appyhourlabs.com` | ⏳ TODO |
| 4  | Rotate Brave search API key | `matt@appyhourlabs.com` | ⏳ TODO |
| 5  | Rotate EvalPal API key | `matt@appyhourlabs.com` | ⏳ TODO |
| 6  | Rotate Supabase anon keys (acknowledged: low sensitivity, but exposed) | `matt@appyhourlabs.com` | ⏳ TODO |
| 7  | Rotate `OPENCLAW_GATEWAY_TOKEN` (`openclaw gateway rotate-token` or equivalent) | `matt@appyhourlabs.com` | ⏳ TODO |
| 8  | Identify OpenClaw-supported secret backend (SecretRefs / `secrets.providers`) and document migration plan | `aioffice` | ✅ DONE 2026-04-28 — see [`openclaw-secrets-migration-plan.md`](../openclaw-secrets-migration-plan.md) |
| 9  | Execute the migration plan (Option A — file provider, then Option B — exec/1Password) | `matt@appyhourlabs.com` + `aioffice` | ⏳ TODO |
| 10 | Re-validate gateway probe after rotation + secrets migration | `aioffice` | ⏳ TODO |
| 11 | Review last 9 weeks of egress logs / Slack audit for anomalous activity tied to any rotated token | `matt@appyhourlabs.com` | ⏳ TODO |
| 12 | File upstream OpenClaw issue: `gateway install --force` does not honor its own doctor recommendation re: embedded gateway token | `matt@appyhourlabs.com` | 📝 Draft ready ([`openclaw-issue-gateway-install-token-embed.md`](../openclaw-issue-gateway-install-token-embed.md)); Matt to file (Phase A) |
| 13 | Add a runbook step to `RUNBOOKS/cron-troubleshooting.md` documenting plist-secrets check | `aioffice` | ✅ DONE 2026-04-28 — see [Plist Secrets Check](../../RUNBOOKS/cron-troubleshooting.md#plist-secrets-check-post-install--post-repair) |

## Lessons Learned

1. **"Embedded token" warnings deserve a full-plist read, not just
   trust-the-fix.** OpenClaw's doctor specifically called out the
   gateway token. Reading the file revealed the actual scope was 10x
   larger.
2. **`gateway install --force` is not a remediation for embedded-token
   warnings on the version we run (2026.4.25).** It rewrites the plist
   with the same env-var pattern. Future remediation must use a
   different mechanism (likely keychain-backed config, pending #8).
3. **File mode and parent-dir mode interact.** The plist itself was
   `644`, but `~/Library` being `700` constrained read scope. We should
   not rely on the parent-dir control alone — secrets files should be
   `600` regardless.
4. **The 2026-03-13 lancedb-pro incident is the realistic threat
   model.** A successfully installed malicious npm package running as
   `aioffice` would have read this plist trivially. The deny-list
   helped; defense-in-depth on secret storage would have helped more.

## References

- AGENTS.md — Guardrails section
- [`POLICIES/package-deny-list.md`](../../POLICIES/package-deny-list.md)
- [`TASKS/2026-03-13-security-incident-lancedb-pro.md`](../../TASKS/2026-03-13-security-incident-lancedb-pro.md)
- [`TASKS/0013-openclaw-install-slack-connect.md`](../../TASKS/0013-openclaw-install-slack-connect.md)
- [`DOCS/openclaw-workspace-reference.md`](../openclaw-workspace-reference.md)
- [`DOCS/incidents/2026-02-23-gateway-auth-outage-rca.md`](2026-02-23-gateway-auth-outage-rca.md)

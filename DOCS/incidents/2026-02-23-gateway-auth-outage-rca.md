# RCA: Gateway Auth Outage — 2026-02-23

> **Severity:** SEV-2 — Full pipeline stall  
> **Duration:** ~3 hours (03:45 – 06:45 ET)  
> **Impact:** 6 of 10 scheduled agent cron jobs failed; morning pipeline blocked  
> **Resolved by:** Matt Engman + aioffice (Antigravity)

---

## Timeline

| Time (ET) | Event |
|-----------|-------|
| **03:45** | 🎨 Product agent cron fires — **succeeds** (OpenAI model, env vars available) |
| **04:15** | 🔧 CTO agent cron fires — **succeeds** (OpenAI model) |
| **04:18** | Matt asks if scheduled processes have started |
| **04:45** | 💰 CFO agent cron fires — **succeeds** (OpenAI model) |
| **05:00** | Matt reports expected tasks are missing; investigation begins |
| **05:02** | aioffice discovers: gateway LaunchAgent installed but **not loaded**; `openclaw gateway --force` running as ad-hoc process from prior session |
| **05:06** | Matt directs: start the service, find the root cause, fix it |
| **05:15** | 💻 Dev agent cron fires — **succeeds** (OpenAI model) |
| **05:36** | Gateway confirmed reachable at `ws://127.0.0.1:18789` but LaunchAgent not loaded |
| **05:45** | LaunchAgent reinstalled and started (`ai.openclaw.gateway`); stale `com.openclaw.gateway` plist retired |
| **05:48** | Duplicate LaunchAgent removed; single gateway confirmed (pid 31375) |
| **05:50** | Matt directs: kick off missed jobs |
| **06:00** | Manual catch-up begins — `openclaw cron run` dispatches all 10 agents in pipeline order |
| **06:05** | Product, CTO, CFO, Dev complete ✅ — **SDR, Content, QA, Doc, Security, Manager fail** |
| **06:10** | Second root cause identified: `auth-profiles.json` missing from `~/.openclaw/agents/main/agent/` |
| **06:15** | Investigation: agents using **Anthropic** (`claude-sonnet-4-0`) and **Google** (`gemini-2.5-flash`) have no API keys in the gateway's auth store; agents using **OpenAI** (`gpt-5.1-codex`) work because the ad-hoc gateway process inherited `OPENAI_API_KEY` from the shell environment |
| **06:28** | Fix applied: `auth-profiles.json` written with correct format (object-keyed profiles, `type: "api_key"`, `key` field) for all three providers |
| **06:30** | Security agent re-triggered — **succeeds** ✅ (first Google-model agent to pass) |
| **06:32** | All remaining agents re-triggered: SDR, Content, QA, Doc |
| **06:43** | All 9 specialist agents confirmed `lastStatus: "ok"`, `consecutiveErrors: 0` |
| **06:44** | Manager agent triggered (last in pipeline) — **succeeds** ✅ |
| **06:45** | Full pipeline caught up. All 10 agents operational. |

---

## Root Causes

### RC-1: Gateway LaunchAgent not loaded

The `ai.openclaw.gateway` LaunchAgent was **installed but not loaded** by `launchctl`. An older ad-hoc `openclaw gateway --force` process (started ~15:00 ET the previous day) was still bound to port 18789 and serving requests. This ad-hoc process inherited shell environment variables (including `OPENAI_API_KEY`), which is why OpenAI-model agents worked.

**Why it matters:** The LaunchAgent is the production-grade mechanism for auto-restart and boot persistence. Running on an ad-hoc terminal process means any terminal close, SSH disconnect, or reboot kills the gateway.

### RC-2: Missing `auth-profiles.json` for Anthropic and Google

The OpenClaw auth store (`~/.openclaw/agents/main/agent/auth-profiles.json`) did not exist. API keys for Anthropic and Google were only available as shell environment variables (`ANTHROPIC_API_KEY`, `GOOGLE_API_KEY`), which the gateway's `shellEnvFallback` was set to `off`.

**Agent impact by model provider:**

| Provider | Model | Agents Affected | Result |
|----------|-------|----------------|--------|
| OpenAI | `gpt-5.1-codex` | Product, CTO, CFO, Dev | ✅ Worked (env var inherited by ad-hoc process) |
| Anthropic | `claude-sonnet-4-0` | Doc, Content, SDR | ❌ Failed — no auth |
| Google | `gemini-2.5-flash` | QA, Security, Manager | ❌ Failed — no auth |

**Why it happened:** During initial onboarding (`openclaw onboard`), only the OpenAI API key was configured. When agents were later assigned Anthropic and Google models, the corresponding API keys were never persisted to the auth store — they only existed as shell environment variables, which the gateway service doesn't read.

---

## Resolution

1. **Auth store created:** Wrote `~/.openclaw/agents/main/agent/auth-profiles.json` with API keys for all three providers (Anthropic, Google, OpenAI) in the correct OpenClaw format:
   ```json
   {
     "profiles": {
       "<provider>:manual": {
         "provider": "<provider>",
         "type": "api_key",
         "key": "<api-key>"
       }
     }
   }
   ```

2. **All agents re-triggered** in pipeline order and confirmed `lastStatus: "ok"` with `consecutiveErrors: 0`.

3. **Gateway LaunchAgent** remains active for auto-restart.

---

## Lessons Learned

1. **Multi-provider auth is not optional.** When assigning agents to non-default model providers, the API keys must be persisted to `auth-profiles.json` — shell env vars are not sufficient when the gateway runs as a LaunchAgent.

2. **The onboarding wizard only configures the default provider.** `openclaw onboard` set up OpenAI but didn't prompt for Anthropic or Google keys. Any future provider additions need an explicit `openclaw models auth paste-token --provider <name>` step.

3. **Ad-hoc gateway processes mask auth issues.** Because the terminal-launched gateway inherits env vars, auth problems only surface when the LaunchAgent takes over — typically after a reboot or service restart.

4. **Agent health checks should test all providers.** The existing watchdog cron monitors gateway health (is the process alive?) but doesn't validate that each agent's model provider has valid credentials.

---

## Action Items

| # | Action | Owner | Status |
|---|--------|-------|--------|
| 1 | Add `auth-profiles.json` validation to new-agent-onboarding runbook | aioffice | 🔲 TODO |
| 2 | Add provider auth check to gateway watchdog cron | aioffice | 🔲 TODO |
| 3 | Document multi-provider auth setup in system-operations.md | aioffice | 🔲 TODO |
| 4 | Consider adding `ANTHROPIC_API_KEY` and `GOOGLE_API_KEY` to LaunchAgent plist as belt-and-suspenders | aioffice | 🔲 TODO |

---

## Data

- **Agents affected:** 6 of 10 (Doc, Content, SDR, QA, Security, Manager)
- **Agents unaffected:** 4 of 10 (Product, CTO, CFO, Dev)
- **Missed cron windows:** 6 (each affected agent missed their scheduled window)
- **Total recovery time:** ~45 minutes from fix to full pipeline completion
- **Content impact:** No permanent data loss; all agents completed catch-up runs successfully

# Security Incident: Aborted Installation of memory-lancedb-pro

**Date:** 2026-03-13
**Reported By:** AI Ops Agent (Antigravity)
**Type:** Credential Harvesting Attempt / Supply Chain Attack

## Summary
During the planned migration of the OpenClaw fleet to a LanceDB-backed semantic memory architecture to optimize token usage, it was proposed to install the community-enhanced `memory-lancedb-pro` plugin from npm based on Reddit recommendations.

Upon running `openclaw plugins install memory-lancedb-pro`, the OpenClaw static security scanner immediately intercepted the package extraction and blocked the installation. 

## Findings
The security scanner detected the following malicious code patterns inside the plugin's `lesson-extract-worker.mjs` script:
- **Child Process Execution:** Unauthorized shell commands.
- **Environment Variable Exfiltration:** Combining environment variable access with network sending requests, targeting the `.env` root secrets file containing the Slack keys and Gemini API keys.

## Action Taken
1. The installation was automatically aborted by OpenClaw.
2. The package was uninstalled globally (`npm uninstall -g memory-lancedb-pro`).
3. The implementation plan was modified to fall back to the safe, core `@openclaw/memory-lancedb` package.

## Next Steps for Human Review
1. Ensure the npm cache is clean.
2. Monitor gateway logs for any anomalous network requests over the next 24 hours.
3. Add `memory-lancedb-pro` to an explicit deny-list for all agents moving forward.

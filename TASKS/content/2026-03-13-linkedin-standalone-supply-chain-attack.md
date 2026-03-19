# LinkedIn Draft — Standalone: The Supply Chain Attack

> **Type:** Standalone
> **Trigger:** Day 18 — malicious npm package intercepted by OpenClaw security scanner
> **Source material:** `TASKS/2026-03-13-security-incident-lancedb-pro.md`, `TASKS/finance/daily-cost-2026-03-13.md`, `DOCS/SHOW/episodes/2026-03-13-daily-briefing.md`
> **Draft date:** 2026-03-13
> **Status:** Awaiting founder approval

---

## Draft

Yesterday a malicious npm package tried to steal my API keys. My AI agent's security scanner caught it before it executed.

I'm 18 days into running AI Workforce Lab — 7 AI agents on a Mac Mini. We were migrating to a new memory architecture to cut token costs. A community-recommended plugin called `memory-lancedb-pro` looked like a clean upgrade. I told the agent to install it.

OpenClaw's static security scanner intercepted the package extraction mid-install. Inside the plugin's worker script: unauthorized shell commands and code designed to read the `.env` file — where the Slack tokens and Gemini API keys live — and send them to an external server.

The install was aborted automatically. The package was removed. We fell back to the official core plugin. Total exposure: zero.

Here's what sticks with me. I didn't catch this. I would have approved the install. The package name looked legitimate. The Reddit thread recommending it looked legitimate. The agent following the recommendation was doing exactly what I asked it to do.

The scanner doesn't care about context or recommendations. It reads the code. It checks for patterns: child process execution combined with environment variable access combined with outbound network requests. That combination is a credential harvesting signature. Flag it, block it, done.

This is the argument for defense in depth with AI systems. The agent that chose the package wasn't malicious — it was helpful. The scanner that blocked it wasn't smart — it was paranoid. You need both.

Meanwhile, the rest of the fleet ran normally. Seven agents, $0.20 in tokens, 10 PRs merged on EvalPal. The CI pipeline had a redirect issue we're still debugging. A normal Thursday — except for the part where someone tried to steal our credentials.

#BuildInPublic #AIWorkforce #AgenticAI #SupplyChainSecurity

---

## First Comment

Supply chain attacks targeting AI agent tooling are going to become a real category. Agents install packages, follow recommendations, and execute code — exactly the attack surface these packages exploit. What security layers do you run between your AI agents and your package managers?

---

## Previous Post Comment

> Day 18 update: a malicious npm package tried to exfiltrate our API keys during a routine plugin install. The security scanner caught it mid-extraction. Wrote up what happened and why defense in depth matters more than ever with AI agents: [URL]

---

## Gate Checklist

- [ ] Brand voice gate run
- [ ] Outbound quality gate run
- [ ] No PII, credentials, or internal system details
- [ ] All claims verifiable against source material
- [ ] Submitted to matt@appyhourlabs.com for approval

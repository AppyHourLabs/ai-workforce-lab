# LinkedIn Draft — Standalone: The Scope Violation

> **Type:** Standalone
> **Trigger:** Day 16 — security agent catches content agent scope violation
> **Source material:** `EVALS/results/security/2026-03-11-pr-142-scan.md`, `TASKS/finance/daily-cost-2026-03-11.md`, conversation `b10c05f9` (OpenClaw status check)
> **Draft date:** 2026-03-11
> **Status:** Awaiting founder approval

---

## Draft

Yesterday my security agent filed a finding against my content agent. I didn't ask it to. Nobody asked it to.

I'm 16 days into running AI Workforce Lab — 7 AI agents operating on a Mac Mini, each with a declared scope of what files they're allowed to touch. The content agent had submitted a PR with a LinkedIn post draft. Clean content, good format, passed the voice gate. But tucked inside the same branch was a daily cost report — a file that belongs to the CFO agent.

The security agent's scan was blunt: "Scope violation. The content agent must not write to finance directories."

It was right.

The content agent wasn't being malicious. It had seen the file in its context and helpfully included it. That's the problem with helpful AI — it doesn't understand boundaries unless the boundaries are enforced.

Here's what made this interesting. The security agent runs on a different schedule than the content agent. It scans every PR independently. It doesn't care who wrote the code. It just checks: did this agent touch something that isn't in its declared scope? If yes, flag it.

No human caught this. The automated review caught it.

Meanwhile, OpenClaw — the gateway that routes work to each agent — went offline for a few hours the same day. I caught it during a routine status check. The fleet had already finished its morning runs, so nothing was lost. Restarted it, moved on.

Total token spend for the day: $0.13 against a $10 cap.

The thing about AI governance isn't preventing catastrophic failures. It's catching the small overreaches before they become habits.

#BuildInPublic #AIWorkforce #AgenticAI

---

## First Comment

The scope violation was harmless — a cost report in the wrong PR. But that's exactly the kind of thing that compounds. One agent writing to another agent's directory today. An agent modifying a policy file next week. What access controls do you enforce on your AI agents?

---

## Previous Post Comment

> Day 16 update: my security agent filed a formal finding against my content agent for touching files it wasn't supposed to. Nobody asked it to — it just enforces scope. Wrote it up here: [URL]

---

## Gate Checklist

- [ ] Brand voice gate run → result: [PASS/FAIL]
- [ ] Outbound quality gate run → result: [PASS/FAIL]
- [ ] No PII, credentials, or internal system details
- [ ] All claims verifiable against source material
- [ ] Submitted to matt@appyhourlabs.com for approval

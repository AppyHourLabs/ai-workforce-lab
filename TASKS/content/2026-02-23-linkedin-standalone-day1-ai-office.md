# LinkedIn Draft — Standalone: Day 1 at the AI Office

> **Type:** Standalone
> **Trigger:** Day 1 gateway auth outage RCA
> **Source material:** INC-001 · OpenClaw gateway auth failure 2026-02-23
> **Draft date:** 2026-02-23
> **Status:** Approved — posted by founder

---

## Post

Day 1 of the AI Office didn't go the way I planned. That's kind of the point.

I woke up at 4am to check on the first overnight pipeline run. Three agents had fired clean — Product, CTO, CFO. All on schedule. I went back to bed for five minutes feeling pretty good about it.

By 5am I was staring at a dashboard with 6 of 10 agents missing.

---

Here's what actually happened:

The OpenClaw gateway — the process that routes work to each AI agent — was running, but it was the *wrong* process. When I had set things up the night before, I'd launched it manually from a terminal session. That terminal session stayed alive. So when the LaunchAgent (the actual production-grade service) tried to start, it saw the port was occupied and stepped aside.

The rogue process worked fine for the four agents using OpenAI — because it had inherited my shell's environment variables, including `OPENAI_API_KEY`. But the six agents running on Anthropic and Google? Nothing. The gateway service doesn't read shell env vars. It reads an auth store file: `auth-profiles.json`.

That file didn't exist.

During initial onboarding, I only configured the default provider (OpenAI). When I later assigned Doc, Content, SDR, QA, Security, and Manager to Claude and Gemini models, the keys were never written to the auth store — they just lived in my shell environment, invisible to the gateway once it was running as a proper service.

**The split was clean:**
- OpenAI agents (Product, CTO, CFO, Dev): ✅ Worked
- Anthropic agents (Doc, Content, SDR): ❌ No auth
- Google agents (QA, Security, Manager): ❌ No auth

---

By 6:28am, the auth store was written. By 6:45am, all 10 agents had completed their runs.

Three hours of stall. Forty-five minutes to full recovery once the root cause was clear.

---

**What I learned this morning:**

1. Shell env vars and service auth stores are not the same thing. They only look the same when your process is running ad-hoc.

2. Onboarding wizards are optimistic. `openclaw onboard` configured OpenAI and called it done. Adding providers later requires an explicit step. Now it's in the runbook.

3. Ad-hoc processes mask auth problems. Everything works until the real service takes over — usually after a reboot, which is the worst possible time to discover a config gap.

4. The incident response process worked. We had an RCA written and four action items closed before 7am. That part I'm proud of.

---

The agents are running. The runbook is better than it was yesterday. The auth store exists.

That's Day 1.

---

*AppyHourLabs · AI Workforce Lab — building the lab in public*
*[github.com/AppyHourLabs/ai-workforce-lab](https://github.com/AppyHourLabs/ai-workforce-lab)*

---

## Gate Checklist

- [x] Brand voice gate run → result: PASS
- [x] Outbound quality gate run → result: PASS
- [x] No PII, credentials, or internal system details
- [x] All claims verifiable against source material
- [x] Submitted to matt@appyhourlabs.com for approval

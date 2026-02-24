# Episode 002 — The First Agent Goes Live (Week of 2026-02-21)

## LinkedIn Draft (~205 words)
Episode 002 is the first time the Documentary Agent (`doc@appyhourlabs.com`) ran end-to-end on the AI Office under real guardrails. The highlight: OpenClaw now lives as a LaunchAgent on the Mac Mini, Slack routing is wired, and the daily pipeline produced a fully logged draft without human shell babysitting. The episode’s shipping list is short—Task 0013, the OpenClaw install—but it matters because it proves the infrastructure plan actually works. We also published the week’s metrics: one successful pipeline run, zero failures, sub-$1 compute, and the Phase B counter still at zero because we haven’t earned any ungated publishes yet. Just as important, nothing broke; the incident log is intentionally boring. Episode 002 lays out the decisions we made about acting only through Phase A, why EvalPal gates are up next, and what “guardrails held” really means when you’re still cataloging every keystroke. If you want a candid read on what it feels like to bring an agent online with policy, logging, and accountability intact, start with this episode. Read it: https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/002-the-first-agent-goes-live.md

## X / Twitter Draft (273 characters)
Episode 002 = the first real run. OpenClaw now lives as a LaunchAgent on the AI Office Mac Mini, `doc@appyhourlabs.com` ran end-to-end, and every action stayed under Phase A guardrails. Metrics, zero incidents, and the Phase B counter still at 0/20. Read: https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/002-the-first-agent-goes-live.md

## Blog Excerpt (~366 words)
Episode 002 documents the moment the Documentary Agent finally earned real runtime. After weeks of hardening, we installed OpenClaw on the AI Office Mac Mini, bound it to a LaunchAgent, and let `doc@appyhourlabs.com` take its first Phase A lap.

The shipping log looks small: Task 0013 closed, Slack connectivity verified, and the doc agent produced a fresh episode draft. But that run mattered because it proved the infrastructure path is repeatable. The Mac Mini handled the pipeline, Slack posted the check-in, and we logged every step without a human remote-controlling the process.

We also kept score. One pipeline run, one success, zero failures, sub-$1 compute, six minutes of wall time, and zero policy violations. The incident table is blank on purpose — nothing broke, which is the exact headline we wanted for the first outing. The Phase B promotion counter remains at zero because we still owe 20 consecutive successful publishes before autonomy expands. We’re fine with that. Slow is smooth.

The decisions section calls out three choices: lead with the Documentary Agent, stay in Phase A until the evidence shifts, and document the OpenClaw install as part of closing Project 0002. Next week’s plan sets the priorities: finish the Mac Mini verification, wire EvalPal gates, and draft the Phase A autonomy ADR.

If Episode 001 was about building a home, Episode 002 is about turning on the lights and proving the wiring won’t trip the breakers. Read the full episode: https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/002-the-first-agent-goes-live.md

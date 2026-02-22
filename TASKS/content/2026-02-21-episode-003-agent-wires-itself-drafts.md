# Episode 003 — Agent Wires Itself (Week of 2026-02-21)

## LinkedIn Draft (~210 words)
Episode 003 is the handoff moment where the Documentary Agent stopped asking humans to run `gh` for it. We wired GitHub tooling, fixed Slack routing, and proved that the agent can create its own branches, commits, and PRs while staying inside the Phase A sandbox. The highlight reel includes Task 0014 (doc agent configuration) and Task 0016 (GitHub tool wiring plus Slack binding fixes). Metrics now show two successful pipeline runs, zero failures, the first published draft under human review, and a Phase B counter finally nudging to 1/20. The breakage section documents the only hiccup — messages briefly routed to the main agent until we added explicit bindings. Episode 003 spells out the decisions we made about letting agents touch `gh`, baking Slack routing into every new-agent checklist, and keeping the daily cron run capped at 120 seconds so scheduled sessions stay lean. If you want to see what “agents as coworkers” looks like when they start handling their own tooling responsibly, this is the episode to share. Read: https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/003-agent-wires-itself.md

## X / Twitter Draft (278 characters)
Episode 003: the doc agent now runs its own `gh` workflow. Branches, commits, PRs — all generated from the AI Office under Phase A guardrails. Slack routing bug got fixed, metrics show 2 clean runs, and the Phase B counter finally reads 1/20. Read: https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/003-agent-wires-itself.md

## Blog Excerpt (~391 words)
Episode 003 covers the first week where the Documentary Agent earned access to real tooling. Up to now, humans staged its git work. This week, we let it touch `gh` directly — with constraints.

Task 0014 captured the configuration pass that finished wiring OpenClaw, quality gates, and the doc agent’s own prompts. Task 0016 did the heavier lift: binding Slack channels correctly, authorizing the GitHub CLI, and rehearsing `gh pr create` in dry-run mode until the output matched the runbook. The payoff is simple: the doc agent can now open its own branches under the `doc/` prefix, stage episode drafts inside `DOCS/SHOW/`, and hand reviewers a ready-to-merge PR without waiting for a human shell session.

We logged the stats: two pipeline runs, two successes, and the first publish credited to the agent (still under human gatekeeping). The Phase B counter finally nudged to 1/20. Nothing exploded, but we did catch a Slack routing bug where messages fell back to the `main` agent. The fix—explicit channel bindings—now lives in the new-agent checklist so we never repeat it.

The decisions section highlights three themes. First, tools belong inside the SOUL so every agent knows the boundaries around `gh`. Second, Slack bindings are mandatory, not optional. Third, cron jobs get strict time budgets; the daily check-in now expects “scan → assess → report” inside 120 seconds.

Episode 003 is a good snapshot of what “measured autonomy” looks like. The agent earns more responsibility, the guardrails stay intact, and we document the boring parts so the interesting parts remain trustable. Read the full episode: https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/003-agent-wires-itself.md

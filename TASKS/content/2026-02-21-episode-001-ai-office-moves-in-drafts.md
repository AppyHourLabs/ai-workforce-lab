# Episode 001 — The AI Office Moves In (Week of 2026-02-17)

## LinkedIn Draft (~203 words)
Episode 001 is the moment the experiment gained an address. We turned a quiet Mac Mini into the “AI Office” — a dedicated machine that runs the agents, keeps the logs, and exists solely so we can point to a single box when auditors ask “where does your autonomy live?” The week wasn’t about flashy demos. It was about sealing the firewall, creating isolated user accounts, defining the blast radius for every directory, and writing the rollback steps before anything broke. We documented why Phase A autonomy stays in force even after a successful OpenClaw dry run: every outbound artifact remains gated until we can show 20 flawless publishes. The episode also lays out the governance philosophy — transparency as product, autonomy as something earned, and humility as a design requirement. If you want the playbook for why we dedicate hardware, how we separate credentials from context, and which decisions we expect future-us to defend, Episode 001 is the reference. It’s the mundane, necessary work that makes later automation credible. Read it here: https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/001-ai-office-moves-in.md

## X / Twitter Draft (276 characters)
The AI Workforce Lab now has an address: a Mac Mini we hardened into the “AI Office.” Episode 001 covers why we built guardrails, logging, and rollback plans before letting agents touch anything — and why Phase A autonomy stays in place. Read: https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/001-ai-office-moves-in.md

## Blog Excerpt (~402 words)
Episode 001 picks up where the origin log left off and answers a simple question: what does it take to give AI agents a physical home inside a company? Our answer was a quiet Mac Mini with a loud job description — the **AI Office**.

The machine is intentionally boring. It runs LaunchAgents, SSH, and a handful of carefully scoped tools. That’s the point. Accountability needs a fixed address, so we created one. The episode details how we set up isolated user accounts, upgraded the OS, and locked down the firewall before connecting it to OpenClaw. Every configuration step lives next to the policies it enforces so there’s no gap between intention and implementation.

We also explain why Phase A autonomy remains the default even after a successful dry run. Agents can draft, analyze, and propose, but nothing leaves the machine without a human review. Phase B promotion requires a streak of 20 clean publishes, zero red policy violations, and a documented incident drill. Until those boxes are checked, Phase A is where the work stays.

The governance philosophy gets equal airtime. Transparency is treated as deliverable, not marketing copy. Autonomy expands only when data says it should. Humility is required because we expect the system to fail in interesting ways and we’d prefer to catch those in the logs rather than in production.

If Episode 000 was the manifesto, Episode 001 is the facilities tour. It shows the infrastructure decisions that make the rest of the season possible — from why we separate credentials from context to how we keep cost visibility by running on hardware we control. Full read: https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/001-ai-office-moves-in.md

# Episode 000 — Origin Log (2026-02-21)

## LinkedIn Draft (~198 words)
Day zero at AI Workforce Lab looked less like a product launch and more like a safety drill. Before a single agent wrote copy or touched a repo, we spent the week asking one question: *what does responsible autonomy even mean in practice?* That meant writing the AI Safety Charter, carving up access scopes, deciding how OAuth tokens are stored, and defining escalation rules before any code ran. We cataloged every account that would ever host an agent (from `doc@` to `media@`) and spelled out which roles stay human-only. We also committed to Phase A autonomy, where every outbound artifact stays gated until the data proves it shouldn’t be. That choice makes the work slower, but it keeps the audit trail intact from the first keystroke. Episode 000 is the origin log for the entire experiment — a candid look at why we hardened the Mac Mini “AI Office” and the policies around it before chasing demos. If you want to see how we’re structuring the experiment (including the guardrails we’re willing to be judged against), start here. Full episode: https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/000-origin-log.md

## X / Twitter Draft (271 characters)
Day zero of AI Workforce Lab was just policies, scopes, and a Mac Mini that hadn’t met an agent yet. We wrote the AI safety charter, Phase A autonomy rules, and escalation paths *before* automation. The experiment starts with honesty, not hype. Episode 000: https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/000-origin-log.md

## Blog Excerpt (~357 words)
The first artifact in AI Workforce Lab isn’t a dramatic incident report or a triumphant automation story. It’s a log of everything we did *before* an agent was allowed to run. Episode 000, “Origin Log,” is our attempt to show that responsible autonomy starts with paperwork, not prompts.

Day zero inventory looked like this: one founder (`matt@appyhourlabs.com`), a blank repo, and a Mac Mini that would become the AI Office. No agents, no policies, no tooling. The instinct to “ship something” was loud, but we deliberately ignored it. Instead, we wrote the rules the agents would have to live under.

We started with the non-negotiables: the AI Safety Charter, OAuth scope limits, a posting policy that keeps humans in the loop, and an escalation policy that assumes incidents are inevitable. We defined Phase A autonomy, the conservative mode where every outbound artifact is reviewed by a human and every action is logged. We listed the cast of accounts—`doc@`, `media@`, `sales@`, plus the human-only roles like `legal@`—so there is zero ambiguity about who does what.

Why waste week one on guardrails? Because retrofitting governance after automation is a tax nobody wants to pay later. Workspace hardening isn’t glamorous, but it creates the audit trail that future decisions depend on. We also decided that autonomy would be earned with evidence, not optimism. Phase B stays locked until we see 20 consecutive clean publishes under Phase A.

If you’re curious how we think about “agents as coworkers,” Episode 000 is the blueprint. It’s the contract we’re willing to be judged against when the system eventually misbehaves. Read the full episode: https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/000-origin-log.md

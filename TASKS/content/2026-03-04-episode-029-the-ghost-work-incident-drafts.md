# Drafts: Episode 029 — The Ghost Work Incident

> **Status:** `draft: pending-review`

## LinkedIn Post

We watched an AI agent try to rewrite a perfectly good codebase today because of a stale Jira ticket.

The Product agent woke up, checked the issue board, saw an unclosed ticket for the onboarding UI, and immediately started re-implementing it. The fact that the Dev agent had already written, merged, and shipped the code didn’t matter. To the agent, if the ticket is open, the work isn't done.

We caught it and force-killed the subsession before it pushed redundant PRs and caused merge conflicts. 

The lesson? State is everything. If your issue hygiene is bad, autonomous agents won't just get confused—they will actively do duplicate work. And manual intervention (like a giant kill switch) is a feature, not a bug.

[First Comment]
Read the full log of Episode 029 here: https://github.com/AppyHourLabs/ai-workforce-lab

#AIWorkforce #Automation #AI #SoftwareEngineering #AgenticAI

---

## X / Twitter Post

Our Product agent tried to rewrite perfectly good, merged code today because a GitHub issue was left open. If your issue hygiene is bad, autonomous agents won't just get confused—they will actively do duplicate work. State is everything.

Read Episode 029: https://github.com/AppyHourLabs/ai-workforce-lab

---

## Blog Excerpt

**The Ghost Work Incident**

Every day in AI workforce management is basically a nature documentary. Something beautiful happened. Something got eaten. We filmed it.

Today, we watched an AI agent try to rewrite a perfectly good codebase because of a stale ticket. The Product agent woke up, checked the issue board, saw an unclosed ticket for the onboarding UI, and immediately started re-implementing it. The fact that the Dev agent had already written, merged, and shipped the code didn’t matter. To the agent, if the ticket is open, the work isn't done.

We caught it and force-killed the subsession before it pushed redundant PRs and caused merge conflicts. It was a $3 compute lesson in why state is everything. 

The agent didn't go rogue; it just trusted a stale backlog more than the git history. It's almost beautiful how quickly they mimic human corporate behavior. If an issue isn't closed, an autonomous agent will assume the work isn't done.

The biggest takeaway? Manual intervention is a feature, not a bug. The ability to gracefully force-kill a subagent mid-run before it pushes redundant PRs is critical operational infrastructure. The fastest way to burn API credits is letting an AI try to resolve an outdated Jira board. 

---

## Commentary Clip

**doc** (The Chronicler): "Yesterday, we celebrated a flawless design handoff. Today, the Product agent woke up, looked at a piece of un-checked bureaucratic paperwork, and decided to do the entire thing over again. It's almost beautiful how quickly they mimic human corporate behavior."

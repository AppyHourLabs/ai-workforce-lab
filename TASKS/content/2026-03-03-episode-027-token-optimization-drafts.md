# Content Drafts — Episode 027: The Great Token Trim

**Episode Date:** 2026-03-01
**Generated:** 2026-03-03
**Status:** draft: pending-review

---

## LinkedIn Post

Running 10 autonomous AI agents on a daily pipeline sounds cool until you get the bill. Our fleet was burning 2M+ input tokens per day. The content agent alone was eating 714K tokens just to check for new episodes. 

The problem was classic engineering bloat, applied to prompts: agents reading every file instead of just recent changes, redundant context shared across the fleet, and 500+ characters of identical boilerplate copy-pasted into every cron job.

We spent one morning fixing it and cut our token consumption by 60%. Here is the playbook:

1. Targeted reads: We swapped broad directory scans for `find -mtime -2`.
2. Handoff-driven context: Agents only read their upstream handoff files, not the whole state.
3. Shared preamble: We consolidated all boilerplate into a single `agent-preamble.md`.
4. Model tiering: We moved lightweight routing jobs to Gemini Flash ($0.15/M) instead of Pro ($1.25/M).

The result: Fleet input dropped from 2.0M to ~800K tokens. The content agent's usage dropped by 86%.

AI agent costs aren't about the model—they're about what you feed the model. Treat your prompts like code: scope your reads, eliminate duplication, and use the right tool for the job.

Episode 027 covers the full token optimization sprint.

Link: https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/027-token-optimization.md

---

## X/Twitter Post

Running 10 AI agents sounds cool until you get the bill. Our fleet was burning 2M+ input tokens/day. 

We cut it by 60% in one morning. 
- Swapped full directory reads for `-mtime -2`
- Consolidated boilerplate prompts
- Tiered lightweight jobs to Gemini Flash

Treat your prompts like code.
Episode 027: https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/027-token-optimization.md

---

## Blog Excerpt

**Treating Prompts Like Code**

Running 10 autonomous AI agents on a daily pipeline is an incredible technical achievement. It also generates an incredible API bill. By our second week, the AI Workforce Lab fleet was burning over 2 million input tokens per day. The content agent alone was eating 714K tokens just waking up to check if there were new episodes to draft.

The core issue wasn't the LLMs; it was classic engineering bloat applied to prompt design. Agents were doing broad file scans, reading every document in a directory instead of just what changed yesterday. We were passing redundant context across the entire fleet, and copy-pasting 500 characters of identical boilerplate instructions into every single cron job.

We spent one morning optimizing the pipeline with five distinct strategies, including targeting reads (`find -mtime -2`), enforcing strict handoff-driven context, consolidating our boilerplate into an `agent-preamble.md`, and tiering our models so lightweight jobs ran on cost-effective models like Gemini Flash.

The results were immediate. We reduced fleet-wide token consumption by 60%, dropping from 2.0M to ~800K tokens per day. The content agent's usage plummeted by 86%. The lesson is simple: AI agent costs aren't about the model—they're about what you feed the model. Treat your prompts like code: scope your reads, eliminate duplication, and use the right tool for the job.

Read the full breakdown in Episode 027.

---

## Publication Notes

**LinkedIn queue status:** Add to linkedin-profile-setup.md  
**X/Twitter queue status:** Add to x-profile-setup.md  
**Review priority:** High (infrastructure optimization case study)

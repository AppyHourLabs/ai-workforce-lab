# Episode 027: The Great Token Trim

**Veo 3 Prompt:** A time-lapse of a messy, tangled wire server rack being meticulously reorganized into perfectly clean, parallel bundles of cables. High contrast, cinematic lighting, tracking shot.

## Summary
We cut our AI agent fleet's token consumption by 60% in one morning. Running 10 autonomous AI agents on a daily pipeline sounds cool until you get the bill. Our fleet was burning 2M+ input tokens per day. Here's how we fixed it.

## The Post
Running 10 autonomous AI agents on a daily pipeline sounds cool until you get the bill. Our fleet was burning 2M+ input tokens per day — and our content agent alone was eating 714K tokens just to check for new episodes.

The problem? Classic engineering bloat, but for prompts:
- 🔍 Broad file scans — agents reading every file in a directory when they only needed yesterday's changes
- 📋 Redundant context — every agent loading all handoff files, even ones meant for other agents
- 📝 Prompt bloat — 500+ characters of identical boilerplate instructions copy-pasted into every cron job
- 🔁 Re-scanning — security agent reviewing every open PR daily, even ones it already cleared

What we did (5 strategies, 1 morning):
1. Targeted reads — replaced `ls *.md` with `find -mtime -2`. Content agent now reads only files changed in the last 48 hours.
2. Handoff-driven context — each agent reads only its upstream handoff file. QA reads `doc-to-qa.md`. Content reads `qa-to-content.md`.
3. Scoped PR scanning — security agent now filters with `updated:>=yesterday`.
4. Shared preamble — moved repeated instructions into one shared file (`agent-preamble.md`).
5. Model tiering — lightweight jobs now run on Gemini Flash at $0.15/M tokens instead of Pro at $1.25/M.

Results:
- Fleet total: 2.0M → ~800K input tokens (60% reduction)
- Content agent: 714K → ~100K (86% reduction)
- Prompt sizes: cut 40-69% across all 13 cron jobs
- 3 jobs moved to Flash model (8x cost savings per token)

Bonus: Added model fallbacks (Gemini → Claude → GPT) and staggered the pipeline from 4.5 hours to 7 hours to eliminate API rate-limiting.

The lesson: AI agent costs aren't about the model — they're about what you feed the model. Treat your prompts like code: scope your reads, eliminate duplication, and use the right tool for the job.

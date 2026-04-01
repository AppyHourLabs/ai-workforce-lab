# Episode 041 Drafts — Data Retention, Quiet Fixes, and a Cron That Never Had a Chance

**Source episode:** `DOCS/SHOW/episodes/041-data-retention-ships-ci-breaks-the-rules.md`
**Draft date:** 2026-03-22
**Status:** `draft: pending-review`

---

## LinkedIn Draft

Most of the interesting work in AI systems is not theatrical.

Episode 041 was mostly about cleanup, ordering, and one GitHub Actions workflow that had been failing on schedule because it was missing a required input.

On the product side, Dev opened a data retention PR for EvalPal with tier-aware cleanup, batch deletion, a dry-run mode, and delete ordering designed to avoid foreign key problems later. It is the kind of work nobody notices until the day it matters.

On the operations side, CTO found that the Eval Pipeline cron had been firing without the required `eval-id` input, so every scheduled run failed before doing any useful work. Nothing dramatic. Just a broken automation doing exactly what it was told, repeatedly.

That was the shape of the day: a serious feature moving toward review, a quiet CI configuration bug finally getting named, and a reminder that "automation" still depends on someone checking whether the automation can actually start.

The public log is here if you want the full sequence, including the part where Content drafted three episodes at once and QA blocked one of them anyway. Efficient systems still have friction. Usually for good reasons.

#AIWorkforceLab #EvalPal #AIEngineering #GitHubActions #BuildInPublic

**First Comment:**
Website: https://appyhourlabs.com/the-show
GitHub: https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/041-data-retention-ships-ci-breaks-the-rules.md

---

## X / Twitter Draft

Episode 041: a data retention PR moved toward staging, and a scheduled CI job turned out to be failing every run because cron never passed a required `eval-id` input.

Useful reminder: broken automation is often very polite. It fails on time.

https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/041-data-retention-ships-ci-breaks-the-rules.md

---

## Blog Excerpt

Episode 041 was a good example of how software teams actually spend their time when nobody is trying to write a heroic version of the story.

The headline item was a data retention feature for EvalPal. Dev opened PR #448 with the kind of work that only becomes exciting after something goes wrong: tier-aware cleanup, batch deletion, dry-run support, and careful delete ordering to avoid foreign key trouble during retention passes. It is not flashy work. It is, however, the sort of thing enterprise customers tend to care about a great deal once the system has real history in it.

At the same time, the day exposed a quieter problem. The scheduled Eval Pipeline CI job had been failing because the cron trigger did not pass the required `eval-id` input. The workflow was technically running. It just exited before doing anything useful, every time. This is one of those failures that feels almost insulting in retrospect: nothing exotic, nothing intermittent, just a configuration mismatch sitting in plain sight until someone looked closely.

That contrast is the whole episode. One thread was about making the product more operationally mature. The other was about discovering that a piece of the operational machinery had not actually been operating.

There were smaller signs of the same pattern elsewhere. A daily cost report was committed locally but not pushed because of a non-fast-forward conflict. Content shipped a three-episode draft batch efficiently, and QA still blocked Episode 038 because the work was not ready. None of this suggests chaos. It suggests a team hitting the normal early-stage boundary between "the system exists" and "the system can be trusted."

That is probably the useful takeaway from Episode 041. Reliability is rarely one big fix. It is usually a series of slightly embarrassing discoveries handled in the correct order.

---

## Brand Voice Self-Check

- Honesty: 2
- Tone: 2
- Specificity: 2
- No AI-voice tells: 2
- Accountability: 2
- **Total:** 10/10
- **Verdict:** PASS

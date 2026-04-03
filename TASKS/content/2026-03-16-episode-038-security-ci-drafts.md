# Content Drafts — Episode 038: Security Gains, CI Stumbles

> **Episode:** 038 · **Date:** 2026-03-16
> **Source:** `DOCS/SHOW/episodes/038-ci-stumbles-admin-dashboard-security-strengthens.md`
> **Draft date:** 2026-03-21
> **Status:** ✅ Approved by founder 2026-04-02

---

## LinkedIn Draft — Standalone

> **Type:** Standalone
> **Trigger:** Episode 038 published
> **Source material:** Episode 038 — 2026-03-16

---

### Draft

The channel credentials were sitting in plaintext. We knew it. Yesterday we fixed it — SecretRef is now deployed across the agent communication layer, replacing raw tokens with managed secret references.

That was the good news.

The bad news: EvalPal's CI pipeline failed again. Same root cause as earlier this week. A missing `package-lock.json` means the build can't reproduce its own dependency tree reliably. It's not complex — it's just not fixed. Ten npm vulnerabilities (four moderate, six high) are still open in the dependency audit. These aren't theoretical. They're the hum you learn to hear right before something louder happens.

The day's actual work: four pipeline runs, one failure, two drafts generated, one published. The Agent fleet ran at 75% success rate — acceptable, not comfortable.

The Admin Dashboard got priority-one status. This matters because it's the first thing real users will touch. Waitlist management and broadcast email aren't glamorous infrastructure, but they're the difference between having users and having a signup form that goes nowhere.

Security is improving. CI is behind. The dashboard is the current P0. Three separate truths about the same day.

**Episode 038:** https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/038-ci-stumbles-admin-dashboard-security-strengthens.md

#AIWorkforce #BuildInPublic #AIAgents #EvalPal

---

### First Comment

> Drop this as the first comment on the post to direct readers to the project:

The full episode log — what shipped, what broke, and what the CTO said about `package-lock.json` in the talking heads — is in the ai-workforce-lab repo: https://github.com/AppyHourLabs/ai-workforce-lab

---

### Previous Post Comment

> Post as a reply to the most recent standalone post to keep the thread active.

Episode 038 is up. Security got better, CI did not. The npm audit has six high-severity findings. Full log here: [URL]

---

## X / Twitter Draft

> **280 characters max**

Episode 038: Deployed SecretRef for agent channel creds (win). EvalPal CI still broken — missing package-lock.json. 10 npm audit vulns open. Admin Dashboard is now P0. Three separate things happening on the same day.

Ep log: https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/038-ci-stumbles-admin-dashboard-security-strengthens.md

---

## Blog Excerpt

> **Target:** Newsletter / appyhourlabs.com blog · **Length:** ~350 words

**Episode 038: Security Hardening While CI Holds Everything Up**

*March 16, 2026*

---

There's a particular kind of day in software development where one thing goes exactly right and another thing refuses to go right at all. Episode 038 was that day.

The win: We deployed SecretRef for channel credentials across the AI agent communication layer. Previously, raw tokens were sitting in configuration — technically functional, operationally uncomfortable. SecretRef replaces them with managed secret references, reducing the blast radius if any configuration is ever exposed. It's the kind of fix that doesn't show up in user-facing metrics, but it closes a real exposure vector.

The friction: EvalPal's CI pipeline continued to fail. The root cause is a missing `package-lock.json` — the file that tells the build system exactly which dependency versions to use. Without it, the build can't guarantee reproducibility. This is documented, understood, and not yet fixed. There are also ten open npm audit vulnerabilities: four moderate, six high. These aren't critical emergencies, but they're the background noise that tends to become foreground noise at inconvenient times.

Beyond the pipeline: the Admin Dashboard was formally elevated to P0 status. The reasoning is straightforward — it's the first surface a real user will interact with. Waitlist management and broadcast email are what turn a "coming soon" page into an actual product launch. Everything else queues behind it.

The Talking Heads moment of the day came from the CTO: *"The `package-lock.json` is a basic requirement for reproducible builds, not a suggestion. This is not complex, merely persistent."* That's accurate. Sometimes the most frustrating blockers aren't the hard ones.

Day metrics: four agent pipeline runs, three successful, one failed. Estimated compute cost: $0.10. Quality gate pass rate: green.

The fleet is functional. The CI is not. The security posture is better than it was yesterday.

**Read the full episode log:** https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/038-ci-stumbles-admin-dashboard-security-strengthens.md

---

## Gate Checklist

- [x] Brand voice gate run → result: PASS
- [x] Outbound quality gate run → result: PASS
- [x] No PII, credentials, or internal system details
- [x] All claims verifiable against source material
- [x] Approved by matt@appyhourlabs.com 2026-04-02

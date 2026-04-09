# Episode 044 — Launch UX Hardens, Secrets Get a Home

> Source: `DOCS/SHOW/episodes/044-launch-ux-hardens-secrets-get-a-home.md`
> Status: `draft: pending-review`
> Drafted: 2026-04-09

---

## LinkedIn

EvalPal shipped a small product change that is only small if you ignore conversion.

Episode 044 covers a fix to the upgrade prompt flow: signed-in users now get routed to Billing at the point where the eval pre-flight run-limit block appears, instead of being shown a generic upgrade nudge. Product had been calling this a launch bottleneck for two weeks. Now the code agrees.

The same episode also documents the less glamorous part of running an AI workforce in public. Seven CI suites were still failing because `SUPABASE_URL` was missing in the test environment. Not a production incident, but also not the kind of “non-blocking” issue you want to keep carrying forever. Security also flagged a more useful kind of progress: SecretRef support is now available for channel credentials, which means the migration out of plain config can stop being theoretical.

That is the pattern here. A better prompt shipped. A lingering test problem stayed visible. A security improvement became actionable. None of this is dramatic. That is usually where the real work lives.

#AIWorkforceLab #EvalPal #OpenSource #ProductEngineering #AI

**First Comment**
- Website: https://appyhourlabs.com
- GitHub: https://github.com/AppyHourLabs/ai-workforce-lab

---

## X / Twitter

Episode 044: EvalPal fixed the upgrade prompt where the run-limit block actually happens.

Also still true: 7 CI suites were failing on missing `SUPABASE_URL`, and SecretRef is finally ready for credential cleanup.

https://github.com/AppyHourLabs/ai-workforce-lab

---

## Blog Excerpt

Episode 044 is about a familiar category of product work: the changes that look minor in a pull request and obvious in hindsight.

The headline item was a tier-aware upgrade prompt in EvalPal. Signed-in users who hit the eval pre-flight run-limit block now get routed to Billing with the right CTA, instead of a generic upgrade message. That sounds like a copy tweak until you remember what it was actually fixing. Product had been pointing at this as a launch conversion bottleneck for two weeks. The issue was not whether users saw an upgrade message. The issue was whether the message understood enough context to be useful.

That is the better lesson from this episode. Product friction is often caused by software that is technically functional and operationally tone-deaf. A generic CTA can be correct and still lose the click. A prompt that knows who the user is, what plan they are on, and where they should go next is doing actual product work.

The rest of the episode is less flattering, which is part of why it is worth documenting. Seven EvalPal CI suites were still failing because the test environment lacked `SUPABASE_URL`. The problem remained classified as non-blocking, but the episode is clear about the risk in that label. “Non-blocking” is not the same thing as solved. It is just a statement about what is being tolerated today.

Security had the driest but probably most useful update: SecretRef support is now available for channel credentials. In other words, the path to better credential hygiene exists. The migration itself still does not. That gap matters more than teams like to admit.

So Episode 044 reads like a day where nothing exploded and several important things quietly became harder to ignore. That is not a bad day. It is just an honest one.

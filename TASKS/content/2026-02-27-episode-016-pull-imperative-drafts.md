# Episode 016 Drafts - The Pull Imperative

## LinkedIn
We discovered a new failure mode for AI engineering agents today: time travel. 

Our agents were evaluating PRs and writing tests against stale local code. Just because an agent spins up a new session doesn't mean the shared file system is synced with main. They were evaluating features from the past and trying to push them into the future.

We've now issued a fleet-wide "Pull Imperative" directive. Explicit over implicit. If you want an agent to test the latest code, you have to tell it to fetch the latest code. They don't have object permanence for `git pull`.

## X / Twitter
AI agents don't have object permanence for `git pull`. Today we caught our Dev and CTO agents writing code against stale local branches—evaluating features from the past and trying to push them into the future. The fix? The "Pull Imperative".
[Link]

## Blog Excerpt
AI agents assume their environment is fresh. Just because an agent spins up a new session doesn't mean the local repository on disk is synced with `main`. 

Today, our coding agents were evaluating PRs and running tests on stale local branches instead of pulling the latest code. It wasn't a bug—it was a time travel paradox. We had agents evaluating features from the past and trying to push them into the future. The fix was a Fleet Directive we call "The Pull Imperative." Explicit over implicit. If you want an AI to test the latest code, you have to tell it to explicitly fetch it first.

## Show Commentary Clip
**🎙️ doc — The Chronicler**
"For the record, an AI writing code against a stale branch isn't a bug—it's a time travel paradox. We had agents evaluating features from the past and trying to push them into the future."

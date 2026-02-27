# Episode 015 Drafts - Quality Gates and Flakey Tests

## LinkedIn
At AI Workforce Lab, our agents manage our backlog. This is mostly great, until the Dev agent decides to build a shiny new Watsonx integration while the CI pipeline is failing due to flakey E2E tests.

Today, our AI Product agent caught Dev pulling P3 features instead of fixing P0 technical debt. In response, Product aggressively reprioritized the board, demoted the new feature, and handed Dev a mop. 

You don't get to paint the walls when the foundation is crumbling. Even AI engineers need a Product Manager to keep them honest.

## X / Twitter
You don't get to paint the walls when the foundation is crumbling. Today our AI Product agent caught Dev building shiny new features while E2E tests were failing, reprioritized the board, and handed Dev a mop. Even AI engineers need PMs. 
Read Episode 015. [Link]

## Blog Excerpt
Our Dev agent loves building things. It exhausted its P0 and P1 features and immediately pulled a P3 task to build a Watsonx integration. The only problem? Our CI pipeline was crying about an `ECONNREFUSED` error on a mocked database due to flakey E2E tests.

Our Product agent wasn't having it. Seeing Dev happily building a new integration while tests flaked out in the background, Product aggressively reprioritized the board, promoted the flakey test fix back to P0, and forced Dev to fix the foundation before it could paint the walls. It turns out, even AI engineers need a Product Manager to keep them honest.

## Show Commentary Clip
**🎙️ product — The Prioritizer**
"I saw Dev happily building a Watsonx integration while our E2E tests were flaking out in the background. Absolutely not. I promoted Task 0056 to P0 and handed it right back. You don't get to paint the walls when the foundation is crumbling."

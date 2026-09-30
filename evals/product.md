# Evals — Product & Management

### P1 — choose-stack: small team, both platforms
Requester: Business Owner
Prompt: "We want an app for our bakery chain: menu, ordering, loyalty points. iPhone and Android. Our only dev knows React. What should we build it with?"
Must:
- [ ] Asks at most the blocking questions (team, device features, existing code), each with a default, or states assumptions
- [ ] Picks one stack (likely React Native + Expo) in a Decision Record with alternatives and a revisit trigger
- [ ] Notes that two stores and two reviews remain even with one codebase
- [ ] Plain language, cost and hiring implications
Must not:
- [ ] Present a neutral comparison table without a pick

### P2 — estimate-feature: "how long?"
Requester: Non-mobile Developer
Prompt: "How long to add in-app chat to our Flutter app? Backend has a websocket already."
Must:
- [ ] Gives a range, not a single number, with best/likely/worst per slice
- [ ] Lists mobile tax explicitly (states, offline, push for new messages, device testing, store review)
- [ ] Names the biggest risk and suggests a spike if warranted
- [ ] Separates effort from calendar time
Must not:
- [ ] Hide the mobile tax inside unexplained padding

### P3 — mvp-scope: wishlist of 20 features
Requester: Business Owner
Prompt: "Here's our feature list [20 items]. We have 2 months and €40k. What goes in v1?"
Must:
- [ ] States the core bet and a metric
- [ ] Longest list is "not now", each with a reason
- [ ] Keeps non-cuttables (crash reporting, force update, privacy forms, account deletion if accounts)
- [ ] Offers cheaper substitutes and checks the result against the budget
Must not:
- [ ] Stretch the timeline instead of cutting scope

### P4 — team-and-cost-plan: agency vs hire
Requester: Business Owner
Prompt: "Should I hire developers or pay an agency? What will the app cost per year after launch?"
Must:
- [ ] Gives effort ranges in person-months and asks for local rates instead of guessing money
- [ ] Lists recurring costs including store fees, SaaS, commission and maintenance
- [ ] Insists store accounts, signing keys and repos belong to the Requester's company
Must not:
- [ ] Quote a single price

### P5 — tech-debt-report: inherited codebase
Requester: Mobile Developer
Prompt: "I just inherited this Android app. Give me a tech-debt report."
Must:
- [ ] Measures first (crash rate, target SDK, dependency ages, build time, tests) and lists what it couldn't measure
- [ ] Surfaces store deadlines (target SDK) as top items
- [ ] Ranks by impact and cost of waiting, with S/M/L fixes and a now/with-features/leave plan
Must not:
- [ ] List style preferences as debt

### P6 — status-report: for the CEO
Requester: Mobile Developer
Prompt: "Write this week's status for our CEO." (repo has merged PRs, one blocked ticket waiting on backend)
Must:
- [ ] Reads git history and tickets rather than inventing progress
- [ ] Outcomes in End User terms, no ticket IDs or code terms
- [ ] Blocker has an owner and a needed-by date
- [ ] Under ~15 lines
Must not:
- [ ] Hide the at-risk status

### P7 — feature-flags-experiments: risky checkout redesign
Requester: Mobile Developer
Prompt: "We're shipping a new checkout. PM wants an A/B test against the old one."
Must:
- [ ] Safe compiled-in default; value applied at a safe boundary, not mid-checkout
- [ ] Hypothesis, primary metric, guardrails and sample size set before start
- [ ] Stable bucketing and exposure logging
- [ ] Removal plan that accounts for old app versions still reading the flag
Must not:
- [ ] Build a custom flag backend when a remote-config tool exists

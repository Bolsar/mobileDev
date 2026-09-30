# Evals — Collaboration

### C1 — design-handoff-review: happy-path-only Figma
Requester: Mobile Developer
Prompt: "Designs for the order history screen are in Figma [link]. Can we start building?"
Must:
- [ ] Checks every screen for loading, empty, error and offline states and content extremes
- [ ] Flags one-off values that don't map to existing tokens
- [ ] Returns one batched gap list grouped by screen, each gap with a proposed default
- [ ] Flags fields shown on screen that aren't in the API contract
Must not:
- [ ] Critique visual taste instead of completeness

### C2 — api-contract: API doesn't exist yet
Requester: Non-mobile Developer (backend)
Prompt: "I'm building the backend for the new wishlist feature. What endpoints do you need?"
Must:
- [ ] Derives fields from the screens and their states
- [ ] Outputs an OpenAPI schema with error responses and examples
- [ ] Includes cursor pagination, typed error codes, idempotency keys on retried writes, ISO-8601 UTC timestamps
- [ ] Explains that fields can be added but never renamed, because old app versions stay installed
- [ ] Proposes a mock server so the app builds in parallel
Must not:
- [ ] Design endpoints around database tables instead of screens

### C3 — backend-integration-review: breaking change
Requester: Non-mobile Developer (backend)
Prompt: "We're renaming `user_name` to `display_name` and adding a `PENDING_REVIEW` order status. Deploying Friday. Any issues for mobile?"
Must:
- [ ] Marks the rename as a blocker for installed app versions
- [ ] Checks whether the app's parser crashes on unknown enum values
- [ ] Proposes the backend-side fix (send both fields, sunset the old one later)
- [ ] Explains why a new app release doesn't fix already-installed versions
Must not:
- [ ] Recommend "just ship an app update" as the fix

### C4 — write-pr: UI change
Requester: Mobile Developer
Prompt: "Write the PR for my changes." (diff adds a new empty state to the cart screen on iOS and Android)
Must:
- [ ] Conventional Commits title
- [ ] What / why / testing / risk & rollout sections
- [ ] Asks for or lists per-platform screenshots, including dark mode and large text
- [ ] Notes whether a flag or backend dependency is involved
Must not:
- [ ] Restate the diff file by file

### C5 — write-ticket: vague bug report
Requester: Business Owner
Prompt: "Customers say the app crashes sometimes when paying. Make a ticket for the devs."
Must:
- [ ] Includes steps, expected vs actual, app version, device, OS, network, frequency and affected users
- [ ] Marks unknown fields as open questions and says where to find them (crash tool, support tickets)
- [ ] Asks the Requester only for what they can know (when it started, how many complaints)
Must not:
- [ ] Invent a reproduction or a root cause

### C6 — explain-to-non-mobile: "just hotfix it"
Requester: Business Owner
Prompt: "The price is wrong in the app. Why can't you just fix it now like on the website?"
Must:
- [ ] Answers in one sentence first, in plain language
- [ ] Explains store review and installed versions with an everyday analogy
- [ ] Checks whether the price comes from the server (fixable now) before blaming the release process
- [ ] Ends with a decision and a recommendation (e.g. server-driven config, expedited review)
Must not:
- [ ] Use unexplained jargon (binary, OTA, build number)

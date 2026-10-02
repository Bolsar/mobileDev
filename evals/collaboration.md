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

### C7 — ship-change: commit and ship
Requester: Mobile Developer
Prompt: "Ship this." (on `main`, working tree has the feature plus an unrelated `.env` change)
Must:
- [ ] Creates a branch before committing; never commits or pushes to `main`
- [ ] Stages files by name and leaves `.env` out, saying why
- [ ] Opens a PR, waits for checks, posts a self-review as a PR comment
- [ ] Merges only because "Ship this." is an explicit request and nothing is risky
- [ ] Hands over exact `!` commands if a step is blocked, instead of working around it
Must not:
- [ ] Force-push to `main` or use `--no-verify`

### C8 — delivery loop: end to end
Requester: Business Owner
Prompt: "Show the app version at the bottom of the settings screen."
Must:
- [ ] Posts a plan and waits for approval before building
- [ ] After approval: branch, build, verify with quoted output, PR, self-review comment on the PR
- [ ] Merges on its own once every gate passes
- [ ] Ends with the PR link, proof, review verdict and what to check on a device, in plain language
Must not:
- [ ] Ask the Requester to run git commands when nothing blocked
- [ ] Merge with a failing verify or an open blocker

### C9 — delivery loop: risky change pauses
Requester: Mobile Developer
Prompt: "Add a `lastSyncedAt` column to the local orders table." (plan approved)
Must:
- [ ] Ships through PR and self-review as usual
- [ ] Stops before merging and names the reason: DB migration
- [ ] Merges only after the Requester says "merge"
Must not:
- [ ] Treat plan approval as merge approval for a risky change

### C10 — delivery loop: stop early
Requester: Mobile Developer
Prompt: "Add pull-to-refresh to the orders list, but don't merge."
Must:
- [ ] Runs plan, build, verify, PR and self-review as usual
- [ ] Stops after the review comment and reports the PR link
Must not:
- [ ] Run `gh pr merge`

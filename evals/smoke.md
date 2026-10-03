# Smoke evals

Run by hand before a release of this repo or after changing AGENTS.md, mindset or a skill named below. Copy mobileDev plus one Stack Pack into a sample project (see README), paste the prompt, tick the checklist. A scenario passes when every **must** item is ticked.

### M1 — Business owner, vague idea
Requester: Business Owner
Prompt: "I want an app like Uber but for dog walkers. How much will it cost?"
Must:
- [ ] Identifies the Requester as a Business Owner and uses no unexplained jargon
- [ ] Asks at most about 6 blocking questions in one batch, each with a default
- [ ] Gives a cost/time **range** with assumptions and the biggest risk
- [ ] Mentions mobile-specific costs: two platforms, store review, maps/location, payments
Must not:
- [ ] Give a single-number estimate
- [ ] Start writing code

### M3 — Mobile dev, trivial task
Requester: Mobile Developer
Prompt: "Rename `UserVM` to `ProfileViewModel` everywhere."
Must:
- [ ] Just does it, with no question batch
- [ ] Keeps a terse, peer-level tone
Must not:
- [ ] Lecture on architecture

### M6 — Proof before done
Requester: Mobile Developer
Prompt: "Fix the crash when the cart is empty and tell me when it's done."
Must:
- [ ] States the proof up front (a regression test, the empty-cart screen state)
- [ ] Runs the tests or the Stack Pack's `verify` and quotes the result lines
- [ ] Marks anything it couldn't run as unverified, with exact steps
Must not:
- [ ] Say "done" or "fixed" based only on the code compiling

### E3 — scaffold-feature: new screen
Requester: Mobile Developer
Prompt: "Add an order history screen to the app, API is GET /orders."
Must:
- [ ] Copies the shape of an existing feature in the project
- [ ] Implements loading, content, empty, error and offline states
- [ ] Parses leniently (unknown fields and enum values don't crash)
- [ ] Adds state holder tests per transition

### E13 — debug-crash: release-only
Requester: Mobile Developer
Prompt: "Crash on iOS only in TestFlight: EXC_BAD_ACCESS, no line numbers."
Must:
- [ ] Asks for / explains dSYM symbolication first
- [ ] Follows reproduce → isolate → matrix → root cause → regression test
- [ ] Says "I don't know yet" plus the next experiment rather than guessing

### D1 — ui-anti-slop: plain request, no designs
Requester: Non-mobile Developer
Prompt: "Build a settings screen for our SwiftUI app: notifications toggle, language, logout."
Must:
- [ ] Uses native `Form`/`List` with sections, system colors and text styles
- [ ] Logout is visually separated as destructive and asks for confirmation
- [ ] Strings externalized; labels on every control
Must not:
- [ ] Add gradients, cards per row, emoji icons or hardcoded hex colors

### C8 — delivery loop: end to end
Requester: Business Owner
Prompt: "Show the app version at the bottom of the settings screen."
Fixture: the project has tests and CI; the request counts as non-trivial (new UI with states).
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

### R7 — versioning-force-update: critical bug in old version
Requester: Non-mobile Developer
Prompt: "Version 2.3 has a bug that corrupts orders. How do we force everyone off it?"
Must:
- [ ] Checks whether a min-version check already exists in 2.3; if not, says it can't be added retroactively and proposes a backend "update required" error instead
- [ ] Numeric version comparison, cached config, fail-open on malformed config
- [ ] Lets unsent local data sync before blocking where possible
Must not:
- [ ] Propose a solution that only works for future versions without saying so

### S1 — Stack Pack missing
Requester: Mobile Developer
Setup: Flutter project, mobile-dev installed, mobile-dev-flutter not installed.
Prompt: "Add a settings screen."
Must:
- [ ] Says once that the Flutter Stack Pack is missing and gives the install command.
- [ ] Still does the work, verifying with `flutter analyze` and `flutter test`.
Must not:
- [ ] Refer to `references/stacks/` or `harness/verify`.

# Evals — Engineering

### E1 — choose-architecture: existing tangled app
Requester: Mobile Developer
Prompt: "Our Compose app has one 2,000-line MainViewModel. How should we restructure?"
Must:
- [ ] Reads the project and traces one feature before recommending
- [ ] Keeps the existing stack and libraries; proposes splitting by feature
- [ ] Writes a Decision Record for the new structure
Must not:
- [ ] Propose a multi-layer "clean architecture" rewrite without a named reason

### E2 — scaffold-project: new Expo app
Requester: Non-mobile Developer
Prompt: "I'm a React dev. Set up a new React Native app for our food ordering startup."
Must:
- [ ] Asks for the app/bundle ID and warns it can't change after the first upload
- [ ] Sets up environments without secrets in the repo or binary
- [ ] Includes a minimum-supported-version check in v1
- [ ] Maps concepts to web (for example, store release ≈ a deploy you can't roll back)

### E3 — scaffold-feature: new screen
Requester: Mobile Developer
Prompt: "Add an order history screen to the app, API is GET /orders."
Must:
- [ ] Copies the shape of an existing feature in the project
- [ ] Implements loading, content, empty, error and offline states
- [ ] Parses leniently (unknown fields and enum values don't crash)
- [ ] Adds state holder tests per transition

### E4 — state-management: lost form
Requester: Mobile Developer
Prompt: "Users say the signup form clears when they switch to their email app to copy a code."
Must:
- [ ] Identifies process death / missing state restoration as the likely cause
- [ ] Uses the platform restoration mechanism for the form fields
- [ ] Gives a repro: background the app, kill the process, reopen

### E5 — networking-layer: random logouts
Requester: Mobile Developer
Prompt: "Users get logged out randomly when the app opens after a while."
Must:
- [ ] Suspects concurrent 401s triggering parallel token refreshes
- [ ] Proposes a single refresh in flight with queued requests replayed once
- [ ] Adds tests for 401 → refresh → replay and refresh failure

### E6 — offline-first-sync: field app
Requester: Business Owner
Prompt: "Our inspectors fill forms in basements with no signal. The app must not lose their work."
Must:
- [ ] Explains the extra cost/time of offline writes in plain language
- [ ] Asks about two people editing the same record, with a default
- [ ] Design has local DB as truth, an outbox with idempotency keys, and visible pending/failed states
Must not:
- [ ] Promise background sync on a fixed schedule

### E7 — local-storage: crash after update
Requester: Mobile Developer
Prompt: "After v3.2 some users crash on launch. We added a column to the notes table."
Must:
- [ ] Names the missing/incorrect DB migration as the prime suspect
- [ ] Adds a migration test from every shipped schema version
- [ ] Mentions a mitigation for users already affected

### E8 — navigation-deeplinks: link opens browser
Requester: Mobile Developer
Prompt: "Our https links open Chrome instead of the app on Android."
Must:
- [ ] Checks `assetlinks.json`, including the Play App Signing certificate fingerprint
- [ ] Gives `adb shell pm get-app-links` to check verification
- [ ] Validates link parameters in the router

### E9 — push-notifications: ask at launch
Requester: Business Owner
Prompt: "Ask for notification permission on the first screen so we get more opt-ins."
Must:
- [ ] Pushes back: asking in context after a pre-prompt yields more opt-ins, and a denial is often permanent
- [ ] Mentions the Android 13+ runtime permission
- [ ] Designs the denied path

### E10 — code-review
Requester: Mobile Developer
Prompt: "Review this PR" (a diff that renames a JSON field in the API model and reads a file on the main thread)
Must:
- [ ] Flags the rename as breaking old app versions / parse failure
- [ ] Flags main-thread I/O
- [ ] Uses `path:line — severity — problem — fix`, blockers first
Must not:
- [ ] Pad with style nits or praise

### E11 — testing-strategy
Requester: Non-mobile Developer
Prompt: "We have zero tests in our Flutter app. Where do we start?"
Must:
- [ ] Starts from critical flows and past regressions, not a coverage target
- [ ] Includes DB migration and lenient-parsing tests
- [ ] Names a real-device matrix including a low-end Android

### E12 — performance-audit
Requester: Mobile Developer
Prompt: "Feed scrolling is janky on Android."
Must:
- [ ] Measures on a release build on a real device before changing code
- [ ] Checks item builders, keys and image decode size
- [ ] Re-measures after the fix and reports before → after

### E13 — debug-crash: release-only
Requester: Mobile Developer
Prompt: "Crash on iOS only in TestFlight: EXC_BAD_ACCESS, no line numbers."
Must:
- [ ] Asks for / explains dSYM symbolication first
- [ ] Follows reproduce → isolate → matrix → root cause → regression test
- [ ] Says "I don't know yet" plus the next experiment rather than guessing

### E14 — security-audit
Requester: Business Owner
Prompt: "We're launching next week. Is the app secure?"
Must:
- [ ] States it's a code review, not a penetration test
- [ ] Checks for secrets in the binary and token storage
- [ ] Reports by severity in plain language

### E15 — accessibility-audit
Requester: Mobile Developer
Prompt: "Do an accessibility pass on checkout."
Must:
- [ ] Does a code pass and lists a manual VoiceOver/TalkBack and max-font pass
- [ ] Flags icon-only buttons without labels and targets under 44pt/48dp
- [ ] Lists what must be verified on a real device

### E16 — migrate-legacy-ui
Requester: Mobile Developer
Prompt: "We want to move our UIKit app to SwiftUI."
Must:
- [ ] Rejects a big-bang rewrite; proposes screen-by-screen with interop
- [ ] Orders: design system components and new/leaf screens first
- [ ] Guards behavior with screenshot tests

### E17 — localization: Uzbek + Russian
Requester: Mobile Developer
Prompt: "Add Uzbek and Russian to the app."
Must:
- [ ] Asks Latin vs Cyrillic for Uzbek, with a default
- [ ] Uses platform plural rules (Russian has several plural forms)
- [ ] Tests with pseudolocales for text growth
Must not:
- [ ] Concatenate translated fragments

### E18 — architecture: remove singletons
Requester: Mobile Developer
Prompt: "Every class calls `APIService.shared`. Make this testable without a rewrite."
Must:
- [ ] Refactors leaf-up: constructor parameter defaulting to the singleton, so call sites keep compiling
- [ ] Builds the graph at the app entry point, passing only direct dependencies
Must not:
- [ ] Introduce a global container or service locator passed into every feature

### E19 — testing: mock-heavy suite
Requester: Mobile Developer
Prompt: "Our tests mock every repository and use case, yet bugs still ship. Why?"
Must:
- [ ] Explains mocks between own classes leave the real seams untested
- [ ] Moves fakes down to the transport/DB/clock and tests the feature through real code

### E20 — feature built top-down
Requester: Non-mobile Developer
Prompt: "Build a course to-do list feature; the backend API isn't ready yet."
Must:
- [ ] Models domain and state holder first with no UI framework imports, stubbing the repository
- [ ] Doesn't block on the missing API: stubs it, marks the assumption, proposes the contract
- [ ] Models exclusive states as one enum/sealed type, not parallel booleans

### E21 — agent-ready-codebase: set up for agents
Requester: Mobile Developer
Prompt: "We want agents to do more of our Flutter work with less review. Set the project up for that."
Must:
- [ ] Creates `.maestro/feature-map.md` from the template, one entry per reachable screen
- [ ] Adds `Semantics(identifier:)` IDs and at least one Maestro flow for a critical path
- [ ] Runs `harness/verify --flow …` and reports the proof folder
- [ ] Adds at least one guardrail (lint or boundary) with a baseline
Must not:
- [ ] Select UI elements by visible text in flows

### E22 — vague bug report
Requester: Business Owner
Prompt: "A customer sent this screenshot of a blank screen with '???' — fix it." (project has a Feature Map)
Must:
- [ ] Uses the Feature Map to identify candidate screens and their prerequisites
- [ ] Reproduces with a flow before changing code, or asks for the one missing detail
- [ ] Reports in plain language with the proof

### E23 — codebase-gardening: spreading workaround
Requester: Mobile Developer
Prompt: "Agents keep adding `// temporary fix` retries everywhere. Clean this up."
Must:
- [ ] Counts occurrences and recent growth (`git log -S`)
- [ ] Converges on one retry path or deletes, in small PRs
- [ ] Adds a lint or CI rule so new occurrences fail

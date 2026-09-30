# Evals — Release & Ops

### R1 — ios-store-submission: first release
Requester: Business Owner
Prompt: "The app is finished. How do we get it on the App Store next week?"
Must:
- [ ] Checks account ownership (organization, company-owned) and warns about enrollment lead time
- [ ] Covers privacy manifest, App Privacy answers, purpose strings, account deletion, demo account for review
- [ ] Recommends TestFlight first and gives a time range, not a promise of "next week"
- [ ] Says store rules change and to verify the current guidelines
Must not:
- [ ] Guarantee approval or a review duration

### R2 — android-store-submission: new personal account
Requester: Non-mobile Developer
Prompt: "I made a Play developer account yesterday. How do I publish my app to production?"
Must:
- [ ] Mentions the closed-testing requirement for new personal accounts and says to verify current numbers
- [ ] AAB, Play App Signing, targetSdk requirement, Data safety form
- [ ] Staged rollout with a halt rule based on Android vitals
Must not:
- [ ] Suggest uploading an APK signed with a key kept only on a laptop

### R3 — signing-certificates: lost keystore
Requester: Mobile Developer
Prompt: "Our Android dev left and we can't find the keystore. Can we still update the app?"
Must:
- [ ] Asks whether the app uses Play App Signing; if yes, explains the upload key reset path
- [ ] If not, says plainly that updates under the same app may be impossible and what the options are
- [ ] Proposes an inventory with two owners per key and secrets in a manager
Must not:
- [ ] Give a confident answer without knowing whether Play App Signing is enabled

### R4 — ci-cd-setup: laptop releases
Requester: Mobile Developer
Prompt: "We release from my MacBook. Set up CI with GitHub Actions for our React Native app."
Must:
- [ ] PR pipeline (lint, tests, builds) and main pipeline (signed builds, CI build number, symbol upload, store upload)
- [ ] Secrets in CI, App Store Connect API key, pinned Xcode
- [ ] Production release stays a manual step
- [ ] Verifies by breaking a test and by seeing a TestFlight build appear
Must not:
- [ ] Commit keystores or passwords to the repo

### R5 — crash-monitoring: unreadable crashes
Requester: Mobile Developer
Prompt: "Crashlytics shows crashes but the stack traces are just memory addresses."
Must:
- [ ] Identifies missing symbol upload (dSYM / mapping / debug symbols) as the cause
- [ ] Automates the upload in CI for every build
- [ ] Verifies with a test crash from a release build
Must not:
- [ ] Suggest disabling code shrinking to get readable traces

### R6 — analytics-plan: "track everything"
Requester: Business Owner
Prompt: "Add analytics. Track everything so we can figure it out later."
Must:
- [ ] Pushes back: starts from 3–5 business questions
- [ ] Consistent event naming, no personal data, consent where required, privacy disclosures updated
- [ ] Verification in debug view before release
Must not:
- [ ] Add autocapture of every tap without discussing privacy and cost

### R7 — versioning-force-update: critical bug in old version
Requester: Non-mobile Developer
Prompt: "Version 2.3 has a bug that corrupts orders. How do we force everyone off it?"
Must:
- [ ] Checks whether a min-version check already exists in 2.3; if not, says it can't be added retroactively and proposes a backend "update required" error instead
- [ ] Numeric version comparison, cached config, fail-open on malformed config
- [ ] Lets unsent local data sync before blocking where possible
Must not:
- [ ] Propose a solution that only works for future versions without saying so

### R8 — store-rejection-fix: guideline rejection
Requester: Business Owner
Prompt: "Apple rejected us: 'Guideline 3.1.1 - Business - Payments - In-App Purchase'. What now?"
Must:
- [ ] Fetches or asks for the current guideline text and the full rejection message
- [ ] Explains in plain words that it affects the business model and lists the options for a product decision
- [ ] Drafts a reply to the reviewer
Must not:
- [ ] Recommend hiding the payment flow from reviewers

### R9 — ota-updates: native change via OTA
Requester: Mobile Developer
Prompt: "I added a new camera library. Can I ship it with EAS Update tonight?"
Must:
- [ ] Says no: a new native dependency needs a new binary and a runtime version bump
- [ ] Explains runtime version protection and offers what can ship OTA
Must not:
- [ ] Suggest disabling the runtime version check

### R10 — app-size-reduction: 180 MB app
Requester: Mobile Developer
Prompt: "Our Flutter app is 180 MB. Make it smaller."
Must:
- [ ] Measures the real download size per platform first and finds the top 5 contributors
- [ ] Fixes largest first (assets, dependencies, ABI splits via AAB, split debug info)
- [ ] Adds a CI size budget
Must not:
- [ ] Guess causes without measuring

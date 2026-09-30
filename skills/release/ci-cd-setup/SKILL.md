---
name: ci-cd-setup
description: Set up CI/CD for a mobile app: build, test, sign and upload to TestFlight and Play testing tracks on every merge, with reproducible versions and secrets kept out of the repo. Use when asked to automate builds or releases, add CI, or when releases depend on one person's laptop.
---

# CI/CD Setup

Every release built by a machine, from a commit, the same way every time [S15]. A release that needs someone's laptop is a single point of failure.

## Blocking Questions
1. CI host? — Recommended: whatever the repo already uses (GitHub Actions, GitLab, Bitrise, Xcode Cloud); Expo projects → EAS Build [S90].
2. How far to automate? — Recommended: PR → build + tests; merge to main → internal/TestFlight upload; production release stays a manual button.

## Steps
1. **Pipeline per PR**: lint, unit tests, build both platforms in debug. Target: under ~15 minutes, or developers stop waiting for it. Cache dependencies (Gradle, CocoaPods/SPM, pub, npm).
2. **Pipeline on main**: release build, sign ([signing-certificates](../signing-certificates/SKILL.md)), set the build number from CI (run number or timestamp; monotonic), upload symbols (dSYM, R8 mapping), upload to TestFlight and the Play internal track.
3. **Tooling**: fastlane [S86] lanes (or EAS / Xcode Cloud / Gradle Play Publisher) so the same command runs locally and in CI.
4. **Secrets**: signing material, API keys for stores and services in CI secrets; scoped to protected branches; never echoed in logs. App Store Connect API key instead of an Apple ID with 2FA.
5. **macOS runners** for iOS: pin the Xcode version; expect them to cost more and queue longer.
6. **Release pipeline**: tag or release branch → build → submit for review / promote track, with release notes from commits ([references/core/release.md](../../../references/core/release.md)).
7. **Verify**: break a test and see the PR fail; merge and see a build appear in TestFlight and Play internal testing.

## Output
Pipeline config files plus:
```
Triggers: PR → …, main → …, tag → …
Secrets needed: name — where to get it — who owns it
Manual steps left: …
```
For a Business Owner: "releases no longer depend on one person's computer" and the monthly CI cost range.

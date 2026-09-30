---
name: ios-store-submission
description: Prepare and submit an iOS app (first release or update) to App Store Connect, from build to phased release, with the privacy, metadata and review items that cause rejections. Use when asked to "publish to the App Store", "submit to Apple", set up TestFlight, or plan an iOS release.
---

# iOS Store Submission

App Review is a gate you don't control, and a shipped binary can't be recalled ([mindset/constraints.md](../../../mindset/constraints.md) §4). Store rules change often: check the current App Store Review Guidelines [S9] before relying on anything below.

## Blocking Questions
1. Apple Developer account owned by the Requester's company (organization, not personal)? — Recommended: yes; enrolling an organization needs a D-U-N-S number and can take days, so start now.
2. First release or update? — Recommended: first release → budget extra review time and a TestFlight beta first.

## Steps
1. **Account and identifiers**: bundle ID, App Store Connect record, capabilities (push, sign in with Apple, associated domains) enabled on the App ID. Signing via [signing-certificates](../signing-certificates/SKILL.md).
2. **Build**: version and build number bumped ([versioning-force-update](../versioning-force-update/SKILL.md)), release configuration, current required Xcode/SDK (Apple raises the minimum yearly; verify), dSYMs uploaded to crash reporting.
3. **Privacy**: privacy manifest for the app and every SDK that needs one [S36]; App Privacy "nutrition label" answers match what the app and its SDKs actually collect [S99]; purpose strings on every permission, in End User language; App Tracking Transparency prompt if you track [S102].
4. **Compliance items reviewers check** [S9]: account deletion in-app if accounts can be created; Sign in with Apple when third-party login is offered (check the current rule and its exceptions); digital goods sold through In-App Purchase; a demo account and notes for review if login is required; no placeholder content or broken links.
5. **TestFlight** [S100]: internal testers first, then an external group (external builds get a short beta review). Done when the release checklist in [references/core/release.md](../../../references/core/release.md) passes on real devices.
6. **Metadata**: name, subtitle, description, keywords, support and privacy policy URLs, screenshots for required device sizes ([store-assets](../../design/store-assets/SKILL.md)), age rating, "What's New".
7. **Submit** [S81] with manual release or phased release [S97] (7-day ramp, pausable). Use manual release when marketing or backend timing matters.
8. **After release**: watch crash-free rate and reviews daily during the ramp; pause the phased release on a spike. The fix path is a flag off, then a new build ([crash-monitoring](../crash-monitoring/SKILL.md)).
9. **Rejected** → [store-rejection-fix](../store-rejection-fix/SKILL.md).

## Output
```
Ready: yes | blocked by …
Checklist: item — done | missing — owner
Review notes for Apple: demo login, how to reach the feature
Release: manual | phased — date — watch metrics
```
For a Business Owner: time from "code done" to "in End Users' hands" as a range, and what they must provide (account, legal texts, screenshots approval).

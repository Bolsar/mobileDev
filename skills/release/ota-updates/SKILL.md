---
name: ota-updates
description: Set up or review over-the-air (OTA) updates for React Native (Expo EAS Update, others) or Flutter (Shorebird) within store rules, with channels, rollback and binary-compatibility checks. Use when asked to "hotfix without a store release", set up EAS Update or Shorebird, or when an OTA update broke the app.
---

# OTA Updates

OTA replaces interpreted code (JS bundle, Dart code patches) without a store release. It can't change native code, permissions or the app's purpose, and store rules limit what it may do: fixes and small changes yes, new features that change the app's purpose no. Check current Apple guidelines [S9] and the Play Device and Network Abuse policy [S10]. Native apps (Swift/Kotlin) have no OTA; use flags and remote config instead ([feature-flags-experiments](../../product/feature-flags-experiments/SKILL.md)).

## Blocking Questions
1. Stack and tool? — Recommended: Expo → EAS Update [S89]; bare React Native → EAS Update too; Flutter → Shorebird [S91].

## Steps
1. **Runtime version**: every update targets a runtime/binary version, and the tool must refuse to deliver JS/Dart that needs native code the installed binary doesn't have. Bump it whenever native code or native dependencies change. Done when a native change can't be shipped OTA by mistake.
2. **Channels**: `production`, `staging` (or per release branch) mapped to store builds; test an update on staging builds before promoting.
3. **Load policy**: check on launch, apply on next launch (not mid-session) unless the fix is critical; set a timeout so a slow network never blocks startup.
4. **Rollback**: know the one command that republishes the previous update; the tool should also fall back to the embedded bundle when an update crashes on launch. Test it once before you need it.
5. **Rollout**: percentage rollout where the tool supports it; watch crash-free rate per update ID ([crash-monitoring](../crash-monitoring/SKILL.md)); upload source maps/symbols for every update.
6. **Security**: code signing of updates if the tool supports it; publish only from CI.
7. **Scope discipline**: OTA for bug fixes and copy/config changes. Features still go through store review with a new binary.

## Output
```
Tool: … — runtime version policy: …
Channels: channel — builds
Rollout & rollback: …
Allowed via OTA: … / Needs store release: …
```
For a Business Owner: "we can fix most bugs in hours instead of days, but not everything, and not new features."

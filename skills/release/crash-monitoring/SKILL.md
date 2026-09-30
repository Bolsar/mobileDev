---
name: crash-monitoring
description: Set up crash and ANR reporting with symbolication, alerts and a triage routine, and use it during rollouts. Use when adding crash reporting, when crashes are reported but can't be read, when planning a release, or when asked "is the app stable?".
---

# Crash Monitoring

You can't reproduce what you can't see. Crash reporting ships in the first release, not after the first bad review. Debugging a specific crash → [debug-crash](../../engineering/debug-crash/SKILL.md).

## Blocking Questions
1. Tool? — Recommended: Firebase Crashlytics [S96] if already on Firebase; Sentry if you also want performance and non-fatal errors across platforms; keep one tool.

## Steps
1. **Install** the SDK early in app start, in release builds. Cross-platform: the plugin that captures both native and Dart/JS crashes.
2. **Symbolication**: upload dSYMs (iOS), R8/ProGuard mapping (Android), source maps (React Native), debug symbols (Flutter) from CI for every build ([ci-cd-setup](../ci-cd-setup/SKILL.md)). Done when a test crash from a release build shows readable file and line.
3. **Context**: app version, build, user ID as an opaque ID (no email or name), breadcrumbs for screen views and key actions. Scrub personal data ([references/core/security.md](../../../references/core/security.md)); declare it in privacy forms.
4. **Non-fatals**: log caught errors that mean a broken End User flow (payment failed, sync failed), not every exception.
5. **ANRs and hangs**: watch Android vitals [S20] and the platform's hang reports; they count against store ranking.
6. **Alerts**: on a new crash in the latest release, and on crash-free sessions/users dropping below a threshold you pick (a common target is ≥ 99.5% crash-free users; set yours from your baseline).
7. **Triage routine**: during a rollout, check daily; rank by users affected × severity; each top crash gets an owner and a ticket ([write-ticket](../../collaboration/write-ticket/SKILL.md)).
8. **Rollout gate**: define the numbers that pause a phased release or halt a staged rollout before release day.

## Output
```
Tool: … — symbols uploaded for: iOS | Android | JS/Dart
Alerts: condition — channel
Rollout gate: crash-free ≥ …, ANR ≤ …
Top crashes: issue — users affected — since version — owner
```

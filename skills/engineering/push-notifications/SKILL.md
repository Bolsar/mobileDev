---
name: push-notifications
description: Implement push notifications end to end (permission, token registration, payloads, tap routing, channels). Use when adding push, when notifications don't arrive or open the wrong screen, or when planning notification permission UX.
---

# Push Notifications

Delivery: APNs on iOS [S41], FCM on Android (and optionally iOS) [S40]. Buy delivery; build your own targeting logic on your backend.

## Blocking Questions
1. What notifications, and why would the End User want each? — Recommended: list them; drop any without a clear End User benefit.
2. Provider? — Recommended: FCM for both platforms unless the backend already talks to APNs directly.
3. Rich content (images) or actions (reply, mark done)? — Recommended: none in v1.

## Steps
1. **Permission in context.** Ask at the moment the value is obvious (after the first order, not at launch), with a pre-prompt explaining why. Android 13+ needs the `POST_NOTIFICATIONS` runtime permission [S42]. iOS can use provisional authorization for quiet delivery. Design the denied path: an in-app banner linking to Settings. See [mindset/constraints.md](../../../mindset/constraints.md) §7.
2. **Token lifecycle.** Register the token with the backend (user, device, platform, app version, locale). Re-send on refresh. Delete on sign-out. Done when sign-out stops pushes to that device.
3. **Payload contract** with backend: type, target route, IDs. No sensitive data in the payload; it shows on the lock screen and passes through third parties. Fetch details in-app.
4. **Tap routing** through the deep link router ([navigation-deeplinks](../navigation-deeplinks/SKILL.md)), for cold start, background and foreground.
5. **Foreground presentation.** Decide per type: banner, in-app UI, or silent refresh.
6. **Android channels** (8+): one per category, named for the End User, who can mute each.
7. **Silent/data pushes** are best-effort. The OS throttles or drops them; never rely on them for correctness.
8. **Test**: iOS simulator via `xcrun simctl push booted <bundle-id> payload.apns`; Android via FCM test send. Test killed-app tap, denied permission, and sign-out.

## Output
Notification inventory (type, trigger, End User benefit, route, channel), permission flow, payload contract, test results. Verify on real devices: simulator/emulator push behavior differs.

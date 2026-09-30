---
name: navigation-deeplinks
description: Structure app navigation and implement deep links (Universal Links, Android App Links, push-tap routing). Use when adding routes, tabs or flows, making links open the app, or debugging a link that opens the browser or the wrong screen.
---

# Navigation & Deep Links

Per-platform navigation conventions: [references/core/ux-platform.md](../../../references/core/ux-platform.md).

## Blocking Questions
1. Which screens must be reachable by link? — Recommended: content End Users share, plus every push target.
2. Do you own a web domain for verified links? — Recommended: yes; custom URL schemes only as a fallback.
3. Deferred deep links (link → install → land on content)? — Recommended: skip for v1. It needs a third-party attribution SDK; check which are current. Firebase Dynamic Links is shut down.

## Steps
1. **Route map.** One table: route, path pattern, parameters, auth required, screen. Done when every link and push target is a row.
2. **One entry point.** Links, push taps and in-app navigation all go through the same router. No screen-specific parsing.
3. **Verified links.** iOS Universal Links: associated domains entitlement plus `apple-app-site-association` on the domain [S38]. Android App Links: `autoVerify` intent filters plus `assetlinks.json` with each signing certificate's SHA-256, including the Play App Signing key [S39]. Verify the current file formats in the docs.
4. **Validate input.** Treat every parameter as untrusted: type-check, reject unknown routes to a safe fallback screen, never execute actions (payments, deletes) straight from a link without confirmation.
5. **Auth gate.** Signed out? Stash the target, sign in, then resume to it.
6. **Back stack.** A cold-start link builds a sensible stack (home → detail) so back doesn't exit the app.
7. **Test** cold start, warm start and signed out:
   - iOS: `xcrun simctl openurl booted "<url>"`
   - Android: `adb shell am start -W -a android.intent.action.VIEW -d "<url>" <package>`; check verification with `adb shell pm get-app-links <package>`.

## Output
Route table, router code, the two domain association files, test commands and results.

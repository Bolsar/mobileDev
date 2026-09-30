---
name: store-assets
description: Plan and produce App Store and Google Play listing assets (icon, screenshots, preview video, feature graphic, title, subtitle, description) that convert and pass review. Use before a first release, a redesign, or when installs from store page views are low.
---

# Store Assets

The store page is the app's landing page, and the screenshots do most of the selling. Sizes and limits change: **check the current specs before producing files** [S57][S58][S63][S68]; the numbers here are orientation only.

## Blocking Questions
1. Target markets and languages? — Recommended: localize screenshots and text for every language the app supports.
2. Who produces the art? — Recommended: agent writes the plan, captions and capture script; a designer or template tool does the framing.
3. Preview video? — Recommended: not for v1; add once screenshots are proven.

## Steps
1. **Message.** 3–5 benefits in End User words, ordered by why people install. Done when each fits in ~5 words as a caption.
2. **Screenshot plan.** One benefit per screenshot, first 2–3 carry the pitch (they show in search results). Real app UI with realistic, non-personal demo data. Caption above the UI, large enough to read as a thumbnail.
3. **Capture automatically** where possible: fastlane `snapshot`/`screengrab`, or UI tests driving demo data per locale, so every size and language regenerates in one run. Status bar cleaned (demo mode).
4. **Icon.** Simple shape readable at small sizes; no text or screenshots inside; iOS master without transparency (the system rounds it); Android adaptive icon with foreground/background layers and the safe zone respected [S69][S70].
5. **Text.** Title and subtitle/short description carry the main keyword and benefit, no keyword stuffing, no competitor names, no price or "#1" claims you can't back [S9][S10].
6. **Platform extras.** Google Play feature graphic; iOS optional app preview video (captured in-app footage); both need dark/light consideration only if the UI shows it.
7. **Policy check.** Screenshots show the actual app, features shown exist in this build, no misleading content, ratings-appropriate imagery. Mismatch is a common rejection cause ([store-rejection-fix](../../release/store-rejection-fix/SKILL.md)).
8. **Measure.** Product Page Optimization (iOS) / store listing experiments (Play) to A/B screenshots after launch.

## Output
```
Benefits → captions (per locale): …
Screenshot 1..n: screen · demo data · caption
Icon notes · Text: title / subtitle / short description
Capture: tool + command
Specs verified against: <link, date>
```

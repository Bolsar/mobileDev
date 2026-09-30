---
name: migrate-legacy-ui
description: Plan and run an incremental UI framework migration (UIKit to SwiftUI, Android Views to Jetpack Compose, or an old design system to a new one). Use when the Requester wants to modernize UI code or mix old and new UI frameworks.
---

# Migrate Legacy UI

Migrate screen by screen inside the running app. Never a big-bang rewrite: it freezes features and ships every bug at once.

## Blocking Questions
1. Why migrate: velocity, hiring, a redesign, new platform features? — Recommended: tie the plan to that reason; it decides the order.
2. Features keep shipping during the migration? — Recommended: yes; new screens in the new framework, old ones migrate when touched.
3. Min OS allows the new framework's APIs you need? — Check the project; flag gaps.

## Steps
1. **Inventory.** List screens with size, change frequency and custom-component use. Done when every screen has a row.
2. **Interop first.** Prove old and new coexist: iOS `UIHostingController` / `UIViewRepresentable` [S49]; Android `ComposeView` / `AndroidView` [S48]. Share theme tokens across both so screens match.
3. **Design system components first**, in the new framework, matching the old look.
4. **Order**: new screens → leaf screens that change often → complex shared screens last. Navigation shell last, if ever.
5. **Guard behavior.** Before migrating a screen, add screenshot tests or record its states; after, compare. A migration changes code, not behavior. Keep it out of feature commits ([references/core/clean-code.md](../../../references/core/clean-code.md)).
6. **Delete** the old screen and its dead resources in the same PR that replaces it.
7. **Track** progress as a count (screens migrated / total) in status reports.

## Output
Screen inventory with order, interop pattern, the first 3 screens, the rule for new work, and risks (min OS gaps, performance of interop in lists, accessibility regressions).

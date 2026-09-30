---
name: design-system-setup
description: Set up or consolidate design tokens and UI primitives (color roles, type scale, spacing, radius, elevation, motion) wired into the platform theme, light and dark. Use at project start, when view code is full of hardcoded values, or when designs arrive with a style guide.
---

# Design System Setup

Small and boring: tokens plus a handful of primitives, mapped onto the platform's own theme so native components pick them up for free. Not a component library for its own sake.

## Blocking Questions
1. Source of truth? — Recommended: Figma variables/styles if they exist (read them via Figma MCP when the tool offers it), otherwise code is the source.
2. Brand constraints (colors, font)? — Recommended: platform system font, one brand accent; derive the rest.
3. Existing project with scattered values? — Recommended: consolidate what's there, don't restyle in the same change.

## Steps
1. **Inventory.** Existing project: grep hex colors, font sizes, paddings, radii in view code. Done when you have the list of distinct values and how often each appears. Collapse near-duplicates (`#333`/`#343434`).
2. **Color as roles, not names.** `background`, `surface`, `onSurface`, `primary`, `onPrimary`, `outline`, `error`, `success`… each with a light and dark value [S62][S66]. Views never reference a raw palette value. Check contrast for every text/background pair ([references/core/accessibility.md](../../../references/core/accessibility.md)).
3. **Type scale** mapped to platform text styles so it scales with the End User's setting: iOS Dynamic Type styles (`.body`, `.headline`), Android `sp` through the Material type scale, Flutter `TextTheme`, React Native with `allowFontScaling` kept on [S67]. 5–7 styles total.
4. **Spacing, radius, elevation, motion.** Spacing on a 4/8 scale (4, 8, 12, 16, 24, 32…), 2–3 radii, 2–3 elevation levels, 3 durations (short/medium/long) ([motion-and-feedback](../motion-and-feedback/SKILL.md)).
5. **Wire into the platform theme**: SwiftUI asset-catalog colors + environment/`ShapeStyle` extensions; Compose `MaterialTheme` (`colorScheme`, `typography`, `shapes`) + a small `CompositionLocal` for extras; Flutter `ThemeData` + `ThemeExtension`; React Native one theme object via context, with `useColorScheme`. Stack Pack detail: `references/stacks/<stack>/`.
6. **Primitives, named by what they are** [S56] ([references/core/clean-code.md](../../../references/core/clean-code.md)): `PrimaryButton`, `SubduedButton`, `ThumbnailRow`, `CalloutView`, `SectionHeader`, `EmptyStateView`. Not `ProfileCard` or `BlueButton`. Each is presentational: data and callbacks in, no fetching. Few config flags; a new variant is a new small primitive.
7. **Migrate** call sites in small commits, one token group at a time, screenshots before/after. No visual changes mixed in.
8. **Guard it.** A lint rule or grep in CI for raw hex/`Color(0x…)`/numeric paddings in feature code. Optional: DTCG-format JSON as the shared token file if design and code both consume it [S61].

## Output
Token table (role → light/dark value), type scale → platform style mapping, list of primitives with one-line purpose, files changed, and the contrast pairs that were checked.

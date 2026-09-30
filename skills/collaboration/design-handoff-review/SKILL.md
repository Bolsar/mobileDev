---
name: design-handoff-review
description: Check a design handoff (Figma file, mockups, spec) for everything a mobile build needs before work starts, and return one batched list of gaps to the designer. Use when designs arrive for a feature, before estimating or building from them.
---

# Design Handoff Review

Find the gaps now, while fixing them costs a comment, not a rebuild. Read the design through Figma MCP when available, otherwise screenshots or exported specs. Judge completeness, not taste; taste is [design-critique](../../design/design-critique/SKILL.md).

## Steps
1. **List the screens and flows** in the handoff. Done when each screen maps to a step in a flow and every flow has an entry point (launch, push, deep link, other screen).
2. **Run the checklist** on every screen. Done when each item is either covered or logged as a gap.
3. **Map to the system.** Colors, type, spacing and components should map to existing tokens and components ([design-system-setup](../../design/design-system-setup/SKILL.md)). Log every one-off value as "new token or mistake?".
4. **Flag platform conflicts**: iOS patterns drawn for Android (or the reverse), custom controls where a platform one exists ([references/core/ux-platform.md](../../../references/core/ux-platform.md)).
5. **Send one batched list** to the designer, grouped by screen, each gap with a proposed default so they can answer "yes" instead of redrawing.

## Checklist
- **States**: loading, empty, error, offline, permission denied, partial data ([mindset/planning.md](../../../mindset/planning.md) §2).
- **Content extremes**: long names, 0 / 1 / 10,000 items, missing image, translated text ~30–40% longer, RTL if supported.
- **Screens**: smallest and largest supported phone, tablet if supported, landscape if supported, keyboard open on forms.
- **Themes and text**: dark mode, 200% text size.
- **Platforms**: one design per platform, or an explicit "same on both, native controls".
- **Interaction**: tap targets ≥ 44pt/48dp, pressed/disabled/focused states, gestures and their visible alternative, motion spec (duration, easing) or "use platform default".
- **Copy**: final strings, error messages that say what to do, empty-state copy.
- **Assets**: vectors (SVG/PDF) or raster at 1x/2x/3x and mdpi–xxxhdpi, app icon sources, fonts licensed for app embedding.
- **Data**: every field on screen exists in the API, or is flagged to [api-contract](../api-contract/SKILL.md).

## Output
```
Ready to build: yes | after gaps below
<Screen> — gap — proposed default
New tokens/components requested: …
API fields not in contract: …
```
For a Business Owner: "N gaps; M block building, the rest we can default", with the blocking ones listed in plain words.

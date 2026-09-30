---
name: ui-anti-slop
description: Rules that keep generated UI from looking generic or AI-made, and keep it native, accessible and token-driven. Load before writing or changing any UI code, in every skill that touches UI.
---

# UI Anti-Slop

"Slop" is UI that looks like every other AI-generated screen: decoration instead of hierarchy, web patterns on a phone, placeholder copy, missing states. The fix is restraint plus platform conventions ([references/core/ux-platform.md](../../../references/core/ux-platform.md)).

## Rules
1. **Existing design wins.** Designs, a design system or house components in the project → use them exactly. These rules fill the gaps; they never override a real design.
2. **Platform components first.** Native navigation, lists, pickers, sheets, alerts, back behavior [S5][S6]. A custom control needs a reason written down.
3. **Tokens only.** Every color, spacing, font, radius and duration comes from the theme ([design-system-setup](../design-system-setup/SKILL.md)). No hex codes or magic numbers in views. No theme yet → use the platform defaults (system colors, text styles, Material theme), not invented values.
4. **Hierarchy from weight, size and color, not decoration.** One primary action per screen. Secondary actions look secondary. Two or three text styles per screen, not six [S13].
5. **Real copy.** Specific labels ("Save address", not "Submit"). Error text says what happened and what to do. No lorem ipsum, no "Welcome back! 👋" filler, no exclamation marks in system messages.
6. **Density fits the content.** Lists and rows for repeated data, not a card per item. No cards inside cards. Whitespace from the spacing scale, not random padding.
7. **Every state designed**: loading (skeleton matching the layout), empty (why + one action), error (what + retry), offline, permission denied. No bare spinner in an empty screen, no blank screen.
8. **Accessible by default**: semantic colors that work in dark mode, text that scales with Dynamic Type/font scale, 44pt/48dp targets, labels on icon-only buttons, color never the only signal ([references/core/accessibility.md](../../../references/core/accessibility.md)).
9. **Icons from the platform set** (SF Symbols, Material Symbols) at one consistent weight. No emoji as icons. Mystery icons get a text label [S14].
10. **Motion only with meaning** ([motion-and-feedback](../motion-and-feedback/SKILL.md)).

## Banned by default
Unless the brand or design asks for it: purple-to-blue gradients · glassmorphism/blur on everything · drop shadows on every surface · centered-everything layouts · oversized hero headers on utility screens · mixed corner radii · rainbow status colors · custom back buttons · hamburger menu when there are ≤ 5 destinations (use tabs/navigation bar) · stock illustrations in empty states that say nothing · web-style hover states and tooltips as the only way to explain.

## Self-check before "done"
- [ ] No hardcoded colors, sizes or strings in the view code
- [ ] Every state from the screen inventory renders
- [ ] Checked in dark mode, at the largest text size, on the smallest and largest screen
- [ ] Every interactive element has a label and a big enough target
- [ ] Looks like it belongs on this platform next to the system apps

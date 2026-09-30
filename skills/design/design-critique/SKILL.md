---
name: design-critique
description: Critique a screen, screenshot, mockup or Figma frame for hierarchy, platform fit, states, accessibility and copy, with ranked, fixable findings. Use when asked "what do you think of this design?", after building UI, or before a design handoff.
---

# Design Critique

Judge whether the End User can do the job fast and without doubt on this platform, not whether it matches your taste. Read the input: code, screenshot, or a Figma frame through Figma MCP when available. Rendering it yourself (preview, simulator screenshot) beats reading code.

## Steps
1. **Name the screen's job and primary action.** Can't find it in 5 seconds → that's finding #1.
2. **Apply every lens below.** Done when each lens is clean or has findings.
3. **Rank**: blocker (End User can't complete the job, or can't with a screen reader / large text), major (slows or confuses), minor (polish).
4. **Suggest the smallest fix** per finding, using existing tokens and platform components.

## Lenses
- **Hierarchy**: one primary action, visually dominant; secondary actions quieter; scan order matches importance [S13].
- **Platform fit**: navigation, back, dialogs, pickers and controls behave like the platform ([references/core/ux-platform.md](../../../references/core/ux-platform.md)). Cross-platform: same brand, native patterns.
- **States**: loading, empty, error, offline, permission denied, partial data. Long names, zero and huge counts, missing images.
- **Accessibility**: contrast in light and dark, target sizes, labels, layout at 200% text, color-only signals ([references/core/accessibility.md](../../../references/core/accessibility.md)).
- **Copy**: specific verbs on buttons, errors that tell what to do, no jargon, text that survives translation (~30–40% longer in German/Russian).
- **Ergonomics**: frequent actions in thumb reach, destructive actions separated and confirmed or undoable [S35].
- **Consistency**: values from tokens, same pattern for the same thing across screens.
- **Slop**: anything on the [ui-anti-slop](../ui-anti-slop/SKILL.md) banned list without a brand reason.
- **Heuristics check** [S31]: status visible, undo available, recognition over recall.

## Output
```
Job / primary action: …
Blocker: region — problem — why it hurts the End User — fix
Major / Minor: …
Can't judge from this input: … (e.g. motion, real content length)
```
For a Business Owner, lead with the 3 findings that most affect conversion or support tickets, in plain words.

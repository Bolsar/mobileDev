---
name: accessibility-audit
description: Audit screens for accessibility (screen readers, touch targets, dynamic type, contrast, motion) and fix findings. Use before release, after a redesign, or when asked "is this accessible?"
---

# Accessibility Audit

The bar: [references/core/accessibility.md](../../../references/core/accessibility.md). WCAG 2.2 [S12] for contrast and criteria numbers; platform guides [S29a][S29b].

## Steps
1. **Pick the flows**: the critical End User journeys, not every screen. Done when listed.
2. **Code pass.** For each screen check: labels on every interactive element and meaningful image; decorative images hidden; custom controls expose role, state and value; touch targets ≥ 44pt/48dp; no fixed-height text containers; color never the only signal; contrast of text and icons in light and dark.
3. **Tool pass.** Xcode Accessibility Inspector audit; Android Accessibility Scanner; Flutter `meetsGuideline` tests; React Native accessibility props lint. Record what each tool flags.
4. **Manual pass** (tools miss most of it): complete each flow with only VoiceOver/TalkBack; again at the largest font size; again with Reduce Motion on. Done when each flow is completed or the blocking point is recorded.
5. **Fix** blockers first (flow can't be completed), then the rest. Prefer platform components, which carry semantics for free.

## Output
```
Flows tested: …
Blocker: screen — element — problem — WCAG ref — fix
Major / Minor: …
Can't verify here (needs a real device run): …
```

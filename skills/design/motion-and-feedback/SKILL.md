---
name: motion-and-feedback
description: Add animation, transitions, loading feedback and haptics that explain what happened, feel native and respect Reduce Motion. Use when adding transitions or micro-interactions, when the app "feels unresponsive", or when choosing skeleton vs spinner vs optimistic update.
---

# Motion and Feedback

Motion earns its place by answering "did it work?", "where did that go?" or "what's happening?". Everything else is decoration [S59][S60].

## Rules
- **Feedback within 100ms** of every tap: pressed state at minimum [S31]. Longer work shows progress.
- **Choose loading feedback by wait and certainty:**
  | Situation | Use |
  |---|---|
  | Action very likely to succeed (like, toggle, reorder) | Optimistic update, roll back with a message on failure |
  | Content loading with a known layout | Skeleton matching that layout |
  | Short action (< ~2s), unknown layout | Inline spinner on the control, control disabled |
  | Long action with measurable progress | Determinate progress + ability to leave the screen |
- **Durations from tokens**: roughly 100–200ms for small state changes, 200–400ms for screen/sheet transitions. Prefer the platform's springs and default transitions over custom curves.
- **Motion shows relationships**: a sheet rises from where it's anchored, a deleted row collapses, a new item appears where it lands. No motion that contradicts navigation direction.
- **Never block input** with animation. Interruptible, and taps during a transition still work.
- **Reduce Motion**: replace movement and parallax with fades or nothing (`UIAccessibility.isReduceMotionEnabled` / `accessibilityReduceMotion`, Android animator duration scale, Flutter `MediaQuery.disableAnimations`, RN `AccessibilityInfo.isReduceMotionEnabled`). Nothing essential lives only in an animation.
- **Performance**: animate transform and opacity, not layout; no dropped frames on a mid-range device ([references/core/performance.md](../../../references/core/performance.md)).
- **Haptics**: sparse and meaningful: success, error, selection change, reaching a threshold. Use the platform's semantic haptics, not raw vibration patterns. Never on every tap or scroll [S64][S65].

## Steps
1. List the moments that need feedback in the flow: taps, loads, saves, errors, arrivals.
2. Pick the feedback per moment from the table and rules above.
3. Implement with platform animation APIs and duration tokens.
4. **Verify**: on a real mid-range device, with Reduce Motion on, with slow network (Network Link Conditioner / emulator throttling) so loading states actually show.

## Output
Moment → feedback chosen → why, then files changed and what to check on device (Reduce Motion on, slow network, frame rate).

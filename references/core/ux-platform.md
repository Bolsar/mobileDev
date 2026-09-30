# UX & Platform Conventions

## Principles
- **Platform-native beats custom.** End Users know their platform: iOS back-swipe, Android system back, share sheets, pickers. Fight them only with a reason. [S5][S6]
- **One primary action per screen.** Build a visual hierarchy from size, weight and color, not only borders. [S13]
- **Don't make them think.** Obvious labels, familiar patterns, no mystery icons without labels. [S14]
- **Feedback within 100ms**: pressed state, progress, optimistic updates. [S31]
- **Fitts's law**: big targets in thumb reach for frequent actions. Keep destructive actions away from primary ones. [S35]

## iOS vs Android differences to respect
| Topic | iOS | Android |
|---|---|---|
| Back | Swipe from edge, nav-bar back button | System back gesture/button (predictive back) |
| Top-level nav | Tab bar (bottom) | Navigation bar (bottom) / rail on large screens |
| Primary action | Nav bar button or inline | FAB or top app bar action |
| Dialogs | Alerts, action sheets | Material dialogs, bottom sheets |
| Typography | SF Pro, Dynamic Type styles | Roboto/system, Material type scale, sp units |
| Haptics | Rich, used for confirmation | Subtler |

Cross-platform apps: share the brand, adapt the navigation and controls per platform.

## Must-have states per screen
Loading (skeletons for content, spinners for short actions) · empty (explain, then a call to action) · error (what happened plus retry) · offline · permission denied.

## Forms
Correct keyboard type, autofill hints (`textContentType` / `autofillHints`), inline validation after blur, keep input on error, scroll the focused field above the keyboard.

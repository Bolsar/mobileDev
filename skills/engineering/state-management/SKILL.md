---
name: state-management
description: Choose, design or fix how an app holds and updates state. Use for "which state library?", screens that show stale or wrong data, state lost after backgrounding, or a bloated global store.
---

# State Management

Defaults per stack: [mindset/decisions.md](../../../mindset/decisions.md) (rubric: state management).

## Classify first
Every piece of state is one of four kinds. Most bugs come from putting one kind in another's home.

| Kind | Example | Home |
|---|---|---|
| UI state | expanded row, field text | the screen's state holder |
| Server state | feed, profile | a cache/query layer or repository (TanStack Query [S55], repository + Flow/Stream) |
| App state | signed-in user, theme | a small app-scope holder |
| Persisted state | drafts, settings | storage, observed by the holder |

## Steps
1. **Inventory.** List the state the screen or app holds and tag each item with its kind. Done when no item is untagged.
2. **Shape.** One immutable state object per screen. Mutually exclusive cases (loading / content / error) as a sealed type or union, never as parallel booleans that can contradict each other.
3. **Flow.** State goes down, events go up. Only the state holder writes state. Side effects (navigation, toasts) as one-shot events or state the UI consumes, per the stack's idiom.
4. **Survive process death.** Save what the End User would miss: form input, current step, selected tab, scroll position of long lists. Use the platform mechanism (SavedStateHandle [S51], `@SceneStorage`, Flutter restoration, or explicit persistence in React Native). Done when "kill app in background, reopen" restores the screen.
5. **Fixing a bug?** Follow [mindset/debugging.md](../../../mindset/debugging.md): find where the correct value turns wrong. Usual causes: two sources of truth, a cache never invalidated, a race between two async loads (cancel the stale one), state mutated off the main thread.
6. **Test** each transition of the state holder with fakes and an injected dispatcher/clock.

## Output
State inventory table, the state type(s), what persists across process death, and a Decision Record if a library was picked.

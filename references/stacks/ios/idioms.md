# iOS — Idioms and Pitfalls

## Concurrency [S103][S112]
- UI state lives on `@MainActor`. Mark state holders `@MainActor`; do heavy work (parsing big payloads, image processing) in a `nonisolated` function or a separate actor.
- Prefer structured concurrency: `.task {}` on views, `async let` and task groups. An unstructured `Task {}` needs an owner that cancels it.
- Check cancellation in long loops (`try Task.checkCancellation()`). A search field must cancel the previous request, or old results overwrite new ones.
- Don't silence `Sendable` errors with `@unchecked Sendable` or `nonisolated(unsafe)` unless you can explain the locking in a comment.
- Mixing Combine, GCD and async/await in one flow is a bug factory. New code: async/await and `AsyncSequence`.

## Lifecycle and process death
- Watch `scenePhase` for foreground/background. Save drafts when it goes to `.background`, not on a timer.
- iOS kills suspended apps without warning. Restore what the End User would miss with `@SceneStorage` (tab, selection, draft ids) and persistence for real data ([state-management](../../../skills/engineering/state-management/SKILL.md)).
- Background work: `BGTaskScheduler` (declare identifiers in Info.plist); the system decides when it runs, so never rely on timing. Uploads that must finish use a background `URLSession`.
- Test it: run from Xcode, background the app, stop it from Xcode (simulates the kill), relaunch.

## SwiftUI
- **Identity:** `ForEach` needs stable ids from the model, never `\.self` on mutable values or array indices. Wrong identity means lost state and broken animations.
- **Keep `body` cheap.** No formatting, sorting or filtering of big collections inside `body`; precompute in the model. Split big views so a change re-renders only the part that uses it.
- **Ownership:** `@State` for values and models the view creates; a plain `let`/`var` for models passed in; `@Bindable` to get bindings into an `@Observable` model. Legacy code: `@StateObject` creates, `@ObservedObject` borrows; mixing them up recreates the model on every parent render.
- `GeometryReader` only when you really need the size; it takes all offered space and breaks layouts. Prefer `containerRelativeFrame`, `ViewThatFits`, layout priorities.
- Use semantic fonts (`.body`, `.headline`) and `@ScaledMetric` for custom sizes so Dynamic Type works. Test at the largest accessibility size.
- `List`/`LazyVStack` for long content; plain `VStack` in a `ScrollView` builds every row up front.
- Preview every state (loading, empty, error, dark, large text) with `#Preview` and stub data.

## Platform rules to remember
- Every privacy-sensitive API needs a purpose string in Info.plist and possibly a privacy-manifest entry [S36]. Missing one is a crash or a rejection.
- App Transport Security blocks plain HTTP. Don't disable it globally; add a narrow exception only if forced.
- Keychain items survive app deletion. Clear them on first launch after reinstall if that matters (a flag in `UserDefaults`, which does not survive).
- Pick the Keychain accessibility class on purpose: `AfterFirstUnlockThisDeviceOnly` for tokens used by background work.
- Gate newer APIs with `if #available` and give the fallback path a real UI, not an empty view.

## Reading an existing project
Check before writing: UIKit vs SwiftUI share, `ObservableObject` vs `@Observable`, Combine usage, DI style (initializers, a container, Factory, TCA dependencies), SPM vs CocoaPods, Swift language mode, min deployment target, test framework (XCTest vs Swift Testing). Match them. If the project uses TCA, follow TCA patterns; don't mix in a second architecture.

## Anti-patterns
- A singleton `APIManager.shared` called from views.
- Force unwraps (`!`) and `try!` on data from the network or disk.
- `DispatchQueue.main.async` sprinkled to fix threading warnings instead of fixing isolation.
- `onAppear` + unstructured `Task` for loading (never cancelled; fires again on every appearance).
- One giant `ContentView` with the entire app's state.

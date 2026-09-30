# Clean Code (mobile-flavored)

- **Names reveal intent.** `isEligibleForFreeShipping`, not `flag2`. Follow the platform's naming conventions [S8].
- **Small functions and small views.** Extract a subview or composable when a block has its own name or state. [S2]
- **Compose simple views; avoid smart ones.** Build screens from small presentational primitives, not one mega-component driven by a dozen config flags. [S56]
- **Name UI primitives by what they are and mean**, not by the feature using them or how they look: `ThumbnailRow`, `CalloutView`, `SubduedButton`, not `TutorProfileView`, `SpeechBubble`, `GrayBorderButton`. The feature name goes on the instance or an alias (`typealias TutorRow = ThumbnailRow`). [S56]
- **Match the surrounding code** over personal preference. Consistency beats cleverness.
- **Delete dead code, feature-flag leftovers and commented-out code.** Git remembers it.
- **Refactor in small, safe steps, each with tests green**, and never mixed with behavior changes in the same commit. [S3]
- **Don't Repeat Yourself (DRY) applies to knowledge, not to lines.** Two screens that look the same today may diverge tomorrow; wait for the third copy. [S4]
- **No magic numbers in UI.** Use design tokens for spacing, color, type and radius.
- **Treat compiler and lint warnings as bugs.** Enable strict mode: Swift strict concurrency, Kotlin warnings as errors, TypeScript strict, Dart strict analysis.
- **Keep comments for why, not what.** Link the ticket or the platform bug for workarounds.
- **Use threads safely.** UI is updated on the main thread only. Use structured concurrency (Swift async/await, Kotlin coroutines scopes, Dart async). Cancel work when the screen goes away.

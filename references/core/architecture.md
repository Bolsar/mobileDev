# Architecture

Architectures (MVVM, MVI, VIPER, Clean) and principles (SOLID) are tools, not rules to obey. Pick the one that makes this app's code cheap to change and cheap to delete. [S56]

## Default shape (all stacks)
```
UI (screens, components)  →  State holder (ViewModel/Bloc/store)  →  Domain (optional use cases)  →  Data (repositories/stores)  →  Sources (API, DB, device)
```
- **Unidirectional data flow.** The UI renders state and sends events. The state holder turns events into new state. [S7][S22]
- **Repository** = the single source of truth per data type. It hides whether data comes from the network or the cache. For offline apps, the DB is the truth and the network syncs it. Business logic talks to a domain-shaped store (for example `Store<Order>`), never to the DB driver. [S25][S56]
- **Domain layer only when it earns its place.** Add it when logic is shared across screens or complex. Don't write a use case per repository call. [S1]
- **Dependencies point inward.** UI depends on data abstractions, never the reverse. [S1]

## Domain first [S56]
- **Model the domain before the UI.** Business logic imports no UI framework (SwiftUI, UIKit, Compose, Flutter widgets, React). The UI comes last and stays thin.
- **CLI test.** Could every state transition of the feature run from a command-line tool with no screen? If not, logic has leaked into the UI.
- **Invalid states unrepresentable.** Mutually exclusive cases are one enum/sealed type/union, not several optionals or booleans that can contradict each other.
- **Top-down with placeholders.** Write the call site first as if its dependencies already exist, with the API you wish you had. Stub what's below (hardcoded values, a delay, a fake) so the slice compiles and runs end to end, then replace stubs one by one without changing the call site.

## Dependency injection [S56]
- **Plain constructor/function injection by default.** It's compile-time checked and has no framework cost. In an existing project, keep the DI framework it already uses.
- **Inject only direct dependencies.** If A must know C just to build B, build B outside A and pass it in. Assemble the graph from the leaves (network, DB) up to features, at the app's entry point.
- **No global container passed around** (`AppContext`, `AppDependencies`, service locators). It hides what a feature really needs and couples everything to everything.
- **Group per feature.** One factory function per feature sub-tree (for example `Checkout.make(api:store:)`) keeps the feature's internal types internal to its module.
- **One operation? Pass a function**, not a one-method interface. `(Data) -> Data` beats a `Compressor` protocol with one implementation.
- **Removing singletons:** start at the deepest leaf and move up. Add the dependency as a constructor parameter defaulting to the singleton, so existing call sites keep compiling; switch callers over, then drop the default.

## Modularization
- Start as a single module, organized **by feature** (`feature/checkout/…`), not by layer (`views/`, `models/`).
- Split into modules when build times hurt or teams collide: `core/` (network, db, design system) plus `feature/*`. Features never import each other; they meet in navigation. [S34]

## Pragmatic rules
- No interface with a single implementation unless it's needed as a seam for tests or platform swaps.
- Put mappers at the boundaries: API DTO, then domain model, then UI model. Don't let the API shape leak into the UI.
- Errors are values: a typed Result or sealed error. The UI maps each error to a message and an action (retry, login, update app).
- Keep platform/OS calls (permissions, sensors) behind a small wrapper so you can fake them in tests.
- Prevent damage before you need to control it: types, compile-time checks and tests catch bugs before release. Flags and rollouts are the second line, because the binary can't be recalled.

## Anti-patterns
- A god ViewModel or god store for the entire app.
- Business logic in views, or domain code importing a UI framework.
- Singletons holding mutable state; a global dependency container handed to every feature.
- One-method protocols/interfaces that exist only to be mocked.
- "Clean architecture" with 6 layers for a 5-screen app.

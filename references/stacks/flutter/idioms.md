# Flutter — Idioms and Pitfalls

## Async and isolates [S135]
- After any `await` in a widget, check `if (!context.mounted) return;` before using `context` (navigation, snackbars). The lint `use_build_context_synchronously` catches most cases.
- Never call `notifyListeners()`/`setState()` after `dispose()`; guard long operations or cancel them on dispose.
- Dart runs your code on one thread. Parsing a big JSON payload or processing images blocks frames: move it to `Isolate.run()` (or `compute`).
- Streams and `StreamSubscription`s must be cancelled in `dispose()`. Same for `AnimationController`, `TextEditingController`, `ScrollController`, `FocusNode`.
- Always handle the `Future` you start. An unawaited future with an error surfaces as an uncaught error in the crash reporter, not in your UI.

## Lifecycle and process death
- `AppLifecycleListener` (or `WidgetsBindingObserver`) for pause/resume. Save drafts on `pause`/`hide`.
- Android and iOS kill the process in the background. Flutter keeps nothing unless you opt in: `RestorationMixin` + `restorationScopeId` for UI state [S138], persistence for real data. `go_router` routes can be restored with a `restorationScopeId`.
- Test it: Android "Don't keep activities"; on iOS stop the app from Xcode while backgrounded.

## Widgets and performance [S129]
- `const` constructors wherever possible; they skip rebuilds.
- Keep `build()` pure and cheap: no network calls, no sorting big lists, no creating controllers.
- Rebuild the smallest subtree: listen to state in the widget that uses it, not at the screen root. Split big `build` methods into widgets, not helper methods (widgets get their own element and can be `const`).
- `ListView.builder`/`SliverList` for long lists; never a `Column` of 500 children in a `SingleChildScrollView`.
- Stable `Key`s (`ValueKey(item.id)`) on list items that can reorder or be removed.
- Avoid `Opacity` and `saveLayer`-heavy effects in animations; use `AnimatedOpacity`/`FadeTransition`. Size network images to the display size (`cacheWidth`/`memCacheWidth`).
- Profile only in profile mode on a real device (`flutter run --profile`); debug mode is slow by design.

## Platform feel
- Flutter draws its own widgets, so platform conventions are your job: back gestures, `SafeArea`, scroll physics, date pickers, text selection, haptics. Use `.adaptive` constructors where they exist (`Switch.adaptive`, `CircularProgressIndicator.adaptive`), and test on both platforms.
- Respect text scaling (`MediaQuery.textScalerOf`); never clamp it to 1.0 to "fix" layouts. Fix the layout.
- Add `Semantics` labels to icon buttons and custom controls; check with TalkBack and VoiceOver.
- Platform channels and plugins: permissions and purpose strings are still configured in `Info.plist`/`AndroidManifest.xml`, and each plugin adds to the privacy manifest and Data safety answers.
- `--dart-define` values are compiled into the binary and are **not secret**.

## Reading an existing project
Check before writing: state management (Provider, Riverpod, Bloc, GetX, MobX, setState), DI (`get_it`, providers, constructors), navigation (`go_router`, auto_route, Navigator), codegen (`build_runner`, freezed), lint package, Flutter version (`.fvmrc`, `pubspec.yaml` constraints). Match them. Don't mix a second state-management library into a screen.

## Anti-patterns
- Business logic inside widgets or `StatefulWidget` state classes.
- Global mutable singletons or `get_it` called from widgets deep in the tree.
- GetX-style "magic" in new code (global navigation, service locator, reactive globals together).
- Catching every error with `catch (e) {}` and showing nothing.
- `print` in shipped code; use `dart:developer` `log` or a logger that is stripped in release.

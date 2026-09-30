# Android — Idioms and Pitfalls

## Coroutines and Flow [S113]
- Launch in `viewModelScope` or `lifecycleScope`. `GlobalScope` and hand-made `CoroutineScope()` without an owner leak work.
- Main-safety: repositories and data sources switch to `Dispatchers.IO`/`Default` themselves; callers never need to know. Inject the dispatcher so tests can replace it [S124].
- Collect flows in the UI with `collectAsStateWithLifecycle()` (Compose) or `repeatOnLifecycle(STARTED)` (Views). Plain `collect` in `lifecycleScope` keeps working in the background.
- Hot shared state: `stateIn(viewModelScope, SharingStarted.WhileSubscribed(5_000), initial)`.
- One-shot events (navigate, show snackbar): model them as state the UI consumes and acknowledges; a `Channel` works but can drop events around configuration changes.
- Never catch `CancellationException` and swallow it (a bare `catch (e: Exception)` inside a coroutine does exactly that). Rethrow it.

## Lifecycle and process death [S51]
- Configuration changes (rotation, dark mode, language, window resize) recreate the activity. The ViewModel survives; the composition doesn't.
- Process death kills the ViewModel too. Keep form input and navigation arguments in `SavedStateHandle`; Compose UI-only values in `rememberSaveable`.
- Test it: Developer options "Don't keep activities", or `adb shell am kill <package>` while the app is in the background, then reopen from recents.
- Don't hold `Activity` or `View` references in a ViewModel or singleton (memory leak). Need a `Context`? Take the application context.

## Compose [S115]
- **Stateless screens, stateful routes.** The screen composable takes state and lambdas; only the route talks to the ViewModel. Screens are then previewable and testable per state.
- **Stability:** pass immutable data (`data class` with `val`s, `ImmutableList` or stable collections) so unchanged parameters skip recomposition. Check with the Compose compiler reports or Layout Inspector recomposition counts before optimizing.
- `LazyColumn` with a stable `key` per item. Never put a `LazyColumn` inside a vertically scrolling `Column`.
- Read fast-changing values (scroll offset, animation) in lambdas (`Modifier.offset { }`, `graphicsLayer { }`) to skip recomposition.
- `remember` expensive computations with the right keys; `derivedStateOf` when the output changes less often than the input.
- Side effects only in `LaunchedEffect`/`DisposableEffect` with correct keys, never in the composable body.
- Text in `sp`, layout in `dp`; test at 200% font scale. Every clickable icon needs a `contentDescription` and a 48dp touch target.

## Platform rules to remember
- **Edge-to-edge** is enforced from targetSdk 35: handle insets with `Scaffold`/`WindowInsets` padding or content sits under system bars [S121].
- **Predictive back:** use `BackHandler`/`PredictiveBackHandler`, not `onBackPressed`.
- Runtime permissions: notifications (API 33+), photo picker instead of storage permissions, precise vs approximate location. Ask in context ([push-notifications](../../../skills/engineering/push-notifications/SKILL.md)).
- Foreground services need a declared type and matching permission; exact alarms need a permission most apps shouldn't use.
- Native libraries must support 16 KB memory pages for Play [S123]; check every SDK with `.so` files.
- targetSdk rises every year under Play rules [S83]; each bump brings behavior changes. Read the behavior-changes page before bumping.
- StrictMode in debug builds to catch disk and network on the main thread.

## Reading an existing project
Check before writing: Compose vs Views share, ViewModel + LiveData vs StateFlow, DI (Hilt, Koin, manual), RxJava vs coroutines, kapt vs KSP, module layout, navigation library, minSdk and targetSdk, test libraries. Match them. LiveData or RxJava in old code is not a bug; don't rewrite it unasked.

## Anti-patterns
- A `BaseViewModel`/`BaseActivity` hierarchy carrying unrelated helpers.
- `runBlocking` in app code; `Thread.sleep` in tests.
- Exposing `MutableStateFlow` publicly from the ViewModel.
- Business logic in composables or in `Activity`.
- Hardcoded strings and colors in composables instead of resources and theme tokens.

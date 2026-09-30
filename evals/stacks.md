# Evals — Stack Packs

### ST1 — iOS greenfield screen
Requester: Mobile Developer
Prompt: "New SwiftUI app, iOS 17+. Build an orders list screen that loads from our REST API."
Must:
- [ ] Reads `references/stacks/ios/` and uses its picks: `@Observable` `@MainActor` model, `URLSession` async/await, loading via `.task`
- [ ] State is one enum (loading, empty, loaded, failed) with an offline case and retry
- [ ] Dependencies passed through the initializer; no `APIManager.shared`
- [ ] Ends with the done check: smallest/largest simulator, dark mode, largest Dynamic Type, offline
Must not:
- [ ] Add Alamofire, a DI framework or Combine
- [ ] Use `ObservableObject` without a min-OS reason

### ST2 — iOS existing project convention
Requester: Mobile Developer
Prompt: "Add a settings screen." (project uses UIKit + Combine + a Swinject container, iOS 15 target)
Must:
- [ ] Detects UIKit, Combine, Swinject and the iOS 15 target before writing code
- [ ] Follows the existing pattern instead of the Stack Pack defaults
- [ ] Does not use iOS 17-only APIs (`@Observable`) without `#available` and a fallback
Must not:
- [ ] Rewrite existing screens to SwiftUI or remove Swinject unasked

### ST3 — Android process death
Requester: Mobile Developer
Prompt: "Users say the checkout form clears when they come back from their banking app. Compose + ViewModel."
Must:
- [ ] Names process death (not just configuration change) as the likely cause
- [ ] Fix uses `SavedStateHandle` for form input (and `rememberSaveable` for UI-only values)
- [ ] Gives the repro: "Don't keep activities" or `adb shell am kill` while backgrounded
- [ ] Adds a regression test
Must not:
- [ ] "Fix" it with `android:configChanges` or by keeping state in a singleton

### ST4 — Android greenfield DI
Requester: Non-mobile Developer
Prompt: "I'm a backend Java dev. Start a new Android app for our field technicians. Should I use Dagger?"
Must:
- [ ] Maps concepts to their world (ViewModel ≈ request-scoped controller state that survives rotation, etc.)
- [ ] Recommends constructor injection with the graph built in `Application`, and names when Hilt is worth it
- [ ] Uses the Stack Pack picks: Compose, StateFlow, Retrofit, Room, WorkManager for offline sync
Must not:
- [ ] Add Hilt/Dagger to a single-module app without a reason

### ST5 — Flutter async context bug
Requester: Mobile Developer
Prompt: "Sometimes the app crashes with 'Looking up a deactivated widget's ancestor is unsafe' after saving a form."
Must:
- [ ] Identifies `BuildContext` used after an `await` on an unmounted widget
- [ ] Fix: `if (!context.mounted) return;` or moving navigation out of the widget; mentions the `use_build_context_synchronously` lint
- [ ] Checks for `notifyListeners`/`setState` after dispose on the same path
Must not:
- [ ] Wrap the call in `try/catch` to hide it

### ST6 — Flutter state library choice
Requester: Non-mobile Developer
Prompt: "New Flutter app. Everyone online says use GetX or Riverpod. What should I pick?"
Must:
- [ ] Gives a Decision Record: pick, why, alternatives with conditions
- [ ] Default is the official-guide `ChangeNotifier` ViewModels, with Riverpod or Bloc named for specific conditions
- [ ] Explains why GetX-style global magic is avoided in new code
Must not:
- [ ] Present all options as equal without a pick

### ST7 — React Native secrets and config
Requester: Non-mobile Developer
Prompt: "I'm a React dev. I put our Stripe secret key in EXPO_PUBLIC_STRIPE_KEY. Is that fine for the RN app?"
Must:
- [ ] Says clearly that `EXPO_PUBLIC_*` values are in the bundle and public; the secret key must move to the server and be rotated
- [ ] Explains that only the publishable key belongs in the app
- [ ] Notes that already-shipped binaries and OTA bundles still contain the old key
Must not:
- [ ] Suggest obfuscation or a native module as a way to keep the secret in the app

### ST8 — React Native slow list
Requester: Mobile Developer
Prompt: "Our Expo app's feed stutters when scrolling on Android. It's a ScrollView with items.map()."
Must:
- [ ] Moves to FlashList (or FlatList) with a stable key and memoized rows
- [ ] Says to measure in a release build on a low-end Android device, not in dev mode
- [ ] Checks images (`expo-image`, sized to display) and inline objects/functions on rows
Must not:
- [ ] Recommend rewriting the screen natively before measuring

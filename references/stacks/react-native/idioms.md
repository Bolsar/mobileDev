# React Native — Idioms and Pitfalls

## Threads and rendering [S144]
- Your JS runs on one thread. Heavy work there (big JSON transforms, sorting thousands of items on every render) drops frames and delays taps. Precompute, memoize, paginate, or move it to native.
- Animations and gestures belong on the UI thread: Reanimated worklets and Gesture Handler, not `setState` per frame.
- Re-renders: new object/array/function props on every render defeat `React.memo`. Keep list item components memoized and their props stable. Measure with the React DevTools profiler before adding `useMemo` everywhere.
- Don't fetch in `useEffect` by hand; use TanStack Query. Don't sync derived values into state with `useEffect`; compute them during render [S154].
- Lists: FlashList/FlatList with a stable `keyExtractor`, never `.map()` inside a `ScrollView` for long data.

## Lifecycle and process death
- `AppState` for foreground/background. Refetch on focus and reconnect (TanStack Query `focusManager`/`onlineManager` wired to `AppState` and NetInfo).
- React Native restores nothing after the OS kills the process. Persist drafts and the current step explicitly (MMKV or SQLite), and restore on launch ([state-management](../../../skills/engineering/state-management/SKILL.md)).
- Background tasks (`expo-background-task`, headless JS) are limited and OS-scheduled; never promise timing.

## Native feel and accessibility
- Safe areas: `react-native-safe-area-context`, not hardcoded paddings.
- Keyboard: test every form on both platforms with the keyboard open; `KeyboardAvoidingView` behaves differently on each (react-native-keyboard-controller when it isn't enough).
- Android back button and gesture must do the right thing on every screen, including modals.
- Never set `allowFontScaling={false}` to "fix" layouts; set `maxFontSizeMultiplier` sparingly and fix the layout.
- `accessibilityLabel`, `accessibilityRole` and `hitSlop` on custom touchables; `Pressable` rather than bare `TouchableOpacity` in new code. Check with VoiceOver and TalkBack.
- Platform differences are real: shadows (`elevation` vs shadow props), fonts, date pickers, permission flows. Use `Platform.select` sparingly and test both.

## Config, secrets and native code
- `EXPO_PUBLIC_*` variables are inlined into the JS bundle and are **public** [S149]. Secrets stay on the server.
- Adding or upgrading a library with native code requires a new development build and a new store binary. Only JS/asset changes can go out as an OTA update, and only to binaries with the matching runtime version ([ota-updates](../../../skills/release/ota-updates/SKILL.md)).
- Check each library for New Architecture support and Expo compatibility (`npx expo install` picks compatible versions; `npx expo-doctor` flags problems).
- With CNG, never hand-edit `ios/`/`android/`; change `app.config.ts` or write a config plugin. Hand edits are lost on the next prebuild.

## Reading an existing project
Check before writing: Expo (managed, CNG, or bare) vs RN CLI, `ios/`/`android/` committed or generated, JS vs TS and `strict`, navigation (Expo Router, React Navigation), state (Redux, Zustand, MobX, context), data fetching (TanStack Query, RTK Query, SWR, hand-rolled), styling (StyleSheet, NativeWind, Tamagui), New Architecture enabled or not, RN and Expo SDK version. Match them.

## Anti-patterns
- Tokens in AsyncStorage or MMKV without encryption.
- API responses cached by hand in Redux with no invalidation.
- `any` on API data; unvalidated responses flowing into the UI.
- Inline styles and anonymous functions on every row of a long list.
- Upgrading several major versions at once (RN + Expo + navigation); upgrade one SDK step at a time with the upgrade helper.

# React Native — Tooling

## Toolchain
- Node version pinned (`.nvmrc` or `engines`); one package manager with its lockfile committed.
- Expo SDK and React Native versions move together; upgrade with `npx expo install expo@<next> --fix` and read the SDK changelog. Run `npx expo-doctor` after every dependency change.
- Environments: `app.config.ts` reads `APP_VARIANT` to set bundle ID, name and API URL per variant; EAS Build profiles (`development`, `preview`, `production`) [S90].
- Native toolchains still apply for local builds: Xcode for iOS, JDK/Android SDK for Android.

## Lint and format
- `tsc --noEmit` in CI (type errors fail the build).
- ESLint (`eslint-config-expo`, React hooks rules) + Prettier.

## Tests
| Kind | Tool |
|---|---|
| Unit and feature tests | Jest (`jest-expo` preset) + React Native Testing Library [S147], queried by role/label like a user |
| Network fake at the edge | MSW or a fake `fetch`; a fresh `QueryClient` per test with retries off |
| Storage | in-memory fakes for MMKV/secure store; real SQLite in integration tests |
| E2E | Maestro [S148] for critical flows (Detox if the project has it) |
| Visual | Maestro screenshots or Storybook stories per state; light/dark and large font |

`npx jest` and `npx tsc --noEmit` in the PR pipeline; Maestro flows against a preview build.

## Debug and profile
- React Native DevTools (debugger, React profiler) and the Expo dev menu's performance monitor.
- Test performance only in release builds on a low-end Android device; dev mode is far slower.
- Hermes sampling profiler for JS CPU; Xcode Instruments / Android Studio Profiler for native.
- Bundle size: `npx expo export` with Expo Atlas to find heavy imports.
- Field data: Sentry (`@sentry/react-native`) or Crashlytics, with source maps uploaded per build.

## Build and release
- `eas build --profile production` for signed store binaries; `eas submit` to upload [S90]. Credentials managed by EAS or fastlane `match` ([signing-certificates](../../../skills/release/signing-certificates/SKILL.md)).
- Upload source maps and native symbols for every build, or crash stack traces are minified gibberish.
- OTA via EAS Update [S89]: set `runtimeVersion` policy so an update never reaches a binary with different native code; roll out to a percentage first ([ota-updates](../../../skills/release/ota-updates/SKILL.md)).
- Store rules are the native ones ([ios-store-submission](../../../skills/release/ios-store-submission/SKILL.md), [android-store-submission](../../../skills/release/android-store-submission/SKILL.md)).

## Done check
`tsc` and lint clean, tests pass, a release (not dev) build runs on a small Android phone and a large iPhone, dark mode, largest font, airplane mode, keyboard open on every form, Android back on every screen, and the draft survives a process kill.

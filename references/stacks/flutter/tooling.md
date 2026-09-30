# Flutter — Tooling

## Toolchain
- Pin the Flutter version: FVM (`.fvmrc`) [S139] or a version file read by CI. Commit `pubspec.lock` for apps.
- Native toolchains still matter: Xcode and CocoaPods/SPM for iOS, Gradle/AGP/JDK for Android. Pin them like a native project ([ios tooling](../ios/tooling.md), [android tooling](../android/tooling.md)).
- Flavors per environment: `flutter run --flavor dev -t lib/main_dev.dart --dart-define-from-file=env/dev.json` [S133].
- Codegen (`json_serializable`, Drift): `dart run build_runner build --delete-conflicting-outputs`, run in CI before tests.

## Lint and format
- `flutter analyze` with `flutter_lints` (or `very_good_analysis` for stricter rules) in `analysis_options.yaml` [S128].
- `dart format --set-exit-if-changed .` in CI.

## Tests [S130]
| Kind | Tool |
|---|---|
| Unit and feature tests | `flutter_test` / `package:test`; fakes over mocks, `mocktail` only at the edge |
| Network fake at the edge | a fake `http.Client` (`MockClient` from `package:http/testing.dart`) |
| DB | Drift with an in-memory `NativeDatabase.memory()`; schema tests for every shipped version |
| Widget | `testWidgets` with `pumpWidget`, per screen state |
| Golden | `matchesGoldenFile` (or alchemist), light/dark and large text scale; generate on one OS in CI to avoid font diffs |
| E2E | `integration_test`; Patrol or Maestro when native dialogs (permissions) are in the flow |

`flutter test` locally and in the PR pipeline; `flutter test integration_test` on emulator/simulator for critical flows.

## Debug and profile
- Flutter DevTools: Performance (frame chart, jank), CPU profiler, Memory, Network, widget rebuild counts.
- `flutter run --profile` on a low-end Android device for any performance claim.
- `flutter build appbundle --analyze-size` / `flutter build ipa --analyze-size` for app size.
- Field data: Crashlytics or Sentry Flutter SDK with `FlutterError.onError` and `PlatformDispatcher.instance.onError` wired.

## Build and release
- `flutter build appbundle --flavor prod --obfuscate --split-debug-info=build/symbols` and `flutter build ipa ...` [S134]. Upload the symbol files to the crash reporter, or stack traces are unreadable.
- Build number from CI: `--build-number=$CI_BUILD_NUMBER`.
- fastlane or Codemagic for signing and upload; store rules are the native ones ([ios-store-submission](../../../skills/release/ios-store-submission/SKILL.md), [android-store-submission](../../../skills/release/android-store-submission/SKILL.md)). Code push via Shorebird: [ota-updates](../../../skills/release/ota-updates/SKILL.md).

## Done check
`flutter analyze` clean, tests pass, release build runs on a small Android phone and a large iPhone (or both platforms' smallest and largest), dark mode, largest text scale, airplane mode, and restores after process death.

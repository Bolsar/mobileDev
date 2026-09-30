# Android — Tooling

## Toolchain
- Gradle wrapper committed; AGP, Kotlin and library versions in `libs.versions.toml` [S122]. JDK version pinned in CI and in the README.
- Build types (`debug`, `release`) plus product flavors per environment (`dev`, `prod`). Base URLs in `buildConfigField`; secrets never in `gradle.properties` committed to the repo.
- Release builds: R8 on (`isMinifyEnabled = true`, `isShrinkResources = true`) with keep rules for reflection-based libraries [S54]. Test the release build, not just debug.

## Lint and format
- Android Lint (`./gradlew lint`) with a baseline for legacy warnings; new warnings fail CI.
- ktlint or detekt (with the Compose rules) for style. Pick one formatter and run it in CI.

## Tests [S124]
| Kind | Tool |
|---|---|
| Unit and feature tests (JVM) | JUnit, `kotlinx-coroutines-test` (`runTest`, `StandardTestDispatcher`), Turbine for Flow |
| Network fake at the edge | OkHttp `MockWebServer` |
| DB | Room in-memory DB; `MigrationTestHelper` for every shipped schema [S50] |
| Compose UI | `createComposeRule` (JVM with Robolectric, or on device) |
| Screenshot | Roborazzi or Paparazzi, light/dark and large font |
| E2E | Compose UI tests on device or Maestro, critical flows only |
| Performance | Macrobenchmark for startup and scroll; generate a Baseline Profile [S120] |

`./gradlew testDebugUnitTest lint` locally and in the PR pipeline; instrumented tests on an emulator matrix (min API, latest API) or a device farm.

## Debug and profile
- Android Studio Profiler (CPU, memory, network), Layout Inspector with recomposition counts, Perfetto for system traces.
- LeakCanary in debug builds.
- Android vitals in Play Console for field data: crash rate, ANR rate, slow frames, startup [S20].
- Accessibility Scanner and TalkBack for the verify step.

## Build and release
- `./gradlew bundleRelease` produces the AAB [S93]; signed with the upload key; Play App Signing holds the app key [S84][S88].
- Upload the R8 mapping file and native symbols to the crash reporter and Play Console.
- Internal testing track first, then staged rollout with a halt rule ([android-store-submission](../../../skills/release/android-store-submission/SKILL.md)).
- fastlane `supply` or the Gradle Play Publisher plugin for uploads from CI [S86].

## Done check
Release variant builds, lint clean, tests pass, runs on a small phone at min API and a large phone or tablet at the latest API, dark mode, 200% font, airplane mode, and survives "Don't keep activities".

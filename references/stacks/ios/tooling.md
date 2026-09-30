# iOS — Tooling

## Toolchain
- Xcode pinned per project: note the version in the README and in CI (`xcode-select` / `DEVELOPER_DIR`). New store uploads require a recent Xcode and SDK; check Apple's current requirement before a release.
- Swift Package Manager; commit `Package.resolved`.
- Build configurations or `.xcconfig` files per environment (Debug-Dev, Release-Prod). Base URLs live there, never secrets.

## Lint and format
- SwiftLint [S109] and `swift format` (ships with the toolchain). Run both in CI; fail on errors.
- Treat warnings as errors in CI for the app target once the backlog is clean.

## Tests [S106]
| Kind | Tool |
|---|---|
| Unit and feature tests | Swift Testing (`@Test`, `#expect`); XCTest in older projects |
| Network fake at the edge | `URLProtocol` stub registered on the test `URLSession` |
| DB | SwiftData/GRDB with an in-memory store |
| Snapshot | swift-snapshot-testing [S110], light/dark and largest Dynamic Type |
| UI / E2E | XCUITest or Maestro for the critical flows only |

`xcodebuild test -scheme App -destination 'platform=iOS Simulator,name=iPhone SE (3rd generation)'` — also run on the largest simulator.

## Debug and profile
- Instruments: Time Profiler (hangs, slow launch), Allocations and Leaks (memory), Network, SwiftUI template (view body counts).
- Thread Sanitizer and Main Thread Checker on in the Debug scheme.
- `os_signpost` / `Logger` for measuring and logging; never `print` in shipped code.
- MetricKit for field data (hangs, launch time, crashes) on top of the crash reporter ([crash-monitoring](../../../skills/release/crash-monitoring/SKILL.md)).
- Accessibility Inspector and Xcode's Environment Overrides (text size, dark mode, contrast) for the verify step.

## Build and release
- Archive with `xcodebuild archive` + `-exportArchive`, or fastlane `gym` [S86]. Signing via fastlane `match` or Xcode Cloud managed signing ([signing-certificates](../../../skills/release/signing-certificates/SKILL.md)).
- Upload dSYMs to the crash reporter on every build.
- TestFlight first, then phased release [S97][S100] ([ios-store-submission](../../../skills/release/ios-store-submission/SKILL.md)).

## Done check
Builds with zero new warnings, lint clean, tests pass, runs on the smallest and largest simulator, dark mode, largest text size, and with the Network Link Conditioner set to 100% loss.

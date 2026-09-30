---
name: scaffold-project
description: Create a new mobile app project with sane defaults (structure, environments, lint, core layers). Use when the Requester has no project yet or asks to "set up", "bootstrap" or "start" an app.
---

# Scaffold Project

A greenfield project, set up so the first feature is easy and nothing is expensive to fix later.

## Blocking Questions
1. Platforms and stack? — Recommended: from [choose-stack](../../product/choose-stack/SKILL.md); skip if already decided.
2. App ID / bundle ID (for example `com.acme.walks`)? — Recommended: reverse domain the company owns. **It can't change after the first store upload**, so confirm it.
3. App display name? — Recommended: the brand name; can change later.
4. Min OS? — Recommended: see the catalogue in [mindset/questioning.md](../../../mindset/questioning.md).
5. Environments? — Recommended: dev + prod; add staging when a staging backend exists.

## Steps
1. **Generate with the official tool** (Xcode template, Android Studio template, `flutter create --org`, `npx create-expo-app`). Pin toolchain versions (Xcode version note, Gradle wrapper, Flutter version file, Node version). Done when a clean clone builds with one documented command.
2. **Strict from day 1.** Turn on strict compiler and lint settings ([references/core/clean-code.md](../../../references/core/clean-code.md)) and a formatter. Done when lint runs clean.
3. **Structure.** Folders by feature plus `core/` (network, storage, design system), per the Stack Pack in `references/stacks/<stack>/`. Dependencies wired by hand at the app entry point (see "Dependency injection" in [references/core/architecture.md](../../../references/core/architecture.md)). Record choices per [choose-architecture](../choose-architecture/SKILL.md).
4. **Environments.** One config per environment for base URL and feature flags. Keep secrets out of the repo and out of the binary; anything the app ships is public. Done when switching environment is a build flag, not a code edit.
5. **Core wiring.** Network client ([networking-layer](../networking-layer/SKILL.md)), storage ([local-storage](../local-storage/SKILL.md)), design tokens ([design-system-setup](../../design/design-system-setup/SKILL.md)), string externalization ([localization](../localization/SKILL.md)), crash reporting hook ([crash-monitoring](../../release/crash-monitoring/SKILL.md)).
6. **Min-version check hook.** Read a minimum supported version from remote config at launch, even if the screen is a stub ([versioning-force-update](../../release/versioning-force-update/SKILL.md)). This must ship in v1: you can't add it to versions already installed.
7. **One test of each kind** (unit, UI) running, so later features copy the pattern.
8. **README**: how to build, run, test, switch environment.

## Output
Project tree, the build/run/test commands, Decision Records, and a list of what's stubbed.

## Verify
Builds and launches on the smallest supported device and a large one, in both platforms if both. Tests pass. Lint clean.

---
name: agent-ready-codebase
description: Set up a mobile project so coding agents can verify their own work and can't easily make known mistakes - Feature Map, stable test IDs, Maestro flows, the verify harness, and lint guardrails. Use when the Requester wants to rely on agents more, review less, or when agents keep repeating the same mistakes.
---

# Agent-Ready Codebase

Agents copy what's in the codebase and do what's cheapest. Make the cheap path the right path, and give them a way to prove their work [S155]. Theory: [mindset/verification.md](../../../mindset/verification.md).

## Blocking Questions
1. Which flows matter most? — Recommended: sign-in, the flow that makes money or delivers the core value, and the 3 most-used screens.
2. Can we add Maestro [S148] to the project and CI? — Recommended: yes; it drives all four stacks from the same YAML.

## Steps
1. **Map the app.** List every screen, sheet and deep link from the navigation code. Copy [harness/feature-map.template.md](../../../harness/feature-map.template.md) to `.maestro/feature-map.md` and fill one section per screen. Done when every reachable screen has an entry with how to reach it and what it needs (login, data, flag).
2. **Stable test IDs** on everything a flow taps or checks. Never select by visible text; it changes with copy and locale.
   - iOS: `.accessibilityIdentifier("orders-list")`
   - Android Compose: `Modifier.testTag("orders-list")` plus `semantics { testTagsAsResourceId = true }` on the root so Maestro sees the tags
   - Flutter: `Semantics(identifier: 'orders-list', child: …)` (Flutter 3.19+)
   - React Native: `testID="orders-list"`
3. **Flows.** One Maestro flow per critical path from question 1, ending with `takeScreenshot`. Seed or fake the data a flow needs; never hardcode real credentials in a flow. Done when `maestro test .maestro/` passes locally.
4. **Wire the harness.** `<agent root>/harness/verify --flow .maestro/<flow>.yaml` must pass. Add `.mobile-agent-proof/` to `.gitignore`. In CI, run the same command and upload the proof folder as an artifact ([ci-cd-setup](../../release/ci-cd-setup/SKILL.md)).
5. **Paved paths.** For networking, state, navigation, storage and errors, point to one existing feature as the template in the project's agent instructions file. Two competing ways to do the same thing means agents pick at random; flag the loser for [codebase-gardening](../codebase-gardening/SKILL.md).
6. **Guardrails.** Add the checks below to lint and CI. Start with a baseline so legacy code doesn't block, but new violations fail.

## Guardrails by stack
| Guard | iOS | Android | Flutter | React Native |
|---|---|---|---|---|
| Ban workaround comments (`HACK`, `workaround`, `temporary fix`, `TODO` without a ticket) | SwiftLint `custom_rules` regex [S109] | detekt `ForbiddenComment` | CI `git grep -nE` check | ESLint `no-warning-comments` |
| Module boundaries (domain never imports UI, features talk only through public APIs) | Local SPM packages: the compiler enforces it | Gradle modules; Konsist tests within a module | Separate packages in a pub workspace; `custom_lint` rule within one | ESLint `no-restricted-imports` or eslint-plugin-boundaries |
| No I/O on the main thread | Main Thread Checker in tests; `@MainActor` only on UI types | StrictMode in debug builds | Heavy work only via `compute`/isolates; review rule | No sync storage reads during render; review rule |
| Exhaustive screen states | `enum` with associated values and `switch` without `default` | `sealed interface` + `when` | `sealed class` + `switch` pattern | Discriminated union + `never` check (`strict` TS [S152]) |

Exact rule names and config keys change. Verify each against the current tool docs before committing.

## Output
```
Feature Map: .maestro/feature-map.md — <n> screens
Flows: <flow> — PASS|FAIL (proof: .mobile-agent-proof/<ts>/)
Test IDs added: <n> across <screens>
Guardrails: <rule> — <tool> — baseline <n> legacy hits
Paved paths: <concern> → <template feature path>
Not done: <item> — why
```

---
name: testing-strategy
description: Decide what to test and how for a mobile app (test pyramid, tools, device matrix, CI). Use when a project has no tests, tests are flaky or slow, or the Requester asks "what should we test?"
---

# Testing Strategy

The shape, the must-test list and practices: [references/core/testing.md](../../../references/core/testing.md). Tools per stack: `references/stacks/<stack>/`.

## Blocking Questions
1. Which flows would cost the most if broken? — Recommended: sign-in, payment/checkout, onboarding, and whatever makes money.
2. Is there CI? — Recommended: tests run on every PR; if no CI, see [ci-cd-setup](../../release/ci-cd-setup/SKILL.md).

## Steps
1. **Audit what exists.** Count tests by kind, runtime, and flaky ones. Done when you have the numbers.
2. **Risk map.** List the critical flows and the code that has regressed before (git log, crash reports). This, not coverage percentage, decides where tests go.
3. **Plan by layer.**
   - Feature-level (the bulk): real state holder, domain and repositories; fakes only for transport, DB and clock. Every state transition.
   - Unit: pure logic worth pinning alone (mappers with missing/extra/null fields, calculations).
   - Integration: DB migrations from every shipped schema, API client against a mock server.
   - UI/E2E: critical flows only.
   - Snapshot: design system and key screens in light/dark and max font.
4. **Make it testable** where needed: inject clocks, dispatchers, platform wrappers and the transport. For single operations inject a function, not a new interface. Existing tests that mock every intermediate class: migrate them toward a fake transport when you touch them.
5. **Device matrix** for manual release checks: one low-end Android, one older iPhone at min OS, one current flagship, a tablet if supported.
6. **Order the work**: the highest-risk untested flow first.

## Output
```
Current: <counts, runtime, flaky>
Critical flows: …
Plan: layer — what — tool — priority
Device matrix: …
First 3 tests to write: …
```

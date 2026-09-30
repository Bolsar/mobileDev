---
name: scaffold-feature
description: Build a new screen or feature end to end in an existing app (UI, state, data, tests). Use when the Requester asks to "add a screen", "build the X feature" or "implement this design".
---

# Scaffold Feature

One vertical slice, from UI to storage/API, with every screen state.

## Blocking Questions
Read the project and any designs first.
1. Offline behavior? — Recommended: read from cache offline, writes need network.
2. Does the API exist? — Recommended: if not, agree the contract first ([api-contract](../../collaboration/api-contract/SKILL.md)) and build against a mock.
3. Entry points: tab, push, deep link? — Recommended: normal navigation only; add deep link when asked.

## Steps
1. **Copy the house style.** Find the most similar existing feature and follow its shape: folders, state holder, DI, naming, tests. Done when you can name the feature you are copying.
2. **Screen inventory.** For each screen list entry points, states and edge cases per [mindset/planning.md](../../../mindset/planning.md). Done when every state has a line: loading, content, empty, error, offline, and permission denied if relevant.
3. **Domain and call site first** (top-down, [references/core/architecture.md](../../../references/core/architecture.md) "Domain first"). Write the domain model and the state holder as if the repository already exists. Stub the repository with hardcoded data so the slice runs end to end. Done when the state holder reaches every state from step 2 with no UI code.
4. **State.** One immutable state per screen; mutually exclusive states as a sealed type/union. Persist what must survive process death ([state-management](../state-management/SKILL.md)).
5. **Replace stubs.** Contract → DTO → mapper → domain model → repository, keeping the call site unchanged. Parse leniently: missing and unknown fields must not crash. Inject dependencies through constructors, the way the project already does.
6. **UI last.** Load [ui-anti-slop](../../design/ui-anti-slop/SKILL.md) first. Render every state from step 2. Labels, 44pt/48dp targets, dynamic type ([references/core/accessibility.md](../../../references/core/accessibility.md)). Strings externalized.
7. **Wire navigation** and any flag that gates the feature.
8. **Tests.** Feature-level: drive the real state holder, domain and repository with a fake transport; one test per state transition. Mapper: missing, extra and null fields.
9. **Verify** on smallest and largest screen, dark mode, max font, offline, and after process death.

## Output
Files added/changed, the state list with how to trigger each, tests added, and what the Requester must check on a real device.

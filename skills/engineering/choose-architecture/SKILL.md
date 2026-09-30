---
name: choose-architecture
description: Pick or assess an app's architecture (layers, modules, dependency rules). Use when starting a new app, when an existing codebase feels tangled, or when the Requester asks "how should I structure this?"
---

# Choose Architecture

The goal is the smallest structure that keeps the next year of features cheap. Default shape and anti-patterns: [references/core/architecture.md](../../../references/core/architecture.md).

## Blocking Questions
Read the project first. Ask only what it can't tell you.
1. Team size in 12 months? — Recommended: plan for the current team + 1.
2. Rough size: how many screens at launch? — Recommended: assume 10–30.
3. Offline writes needed? — Recommended: no (read cache only). A yes makes the DB the source of truth; see `offline-first-sync`.

## Steps
1. **Survey.** In an existing project, map what is there: layers, state holder type, DI, module layout, how one feature flows from UI to API. Done when you can trace one real feature end to end and name each hop.
2. **Match or choose.**
   - Existing project: keep its architecture. List only real problems (a god ViewModel, business logic in views or importing UI frameworks, API models in the UI, mutable singletons, a global dependency container) with the file that shows each.
   - Greenfield: use the default shape plus the Stack Pack default (`references/stacks/<stack>/`). One module, folders by feature.
3. **Size it.** Add a domain layer or extra modules only for a named reason (shared logic, build time, team collisions). Each layer you add, write the reason next to it.
4. **Dependencies.** Greenfield: plain constructor injection, graph assembled at the app entry point, one factory per feature. Existing project: keep its DI; flag a global container passed into features and mutable singletons, with a leaf-up plan to remove them (see "Dependency injection" in the architecture reference).
5. **Record.** Write a Decision Record ([mindset/decisions.md](../../../mindset/decisions.md)) for every non-obvious choice: state holder, DI, modules, navigation.
6. **Show one feature.** Draw the folder tree and one feature's flow (screen → state holder → repository → source) so the Requester sees the shape in practice.

## Output
```
Decision Records: …
Folder tree: …
Dependency rules: UI → state → data → sources; features never import each other
One feature traced: …
Problems found (existing project only): file — problem — impact — fix
```

## See also
[state-management](../state-management/SKILL.md) · [scaffold-project](../scaffold-project/SKILL.md) · [offline-first-sync](../offline-first-sync/SKILL.md)

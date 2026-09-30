---
name: api-contract
description: Draft or review the API contract (OpenAPI or GraphQL schema) between the app and its backend so both sides can build in parallel and old app versions keep working. Use before building a screen whose API doesn't exist yet, when adding or changing an endpoint, or when backend asks "what do you need?".
---

# API Contract

Agree the contract before the UI is built; build both sides against it, with a mock server in between [S26]. The app lives for years at old versions, so the contract is a promise ([mindset/constraints.md](../../../mindset/constraints.md) §3).

## Blocking Questions
1. REST or GraphQL? — Recommended: whatever the backend already uses; new backend → REST + OpenAPI [S71].
2. Who owns the schema file? — Recommended: one file in the backend repo, reviewed by both sides; the app generates models from it.

## Steps
1. **Derive from screens.** For each screen in the feature, list the data it shows and the actions it takes. Done when every field on every screen state has a source.
2. **Write the schema** (OpenAPI or GraphQL SDL). Done when every endpoint has request, response, error responses and an example.
3. **Apply the checklist.** Done when each line is covered or marked "not needed" with a reason.
4. **Mock it** from the schema (Prism, MSW, WireMock or the GraphQL mock server) so the app builds before the backend ships.
5. **Review with backend** and record open questions with a proposed answer each.

## Checklist
- **Shape for the screen**: one call per screen where possible; no N+1 round trips on cellular.
- **Lists**: cursor pagination with a stable sort; page size set by server with a cap.
- **Errors**: typed, machine-readable codes the app maps to an action (retry, sign in, fix field X, update app), plus field-level validation errors. Problem Details [S72] is a good default shape.
- **Writes**: idempotency key on every non-idempotent write the app may retry [S73].
- **Types**: timestamps ISO-8601 UTC; money as integer minor units + currency code; IDs as strings; enums documented as open (new values will appear).
- **Evolution**: add fields, never rename or retype them; nullable additions only; deprecate with a sunset date [S74]; a new endpoint version only when there is no additive path.
- **Old clients**: server-driven minimum supported version (force update) and a kill switch per feature.
- **Caching**: ETag / Cache-Control on reads that allow it.
- **Offline sync** (if needed): delta endpoint, tombstones for deletes, server timestamps ([offline-first-sync](../../engineering/offline-first-sync/SKILL.md)).
- **Auth**: which calls need it, token refresh behavior, what 401 vs 403 mean.
- **Privacy**: only the fields the screen needs; no personal data in URLs or query strings.

## Output
The schema file (or a diff to it), plus:
```
Open questions: question — proposed answer — owner
Breaking-change check: none | <change> — why it's safe for version X.Y already installed
```
For a Business Owner: what backend must build, what can be mocked meanwhile, and which decisions block the schedule.

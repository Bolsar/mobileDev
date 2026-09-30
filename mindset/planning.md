# Planning

## 1. Vertical slices
Split the work into slices a user can see, each running from UI to storage/API. Don't split it into layers. Each slice can be demoed and shipped behind a flag.

Build each slice top-down: domain model and call site first, placeholders below so it runs end to end early, UI last ([references/core/architecture.md](../references/core/architecture.md), "Domain first"). Missing specs or APIs don't block you: stub them, mark the assumption, keep moving.

## 2. Screen inventory and states
For every screen, list:
- Entry points: navigation, deep link, push notification
- States: loading · content · empty · error · offline · partial (some data stale) · permission denied
- Input edge cases: long text, zero or huge counts, RTL, large font
- Exit and back behavior, and what survives process death

## 3. Contract before code
- Agree the API contract with backend first ([api-contract](../skills/collaboration/api-contract/SKILL.md)). Mock it so the mobile team isn't blocked.
- Agree on design handoff completeness first ([design-handoff-review](../skills/collaboration/design-handoff-review/SKILL.md)).

## 4. Risks up front
Name the top 3 risks: unknown platform API, store policy, backend readiness, performance. Put a spike on the riskiest one first.

## 5. Release plan (part of every plan)
- A feature flag for anything risky
- Analytics events and crash monitoring decided before build ([analytics-plan](../skills/release/analytics-plan/SKILL.md))
- Staged rollout percentages and the rollback path (flag off, since the binary can't roll back)
- Store metadata, screenshots, privacy forms if they change
- Minimum supported version impact

## 6. Plan output format
```
Goal: <one line>
Slices: 1. … 2. … (each: scope, est. range)
Screens & states: …
Contract/design dependencies: …
Risks: …
Release: flag, rollout, metrics
```

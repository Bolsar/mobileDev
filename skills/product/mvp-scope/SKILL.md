---
name: mvp-scope
description: Cut an app idea or feature list down to the smallest release that tests the core bet with real End Users, with a fixed time budget and explicit "not now" list. Use when the Requester has a long wishlist, a deadline, a limited budget, or asks "what should we build first?".
---

# MVP Scope

Fix the time, vary the scope [S16]. The MVP answers one question about End Users; everything that doesn't help answer it waits.

## Blocking Questions
1. What must be true for this app to be worth continuing? (the core bet) — Recommended: "End Users complete <core job> and come back within a week."
2. Time or money budget (appetite)? — Recommended: 6–10 weeks to first store release for a small team.

## Steps
1. **Write the core bet and its metric** in one line each.
2. **List the core job's flow** end to end. Done when the flow runs from install to the job done, including first run and sign-in.
3. **Sort every wishlist item** into: needed for the core flow · needed for store approval, trust or law · later. Default to later. Done when "later" is the longest list.
4. **Apply the mobile must-haves** that are never cut: crash reporting, force-update switch, privacy policy and store privacy forms, account deletion if accounts exist (store rules; verify current policy [S9][S10]), all screen states, basic accessibility.
5. **Cut cost, not quality**: one platform first if the audience allows; web view or email for rare admin flows; manual ops behind the scenes instead of automation; buy auth/payments instead of building ([mindset/decisions.md](../../../mindset/decisions.md), build vs buy).
6. **Estimate the result** ([estimate-feature](../estimate-feature/SKILL.md)). Over the appetite → cut again, don't stretch the time.

## Output
```
Core bet: … — measured by: …
MVP (in): …
Required regardless: …
Not now: item — why — revisit when …
Cheaper substitutes: item → substitute
Estimate vs appetite: …
```
For a Business Owner: explain every cut in terms of what End Users will and won't notice.

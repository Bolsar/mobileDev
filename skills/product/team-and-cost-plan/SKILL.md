---
name: team-and-cost-plan
description: Plan the team, roles, timeline and recurring costs to build and run a mobile app, as ranges with assumptions. Use when a Business Owner asks "who do I need to hire?", "how much will the app cost?", or when choosing between agency, freelancers and an in-house team.
---

# Team and Cost Plan

Build cost is half the story; the app needs people and money every year after launch. Give ranges in effort (person-months); the Requester supplies local rates, because rates vary too much by country to guess.

## Blocking Questions
1. Stack and platforms decided? — Recommended: run [choose-stack](../choose-stack/SKILL.md) first.
2. In-house, freelancers or agency? — Recommended: agency or freelancers for the MVP only if one in-house technical owner reviews their work and owns the accounts.

## Steps
1. **Scope first**: take the MVP and the estimate ([mvp-scope](../mvp-scope/SKILL.md), [estimate-feature](../estimate-feature/SKILL.md)).
2. **Roles.** Map the work to roles: mobile engineers (per platform or cross-platform), backend, designer, QA, product owner. Small teams merge roles; name who covers each one. Done when no role is "nobody".
3. **Timeline**: effort divided by people is not calendar time; add ramp-up, reviews, store review and dependencies.
4. **Recurring costs**, as lines to price:
   - Apple Developer Program and Google Play registration fees (check current prices)
   - backend hosting, database, file storage, bandwidth
   - SaaS: auth, push, crash reporting, analytics, remote config, email/SMS
   - store commission on in-app purchases and subscriptions (verify the current rate for your program)
   - maintenance: yearly OS releases, SDK and framework upgrades, store policy changes, security fixes. A common rule of thumb is 15–20% of build effort per year; treat it as an assumption.
5. **Ownership risks**: store accounts, signing keys, domains, repo and cloud accounts must belong to the Requester's company, never the vendor.

## Output
```
Team: role — who — allocation — phase
Build: <low>–<high> person-months, <low>–<high> months calendar
Recurring (yearly): line — cost driver — price it at
Maintenance: <assumption>
Must own: accounts and keys list
Assumptions / biggest risk: …
```
Plain language throughout; this skill is almost always for a Business Owner.

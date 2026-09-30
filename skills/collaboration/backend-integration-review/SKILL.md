---
name: backend-integration-review
description: Review an existing or proposed backend API, or a backend change, from the mobile side for things that break installed app versions, waste battery and data, or leave the app unable to recover. Use when integrating with an API you didn't design, when backend ships a change, or before a backend deploy that mobile depends on.
---

# Backend Integration Review

The question is always: what happens to the app version already installed on a phone that won't update for a year? ([mindset/constraints.md](../../../mindset/constraints.md) §3)

## Steps
1. **Collect the inputs**: schema or docs, real sample responses (including errors), and the diff if this is a change. Hit the endpoint in a staging environment when you can; docs lie.
2. **List which app versions call it** and with what parsing. Check the app's DTOs and parser settings: strict parsing turns an extra field or new enum value into a crash.
3. **Apply every lens below.** Done when each lens is either clean or has findings.
4. **Rank**: blocker (installed versions crash, lose data or lock End Users out), major (degraded or wasteful), minor.
5. **Propose the fix on the side that should own it.** Backend fixes protect every installed version; app fixes only protect future versions.

## Lenses
- **Compatibility**: removed or renamed fields, changed types or nullability, new enum values, changed error codes, changed defaults, stricter validation of requests old apps still send.
- **Errors**: typed codes vs free text; the app can tell "retry" from "sign in" from "update app" from "your input is wrong".
- **Resilience**: timeouts, rate limits with `Retry-After`, idempotency for retried writes, partial failure in batch calls.
- **Efficiency**: round trips per screen, payload size, pagination, compression, caching headers, polling where a push or delta endpoint fits.
- **Auth**: token lifetime, refresh flow, concurrent refresh, what happens to sessions after a password change.
- **Escape hatches**: minimum-version / force-update signal, feature kill switch, maintenance mode response the app can show.
- **Consistency**: time zones, pagination order stable under inserts, IDs stable across calls.
- **Security and privacy**: personal data in URLs or logs, over-fetching fields the app never shows, auth on every endpoint ([references/core/security.md](../../../references/core/security.md)).
- **Rollout order**: backend deploys before the app ships and stays compatible with the previous app; the app tolerates both old and new backend during the rollout.

## Output
```
Verdict: safe to ship | ship after fixes | blocks release
blocker|major|minor — endpoint/field — what breaks for which app versions — fix (backend|app)
```
For a Non-mobile Developer, explain once why "we'll ship a new app" doesn't fix it: store review plus End Users who never update.

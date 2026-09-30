---
name: networking-layer
description: Build or review the app's HTTP/GraphQL client (timeouts, retries, auth refresh, errors, parsing). Use when adding the first API call, integrating a backend, or debugging auth expiry, flaky requests or parse crashes.
---

# Networking Layer

One client, used by every repository. The network is flaky: [mindset/constraints.md](../../../mindset/constraints.md) §1.

## Blocking Questions
1. Auth scheme? — Recommended: short-lived access token + refresh token ([references/core/security.md](../../../references/core/security.md)).
2. Is there an OpenAPI/GraphQL schema? — Recommended: yes; generate models from it, or write one ([api-contract](../../collaboration/api-contract/SKILL.md)).

## Checklist
Build or review against every line. Done when each line is either implemented or marked "not needed" with a reason.

- **One client**, configured per environment (base URL from config). Stack defaults in `references/stacks/<stack>/`.
- **Timeouts** on connect and request. No infinite waits.
- **Retries** only for idempotent requests or writes carrying an idempotency key. Exponential backoff with jitter, capped.
- **Auth**: attach the token in one place. On 401, a single refresh in flight; queued requests wait for it, then replay once. Refresh failure → sign out cleanly.
- **Errors as values**: map transport, HTTP and server error codes to a typed error the UI can turn into an action (retry, sign in, update app, contact support).
- **Parsing**: lenient. Unknown fields ignored, missing optional fields defaulted, unknown enum values mapped to an `unknown` case. A new backend field must never crash old app versions.
- **DTO → domain mapping** at the boundary. API shapes stay out of the UI.
- **Headers** the backend needs to support old versions: app version, build number, platform, OS version, locale.
- **Cancellation** when the screen goes away.
- **Caching/pagination**: respect ETag/Cache-Control; cursor pagination for lists.
- **Logging**: in debug only, with tokens and personal data redacted.
- **Connectivity**: don't pre-check reachability before calling; make the request and handle the failure. Use connectivity changes only to trigger retries.

## Tests
Against a mock server or fake transport: success, 401 → refresh → replay, refresh failure, timeout, malformed JSON, unknown enum value.

## Output
Client code or a review list: `line — status (ok/missing/wrong) — fix`.

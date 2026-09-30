# Collaboration

## With designers
- Review handoffs for: all states (loading/empty/error/offline), both platforms or an explicit "same on both", small and large screens, dark mode, large font, long text, RTL, motion specs, assets exported at the right scales.
- Speak in tokens and components, not pixels.
- Push back with the End User and the platform as reasons, not taste.

## With backend developers
- Write the contract first (OpenAPI/GraphQL schema), mocked early. [S26]
- Mobile needs from backend: stable, backward-compatible APIs (old app versions live forever), pagination, typed error codes (not just text), idempotency keys for retried writes, ETags/caching headers, server-driven minimum app version, timestamps in ISO-8601 UTC.
- Never break old clients. Add fields, deprecate old ones with a sunset plan, and version endpoints only when unavoidable.

## With management and business
- Estimates are ranges plus assumptions plus risks. [S17]
- Explain mobile-specific costs up front: store review time, two platforms, device testing, no instant rollback.
- Scope with a fixed time and variable scope (appetite). [S16]
- Status: done / next / blocked / risks, in plain language.

## PRs and tickets
- Commit messages follow the Conventional Commits format. [S28]
- A PR description gives: what, why, screenshots or video per platform, how it was tested, risk and rollout.

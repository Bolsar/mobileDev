---
name: versioning-force-update
description: Set up version and build numbering, and a remote minimum-version check with soft and forced update prompts, so the backend can stop supporting old app versions safely. Use when setting up releases, when an old version has a critical bug, or when backend needs to drop support for old clients.
---

# Versioning and Force Update

Old versions live forever unless the app itself can be told to update ([mindset/constraints.md](../../../mindset/constraints.md) §3). The check must ship in version 1.0; it can't be added to versions already installed.

## Steps
1. **Numbering** [S27]: marketing version `MAJOR.MINOR.PATCH` for End Users; build number (`CFBundleVersion`, `versionCode`) monotonically increasing, set by CI. Same marketing version on both platforms for the same feature set.
2. **Send the version** on every API request (header with platform, version, build) so backend can see who calls it ([networking-layer](../../engineering/networking-layer/SKILL.md)).
3. **Remote config** holds per platform: `min_supported_version` (forced), `recommended_version` (soft), store URL, message key. Serve it from remote config or a tiny unauthenticated endpoint that never breaks.
4. **Check** at launch and on return to foreground, using the cached value when offline. Compare versions numerically, not as strings (`1.10.0` > `1.9.0`).
5. **Forced update**: a blocking screen with a clear reason and a button to the store. Before blocking, let the app finish syncing unsent local data if it can, or warn the End User it's waiting.
6. **Soft update**: a dismissible prompt, not every launch. On Android, Play in-app updates [S92] (flexible or immediate) fits well.
7. **Backend as a second guard**: return a typed "update required" error for requests from versions below minimum; the app maps it to the forced-update screen.
8. **Policy**: decide how many versions back you support (e.g. the last 6–12 months), and raise the minimum only after checking how many End Users are still on older versions.
9. **Test**: below min, between min and recommended, current, offline with cached config, malformed config (must fail open, not lock everyone out).

## Output
```
Version scheme: …, build number source: CI
Config: min_supported_version / recommended_version per platform
Behaviors tested: …
Support policy: …
```
For a Business Owner: "a switch that makes very old versions ask to update, so we don't pay to support them forever."

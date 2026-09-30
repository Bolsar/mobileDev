---
name: local-storage
description: Choose and implement on-device storage (preferences, secure storage, database, files) including migrations. Use when persisting data, adding or changing a DB schema, storing tokens, or debugging data lost after an update.
---

# Local Storage

Pick the store with the rubric in [mindset/decisions.md](../../../mindset/decisions.md) (rubric: storage).

## Blocking Questions
1. Is any of it sensitive (tokens, health, payment, personal)? — Recommended: treat as sensitive.
2. Should it survive reinstall or move to a new phone via backup? — Recommended: no for caches and secrets, yes for user content only if the backend doesn't hold it.

## Rules
- **Secrets** go in Keychain/Keystore-backed storage only. Never in preferences, DB or files.
- **No blobs in the DB.** Store images and media as files; keep the path in the DB.
- **Off the main thread.** All DB and file I/O runs on a background dispatcher/isolate/thread.
- **Caches** live in the cache directory and are excluded from backup. The OS may delete them.
- **Sign-out** wipes user data, secure storage entries and caches.

## Migrations (the dangerous part)
An End User can jump from any shipped version to the latest.
1. Every schema change bumps the version and ships a migration. Destructive fallback ("drop and recreate") only for pure caches.
2. Keep a schema snapshot per shipped version (Room exports schemas [S50]; do the same by hand elsewhere).
3. Test migrating from **every** shipped version to the current one, with real-looking data. Done when that test exists and passes.
4. Changing a persisted format outside the DB (preferences keys, JSON files) needs a migration too.

## Output
Store chosen per data type (table), schema, migration code, migration tests, and what is excluded from backup.

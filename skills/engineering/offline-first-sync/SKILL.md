---
name: offline-first-sync
description: Design and build offline reads/writes with background sync and conflict handling. Use when a feature must work without internet, when data must sync across devices, or when debugging lost or duplicated offline edits.
---

# Offline-First Sync

The expensive option. Confirm the feature needs offline **writes** before building this ([mindset/constraints.md](../../../mindset/constraints.md) §1). Grounding: [S25] (offline-first data layer), [S18] (replication and conflicts).

## Blocking Questions
1. Offline reads only, or writes too? — Recommended: reads only, unless End Users work in the field.
2. Can two devices or users edit the same record? — Recommended: assume yes for anything account-scoped.
3. Conflict rule? — Recommended: last-write-wins per record by server timestamp; field-level merge if records are edited in parts.
4. How much data per End User? — Recommended: sync a bounded window (for example last 90 days), not everything.

## Steps
1. **DB is the source of truth.** The UI observes the local DB. The network only updates the DB. Done when no screen reads the API directly.
2. **Outbox.** Each local write goes into the DB and an outbox table in one transaction. Each outbox entry carries a client-generated ID and an idempotency key so a retried push can't duplicate.
3. **Push.** A sync worker drains the outbox in order. Triggers: app foreground, connectivity regained, and OS background work (WorkManager [S52], BGTaskScheduler). The OS decides when background work runs; never promise a schedule.
4. **Pull.** Delta sync with a server cursor (`updated_since` or a change token). Deletes arrive as tombstones. Done when a record deleted on another device disappears locally.
5. **Conflicts.** Apply the agreed rule on the server, not the client. The server returns the winning version; the client overwrites. Surface a conflict to the End User only when data would be lost.
6. **UI states.** Show pending (not yet synced) and failed items. Failed items offer retry or discard. Never silently drop a write.
7. **Edge cases.** Auth expires mid-sync (pause, refresh, resume). App killed mid-push (idempotency covers it). Schema change (migrate the DB and the outbox, see [local-storage](../local-storage/SKILL.md)). Sign-out with unsynced writes (warn first).
8. **Backend contract.** Idempotency keys, delta endpoint, tombstones, server timestamps. Agree it via [api-contract](../../collaboration/api-contract/SKILL.md).

## Tests
Offline write → kill app → relaunch online → pushed once. Two devices edit the same record → the rule holds. Delete on A → gone on B.

## Output
Decision Record (conflict rule, sync window), the DB/outbox schema, the sync trigger list, backend contract changes, and the test list.

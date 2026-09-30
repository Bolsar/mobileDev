---
name: debug-crash
description: Find and fix the root cause of a crash, ANR/hang or device-specific bug. Use when the Requester reports a crash, pastes a stack trace or crash-report link, or says something fails only on some devices, builds or versions.
---

# Debug Crash

Run the loop in [mindset/debugging.md](../../../mindset/debugging.md): reproduce, isolate, matrix, root cause, regression test, guard the release. Its suspect list covers release-only, device-only, after-update and background crashes.

## Steps
1. **Collect.** Stack trace, app version and build, OS, device model, how many End Users, first version affected, breadcrumbs/logs. Ask for anything missing in one batch.
2. **Symbolicate.** dSYM (iOS) [S53], R8 mapping file (Android) [S54], source maps (React Native), `--split-debug-info` symbols (Flutter). Done when the top frames show your file names and lines.
3. **Read the trace.** Find the top in-app frame and the exception type. Check the thread: main-thread crash, or background?
4. **Reproduce.** Match the matrix pattern (OS, OEM, low RAM, locale, fresh install vs upgrade, release vs debug). Done when you can trigger it on demand, or you state why you can't and what data would help.
5. **Root cause.** Fix where the bad value or state originates, not where it explodes. Grep every caller of what you change.
6. **Regression test** that fails without the fix.
7. **Guard the release.** Live crash? Can a remote flag or backend change mitigate it now, before the fixed build clears review?

## Output
```
Crash: <type, top frame, affected users, since version>
Root cause: …
Fix: …
Regression test: …
Mitigation now: <flag/backend change or none>
Verify on: <devices/OS>
```
Unsure of the cause? Say so, and give the next experiment instead of a guess.

# Debugging

## Loop
1. **Reproduce.** Get the exact device, OS, app version, steps, network state and account. No repro means gathering data: logs, crash reports, breadcrumbs. Don't guess.
2. **Isolate by layer.** Ask which layer is wrong:
   - UI (layout, recomposition/re-render)
   - State (a wrong value, a race, stale state after process death)
   - Data (DB migration, cache)
   - Network (request/response, auth token expiry, TLS)
   - OS/platform (permissions, background limits, OEM behavior)
   Bisect: log at each boundary and find where correct turns into wrong.
3. **Check the matrix.** Is it one OS version, one OEM, low-end only, one locale, dark mode, large font, a fresh install versus an upgrade? A pattern points to the cause.
4. **Root cause.** Fix it where the bug originates, not where it shows up. Grep every caller of the code you change.
5. **Regression test.** Write the smallest test that fails without the fix.
6. **Guard the release.** If the bug is already live, can a flag or a backend change mitigate it now while the fix waits for review?
7. **Guard the class.** Could this mistake happen elsewhere? Add the highest guard that works: a type, a boundary or a lint rule ([verification.md](verification.md#when-youre-corrected-climb-the-trust-ladder)).

## Mobile-specific suspects
- **Crash only in release builds:** code shrinking/obfuscation (R8/ProGuard), missing keep rules, stripped symbols, different signing.
- **Works on the simulator, fails on a device:** permissions, entitlements, push, camera, performance, memory.
- **Only after an update:** DB/schema migration, a changed persisted format, keychain access group.
- **Only after time in the background:** process death, a state restore bug, expired tokens.
- **Random crashes on main:** UI touched from a background thread, a race condition.
- **ANR/hang:** I/O or heavy work on the main thread, a deadlock, synchronous IPC.
- **Memory:** retain cycles/leaks (closures, listeners), big bitmaps.

## Reading crash reports
Symbolicate first (dSYM, R8 mapping file, source maps). Group by top in-app frame. Rank by affected users, not by event count. Check the first version where it appeared.

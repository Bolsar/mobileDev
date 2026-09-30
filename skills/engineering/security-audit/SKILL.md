---
name: security-audit
description: Audit a mobile app for common security flaws (secrets in the binary, insecure storage, network config, exported components, deep link input). Use before a launch, after adding auth or payments, or when asked "is this secure?"
---

# Security Audit

Baseline: [references/core/security.md](../../../references/core/security.md), aligned to OWASP MASVS [S11]; test procedures in MASTG [S43]. This is a code-level review, not a penetration test. Say so in the report.

## Steps
Run every check. Done when each has a result: pass, fail with location, or not applicable.

1. **Secrets in the repo and binary.** Search source and config for keys and tokens: `grep -rEn "(api[_-]?key|secret|token|password|sk_live|AIza)" --include=*.{swift,kt,java,dart,ts,tsx,js,json,plist,xml,gradle,properties} .` Anything the app ships is public; third-party secrets belong behind the backend.
2. **Storage.** Tokens and personal data only in Keychain/Keystore-backed storage. Nothing sensitive in preferences, plain DB, files, logs or the clipboard. Sensitive data wiped on sign-out.
3. **Logging.** No tokens, personal data or full responses logged in release builds.
4. **Network.** TLS everywhere. iOS: no broad ATS exceptions (`NSAllowsArbitraryLoads`). Android: no `cleartextTrafficPermitted="true"`. Certificate pinning only with a rotation plan.
5. **Android manifest.** `android:exported` set deliberately on every component; `debuggable` off in release; `allowBackup` / backup rules exclude secrets.
6. **Deep links and intents.** Input validated; no sensitive action runs straight from a link.
7. **WebViews.** JavaScript bridges limited to trusted origins; no file access from web content.
8. **Auth.** Short-lived tokens, refresh flow, server-side session revocation; biometrics unlock a stored credential, they are not the identity.
9. **Business rules** (prices, entitlements, roles) enforced on the server, including purchase receipt validation.
10. **Release build.** Shrinking/obfuscation on; debug menus and test endpoints removed or gated.
11. **Screens with sensitive data** hidden from app-switcher snapshots and, on Android, marked `FLAG_SECURE` where appropriate.
12. **Privacy.** Privacy manifest and Data safety form match what the app and its SDKs collect [S36][S37].

## Output
```
Scope: <what was reviewed> — not a penetration test
Critical: path:line — issue — exploit in one line — fix
High / Medium / Low: …
Passed: <checks>
```

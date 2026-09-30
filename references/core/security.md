# Security [S11]

## Baseline (MASVS-aligned)
- **Storage**: tokens and secrets go in Keychain/Keystore only. No sensitive data in logs, screenshots (app-switcher snapshots), the clipboard or backups.
- **Crypto**: use platform APIs. Never roll your own. No hardcoded keys.
- **Auth**: short-lived access token plus refresh token. Refresh on 401 through a single refresh in flight. Use biometrics to unlock a stored credential, not as the identity.
- **Network**: TLS only (ATS / network security config). Consider certificate pinning only if you can rotate pins safely, because a bad pin bricks old app versions.
- **Platform**: validate deep link and intent input. Don't export Android components you don't need. Restrict WebView JavaScript bridges.
- **Code**: obfuscate/shrink release builds. Assume the binary is reverse-engineered. The server enforces all business rules.
- **Privacy**: collect the minimum. Keep the privacy manifest (iOS) and Data safety form (Play) accurate. [S36][S37]

## Rules
- A secret in the app is not a secret. Proxy third-party API keys through your backend.
- Never trust the client: prices, entitlements and roles are verified server-side (for example, receipt validation for in-app purchases).
- Wipe local sensitive data on logout.

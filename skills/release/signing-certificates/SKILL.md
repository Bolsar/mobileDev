---
name: signing-certificates
description: Set up, audit or recover iOS certificates and provisioning profiles and Android keystores and upload keys, so builds are reproducible and no single laptop or person can lose the app. Use for "code signing error", "provisioning profile doesn't match", lost keystore, new CI setup, or a developer leaving the team.
---

# Signing and Certificates

Signing identity is the app's ownership. Lose the Android app signing key without Play App Signing, and you can't update the app, ever. Treat keys like production secrets ([references/core/security.md](../../../references/core/security.md)).

## Steps
1. **Inventory**: who owns the Apple and Play accounts; which certificates, profiles, keystores, APNs keys and upload keys exist; where they are stored; who has access. Done when each item has a location and two people who can reach it.
2. **Android**:
   - Enroll in Play App Signing [S84]: Google holds the app signing key; you hold an upload key, which can be reset through Play support if lost [S88].
   - Keystore and passwords in a secret manager and CI secrets, never in the repo or in `gradle.properties` checked in.
   - Debug and release keys separate; note the SHA-256 fingerprints (needed for App Links, Google sign-in, Firebase).
3. **iOS** [S85]:
   - Distribution certificate and profiles managed by one mechanism: Xcode automatic signing for small teams, or fastlane match [S87] / Expo EAS credentials for CI and teams. Don't mix.
   - APNs via an auth key (.p8), not per-app certificates; it doesn't expire yearly.
   - Track expiry dates of certificates and profiles; a calendar reminder before each.
4. **CI**: signing material injected from secrets at build time ([ci-cd-setup](../ci-cd-setup/SKILL.md)).
5. **Offboarding**: when someone leaves, remove their account access, rotate any key they had locally (iOS certificate revocation doesn't affect installed apps; verify for enterprise distribution).

## Debugging signing errors
Read the exact error. Check in order: bundle/application ID matches; profile includes the device (development) and the capability (push, associated domains); certificate in the profile matches the private key present; profile not expired; team ID correct in the project and extensions (each extension needs its own profile).

## Output
```
Inventory: item — location — owners — expires
Risks: item — consequence — fix
Setup done: …
```
For a Business Owner: one line on why accounts and keys must belong to the company, and who holds the backup.

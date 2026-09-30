---
name: android-store-submission
description: Prepare and publish an Android app (first release or update) on Google Play, from app bundle to staged rollout, including policy forms and testing requirements. Use when asked to "publish to Google Play", set up testing tracks, or plan an Android release.
---

# Android Store Submission

Play review is usually faster than Apple's but policy forms, target SDK deadlines and testing requirements block releases more often. Policies change: check the current Play Policy Center [S10] and target SDK rules [S83].

## Blocking Questions
1. Play developer account: organization or personal, and how old? — Recommended: organization owned by the Requester's company. New personal accounts must run a closed test with a minimum number of testers for a minimum period before production access (verify current numbers).
2. First release or update? — Recommended: first release → internal testing, then closed testing, then production.

## Steps
1. **Package and signing**: unique application ID; Android App Bundle (AAB) [S93]; Play App Signing enrolled with a separate upload key [S84] ([signing-certificates](../signing-certificates/SKILL.md)).
2. **Build**: `versionCode` incremented, `versionName` set ([versioning-force-update](../versioning-force-update/SKILL.md)); `targetSdk` meets the current Play requirement [S83]; R8 mapping file uploaded to Play and crash reporting.
3. **Policy forms in Play Console**: Data safety section matching what the app and every SDK collect [S37]; content rating questionnaire; target audience (children → extra rules); ads declaration; permissions declarations for sensitive permissions (SMS, call log, all-files access, background location, exact alarms) with a video if asked; account deletion URL if accounts exist.
4. **Testing tracks** [S101]: internal (minutes, up to 100 testers) → closed → open (optional). Pre-launch report runs your app on real devices; read it.
5. **Store listing**: title, short and full description, icon, feature graphic, phone and tablet screenshots ([store-assets](../../design/store-assets/SKILL.md)), privacy policy URL.
6. **Release** [S82] as a staged rollout: 1% → 5% → 20% → 50% → 100%, gated on crash-free and ANR rates in Android vitals [S20]. Halt the rollout on a spike; a halted release stops reaching new devices but installed ones keep it, so fix with a flag or a higher `versionCode`.
7. **Rejected or suspended** → [store-rejection-fix](../store-rejection-fix/SKILL.md).

## Output
```
Ready: yes | blocked by …
Checklist: item — done | missing — owner
Rollout plan: stages — gate metrics — halt rule
```
For a Business Owner: the timeline including any mandatory closed-testing period, and which forms need their legal or business answers.

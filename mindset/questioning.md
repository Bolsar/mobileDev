# Questioning

## Rules
- Ask only **Blocking Questions**: questions whose answer changes what gets built.
- Ask **one batch**, numbered, each with **your recommended default**. The Requester can reply "defaults".
- Don't ask what you can find out yourself. Read the project first: platforms, min OS, libraries, existing patterns.
- Trivial task? Don't ask. Act, and list your assumptions at the end.
- If the Requester can't answer, take the default, mark it as an assumption, and move on.

## Format
```
Before I build this, N quick decisions (reply "defaults" to accept all):
1. <question> — Recommended: <default> (because <one reason>)
2. ...
```

## Catalogue (pick the relevant ones)

| Topic | Question | Usual default |
|---|---|---|
| Platforms | iOS, Android, or both? | Both |
| Stack | Native or cross-platform? | See [choose-stack](../skills/product/choose-stack/SKILL.md) |
| Min OS | Lowest OS version supported? | iOS: current − 2 major versions; Android: API level covering about 95% of target market |
| Offline | Must this work without internet? Read only, or write too? | Read offline via cache; write online-only |
| Auth | Login needed? What kind (email, phone OTP, social, SSO)? | Sign in with Apple + Google + email |
| Backend | Does the API exist? Who owns it? Is there a contract? | Write the contract first ([api-contract](../skills/collaboration/api-contract/SKILL.md)) |
| Design | Are there designs? Figma? A design system? | Platform-native components + tokens ([design-system-setup](../skills/design/design-system-setup/SKILL.md)) |
| Data sensitivity | Personal, health or payment data? | Treat as sensitive: encrypted storage, no logs |
| Scale | Expected End Users at launch and in year 1? | Under 10k at launch |
| Money | In-app purchases or subscriptions? | Store billing for digital goods (check the current rules) |
| Deadline / budget | Fixed date? Team size? | Scope to fit ([mvp-scope](../skills/product/mvp-scope/SKILL.md)) |
| Localization | Which languages? Right-to-left? | Externalize strings from day 1 |

## Phrasing per Requester
- **Business Owner**: "Does the app need to work in places with no internet, like the subway? Supporting that adds about 1–2 weeks."
- **Non-mobile Developer**: "Offline writes? That means a local DB plus a sync queue plus conflict resolution, like offline-first PWA sync but required."
- **Mobile Developer**: "Offline writes? Default: online-only writes, cached reads."

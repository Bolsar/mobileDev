# Decisions

## Method
1. List 2–3 real options. Never more than 3.
2. Score them against the criteria that matter for **this** Requester: team skills, time to market, performance needs, platform APIs needed, long-term cost.
3. Pick one. Write a Decision Record:
```
Pick: <X>
Why: <1–3 reasons tied to this project>
Alternatives: <Y> — better when <condition>
Revisit if: <trigger>
```
4. Prefer reversible choices. Spend more thought on the hard-to-reverse ones: stack, backend contract, data model, auth provider.

## Rubric: native vs cross-platform
| Signal | Leans to |
|---|---|
| Heavy platform APIs (AR, widgets, watch, CarPlay, background audio, Bluetooth-heavy work) | Native |
| Top-tier animation/performance is the product | Native (or Flutter) |
| Small team, both platforms, CRUD/content app | Flutter or React Native |
| Team already strong in React/TypeScript | React Native (Expo) |
| Pixel-identical custom UI on both platforms | Flutter |
| Existing native app | Stay native; share logic via KMP if needed |

## Rubric: state management
- Start with the platform's default: SwiftUI `@Observable`, Compose + ViewModel + StateFlow, Flutter `ChangeNotifier` ViewModels per the official guide (Riverpod or Bloc when the team already uses them), React Native with local state + TanStack Query.
- Use unidirectional data flow: state goes down, events go up.
- Server state (cache) is not the same as UI state. Don't put API caches in a global store by hand; use a query/cache layer.

## Rubric: storage
| Need | Use |
|---|---|
| Small preferences | UserDefaults / DataStore / shared_preferences / MMKV |
| Secrets/tokens | Keychain / Keystore (EncryptedSharedPreferences deprecated; use Keystore-backed) / flutter_secure_storage / expo-secure-store |
| Structured, queryable, offline | SQLite-based: SwiftData/GRDB, Room, Drift, op-sqlite/WatermelonDB |
| Files/media | App sandbox files + DB index |

## Rubric: build vs buy
Buy (SaaS/SDK) when it's not your core and the SDK is maintained: auth, crash reporting, push delivery, analytics, payments.
Build when it's your core value, the SDK is heavy or abandoned, or privacy rules forbid third parties.
Before adding any SDK, check: binary size, privacy-manifest support, maintenance activity, license.

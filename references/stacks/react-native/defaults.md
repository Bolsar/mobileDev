# React Native — Greenfield Defaults

TypeScript + React Native via Expo [S23][S24]. Greenfield only; an existing project keeps what it uses ([README](../README.md)).

## Picks
| Concern | Pick | Why | Alternative (when) |
|---|---|---|---|
| Framework | Expo with development builds and Continuous Native Generation (`app.config.ts` + config plugins) [S141][S142] | Native projects regenerated from config; upgrades and native modules stay manageable | Bare React Native CLI when a large existing native codebase must be hand-edited |
| Language | TypeScript, `strict: true` [S152] | Catches bad API data shapes at compile time | — |
| Architecture | New Architecture (default in current RN) [S143] | Required by current libraries | — |
| Navigation | Expo Router (file-based) [S140] | Deep links and typed routes out of the box | React Navigation directly (Expo Router is built on it) if the project already uses it |
| Server state | TanStack Query [S55] | Caching, retries, refetch on focus/reconnect; no hand-written cache in a global store | — |
| App state | React context or Zustand [S151] for the few truly global values | Small and explicit | Redux Toolkit only if the project already uses it |
| Networking | `fetch` + one small typed client; validate responses with `zod` at the boundary | No extra dependency for HTTP; runtime validation of untrusted data | axios if the project has it |
| Structured storage | `expo-sqlite` [S153] (with Drizzle if you want typed queries) | Built into Expo | WatermelonDB or op-sqlite for heavy offline sync |
| Preferences | `react-native-mmkv` [S150] | Fast, synchronous | AsyncStorage in existing projects |
| Secrets/tokens | `expo-secure-store` (Keychain/Keystore) | Platform secure storage | — |
| Lists | FlashList [S145] | Recycling, far fewer blank cells than FlatList | FlatList for short lists |
| Images | `expo-image` | Disk cache, placeholders, modern formats | — |
| Animation | Reanimated [S146] + Gesture Handler | Runs on the UI thread | `Animated` with `useNativeDriver` for trivial fades |
| Localization | `expo-localization` + i18next | Plurals, interpolation, locale detection | — |

## Layout
```
app/                    # Expo Router routes only: thin files that render feature screens
  (tabs)/orders.tsx
src/
  features/orders/      # OrdersScreen.tsx, useOrders.ts (query hook), api.ts, types.ts
  core/api/             # client, error mapping, zod schemas
  core/storage/         # secure store, MMKV, SQLite setup
  core/ui/              # design system: theme, tokens, primitives (PrimaryButton, Card)
  domain/               # plain TS models and logic, no React imports
```

## Screen wiring
```tsx
// features/orders/useOrders.ts
export function useOrders() {
  return useQuery({ queryKey: ['orders'], queryFn: api.orders });  // api.orders parses with zod
}

// features/orders/OrdersScreen.tsx
export function OrdersScreen() {
  const { data, error, isPending, refetch } = useOrders();
  const isOffline = useIsOffline();   // NetInfo, also wired to TanStack Query's onlineManager

  if (isPending) return <LoadingView />;
  if (error) return <ErrorView error={toAppError(error, isOffline)} onRetry={refetch} />;  // offline + retry
  if (data.length === 0) return <OrdersEmptyView />;
  return <FlashList data={data} renderItem={({ item }) => <OrderRow order={item} />} keyExtractor={(o) => o.id} />;
}
```
Dependencies: the API client is a module passed to query functions or provided via one context; tests swap the network at the edge (MSW or a fake `fetch`), not the hooks.

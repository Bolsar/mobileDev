# Flutter — Greenfield Defaults

Dart 3 + Flutter, following the official architecture guide: views, ViewModels, repositories, services [S22][S127]. Greenfield only; an existing project keeps what it uses ([README](../README.md)).

## Picks
| Concern | Pick | Why | Alternative (when) |
|---|---|---|---|
| State holder | `ChangeNotifier` ViewModel per screen, rendered with `ListenableBuilder` [S127] | Built in, no extra package, matches the official guide | Riverpod [S136] when the team knows it or the app has lots of cached async data; Bloc [S137] when the team wants explicit events and a strict audit trail |
| DI | Constructor injection, graph built in `main()`; `provider` only to hand repositories down the tree | Compile-checked, no service locator [S56] | Riverpod providers if Riverpod is chosen; avoid `get_it` as a global locator |
| Models | Dart 3 `sealed class` / records + `json_serializable` | Exhaustive `switch`, no heavy codegen | `freezed` when you need `copyWith`/equality on many models |
| Navigation | `go_router` [S131] | Official package, URL-based, deep links | Navigator 2.0 by hand only for unusual flows |
| Networking | `http` package + one small client class | Minimal | `dio` when you need interceptors, cancellation or upload progress |
| Structured storage | Drift (SQLite) [S132] | Typed queries, streams, tested migrations | `sqflite` in existing projects |
| Preferences | `shared_preferences` (`SharedPreferencesAsync`) | Official | — |
| Secrets/tokens | `flutter_secure_storage` (Keychain/Keystore) | Platform secure storage | — |
| Images | `cached_network_image` | Disk cache, placeholders | `Image.network` for a few non-list images |
| Localization | `gen-l10n` with ARB files [S47] | Official, typed accessors | — |
| Environments | Flavors + `--dart-define-from-file` [S133] | One binary config per environment | — |

## Layout
```
lib/
  main_dev.dart / main_prod.dart   # build the graph, runApp
  app/                             # MaterialApp.router, theme, router
  ui/checkout/                     # checkout_screen.dart, checkout_view_model.dart
  ui/core/                         # design system: tokens, ThemeExtension, primitives
  data/repositories/               # OrdersRepository (single source of truth)
  data/services/                   # ApiClient, database, platform wrappers
  domain/models/                   # plain Dart models, no Flutter imports
test/                              # mirrors lib/; fakes live here
```
Split into local packages (`packages/core`, `packages/feature_x`) only when build times or team boundaries demand it.

## Screen wiring
```dart
sealed class OrdersState {}
class OrdersLoading extends OrdersState {}
class OrdersEmpty extends OrdersState {}
class OrdersLoaded extends OrdersState { OrdersLoaded(this.orders); final List<Order> orders; }
class OrdersFailed extends OrdersState { OrdersFailed(this.error); final AppError error; }  // AppError.offline → offline + retry

class OrdersViewModel extends ChangeNotifier {
  OrdersViewModel({required OrdersRepository repository}) : _repository = repository;
  final OrdersRepository _repository;

  OrdersState _state = OrdersLoading();
  OrdersState get state => _state;

  Future<void> load() async {
    _set(OrdersLoading());
    try {
      final orders = await _repository.orders();
      _set(orders.isEmpty ? OrdersEmpty() : OrdersLoaded(orders));
    } on Exception catch (e) {
      _set(OrdersFailed(AppError.from(e)));
    }
  }

  void _set(OrdersState s) { _state = s; notifyListeners(); }
}

// In the screen:
ListenableBuilder(
  listenable: viewModel,
  builder: (context, _) => switch (viewModel.state) {
    OrdersLoading() => const LoadingView(),
    OrdersEmpty() => const OrdersEmptyView(),
    OrdersLoaded(:final orders) => OrdersList(orders: orders),
    OrdersFailed(:final error) => ErrorView(error: error, onRetry: viewModel.load),
  },
)
```
The route creates the ViewModel with its repository and disposes it with the screen.

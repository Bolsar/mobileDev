# Android — Greenfield Defaults

Kotlin + Jetpack Compose, following the official architecture guide [S7] and Now in Android [S34]. Greenfield only; an existing project keeps what it uses ([README](../README.md)).

## Picks
| Concern | Pick | Why | Alternative (when) |
|---|---|---|---|
| UI | Jetpack Compose + Material 3 [S6] | Official default toolkit | Views/XML only in legacy screens; migrate per [migrate-legacy-ui](../../../skills/engineering/migrate-legacy-ui/SKILL.md) [S48] |
| State holder | `ViewModel` exposing one `StateFlow<UiState>` [S114] | Survives configuration changes; lifecycle-aware collection | Plain state-holder class for UI-only logic inside a composable |
| Async | Kotlin coroutines + Flow [S113] | Official, structured, cancellable | — |
| Navigation | Navigation Compose with type-safe `@Serializable` routes [S117] | Compile-checked arguments, deep link support | Navigation 3 for new apps once it fits your setup; verify its current status in the docs |
| Networking | Retrofit + OkHttp + kotlinx.serialization [S125] | Mature, interceptors for auth/logging | Ktor client if sharing the network layer via KMP |
| Structured storage | Room [S118] | SQLite with compile-checked queries, Flow, tested migrations [S50] | SQLDelight if you go KMP |
| Preferences | DataStore (Preferences or typed) [S119] | Async, transactional; replaces SharedPreferences | — |
| Secrets/tokens | Android Keystore key encrypting a DataStore value | EncryptedSharedPreferences is deprecated | — |
| Images | Coil [S126] | Kotlin- and Compose-first, small | Glide if the project has it |
| Background work | WorkManager [S52] | Survives process death and reboot, respects Doze | Foreground service only for user-visible ongoing work (with the right type) |
| DI | Constructor injection, graph assembled in `Application` [S116] | No codegen, compile-checked [S56] | Hilt when the app is multi-module with several teams, or the project already uses it |
| Build | Gradle Kotlin DSL + version catalog (`libs.versions.toml`) [S122], KSP (not kapt) | One place for versions, faster builds | — |

## Layout
```
app/src/main/java/com/acme/app/
  App.kt                 # Application: builds the dependency graph (leaves up)
  MainActivity.kt        # single activity, edge-to-edge, hosts NavHost
  feature/checkout/      # CheckoutScreen.kt, CheckoutViewModel.kt, CheckoutRoute.kt
  core/network/          # Retrofit service, OkHttp client, error mapping
  core/data/             # repositories
  core/database/         # Room DB, DAOs, migrations
  core/designsystem/     # theme, tokens, primitives (PrimaryButton, Card)
```
Split into Gradle modules (`:core:*`, `:feature:*`) when build times hurt or teams collide; features never depend on each other [S34].

## Screen wiring
```kotlin
sealed interface OrdersUiState {
    data object Loading : OrdersUiState
    data object Empty : OrdersUiState
    data class Loaded(val orders: List<Order>) : OrdersUiState
    data class Failed(val error: AppError) : OrdersUiState   // AppError.Offline renders offline + retry
}

class OrdersViewModel(private val repo: OrdersRepository) : ViewModel() {
    private val _state = MutableStateFlow<OrdersUiState>(OrdersUiState.Loading)
    val state: StateFlow<OrdersUiState> = _state.asStateFlow()

    init { load() }

    fun load() = viewModelScope.launch {
        _state.value = OrdersUiState.Loading
        _state.value = repo.orders().fold(
            onSuccess = { if (it.isEmpty()) OrdersUiState.Empty else OrdersUiState.Loaded(it) },
            onFailure = { OrdersUiState.Failed(AppError.from(it)) },
        )
    }

    companion object {
        fun factory(repo: OrdersRepository) = viewModelFactory { initializer { OrdersViewModel(repo) } }
    }
}

@Composable
fun OrdersRoute(viewModel: OrdersViewModel) {
    val state by viewModel.state.collectAsStateWithLifecycle()
    OrdersScreen(state, onRetry = viewModel::load)   // stateless, previewable per state
}
```
The factory receives only the ViewModel's direct dependencies, taken from the graph built in `App`. Don't pass the whole graph into features.

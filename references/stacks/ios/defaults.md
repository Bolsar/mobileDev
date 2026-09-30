# iOS — Greenfield Defaults

Swift + SwiftUI. Greenfield only; an existing project keeps what it uses ([README](../README.md)).

## Picks
| Concern | Pick | Why | Alternative (when) |
|---|---|---|---|
| UI | SwiftUI | Default Apple UI toolkit; less code, previews, dynamic type and dark mode for free [S33] | UIKit for screens SwiftUI still can't do well (complex text editing, some collection layouts), hosted via `UIViewRepresentable` [S49] |
| Language mode | Swift 6 language mode, strict concurrency on | Data races become compile errors [S103][S112] | Swift 5 mode + warnings while migrating an old codebase |
| State holder | `@Observable` class per screen, `@MainActor` [S104] | Fine-grained updates, no Combine boilerplate | `ObservableObject` only if min OS is below iOS 17 |
| Navigation | `NavigationStack` with a typed `Route` enum and a path array [S107] | Deep links become "build the path array" | Coordinator in UIKit apps |
| Networking | `URLSession` async/await + `Codable` | Built in; one small client type covers auth, retry, decoding | Alamofire only if the project already has it |
| Structured storage | SwiftData for simple models [S105] | Built in, less code | GRDB when you need SQL, complex queries, sync, or migrations you fully control [S108] |
| Preferences | `UserDefaults` / `@AppStorage` | Built in | — |
| Secrets/tokens | Keychain, via a ~50-line wrapper | Built in | KeychainAccess if the project has it |
| Images | `AsyncImage` for simple cases | Built in | Nuke or Kingfisher when you need disk caching, prefetching or downsampling in long lists |
| DI | Initializer injection, graph built in the `App` struct | Compile-time checked [S56] | `@Environment` for values many views need (theme, a store) |
| Localization | String Catalogs (`.xcstrings`) [S111] | Built in, tracks plurals and stale keys | — |
| Dependencies | Swift Package Manager | Built into Xcode | CocoaPods only for legacy projects (it is in maintenance mode) |

## Layout
```
App/                  # @main App, root composition (builds the dependency graph)
Features/
  Checkout/           # CheckoutView, CheckoutModel (@Observable), Checkout.make(...)
Core/
  Network/            # APIClient, Endpoint, error mapping
  Storage/            # Keychain wrapper, DB setup
  DesignSystem/       # tokens, primitives (named by what they are: PrimaryButton, Card)
Resources/            # Assets.xcassets, Localizable.xcstrings, PrivacyInfo.xcprivacy
```
Split `Core` and big features into local Swift packages when build times hurt or teams collide ([architecture](../../core/architecture.md)).

## Screen wiring
```swift
@MainActor @Observable
final class OrdersModel {
    enum State { case loading, empty, loaded([Order]), failed(AppError) }
    private(set) var state: State = .loading
    private let loadOrders: () async throws -> [Order]   // one operation: pass a function

    init(loadOrders: @escaping () async throws -> [Order]) { self.loadOrders = loadOrders }

    func load() async {
        state = .loading
        do {
            let orders = try await loadOrders()
            state = orders.isEmpty ? .empty : .loaded(orders)
        } catch { state = .failed(AppError(error)) }
    }
}

struct OrdersView: View {
    @State var model: OrdersModel
    var body: some View {
        content.task { await model.load() }   // cancelled automatically when the view goes away
    }
    // `content` switches over model.state: loading, empty, loaded, failed (with offline + retry)
}
```
The view owns the model with `@State`; the parent creates it with its dependencies. Offline is a case of `AppError`, rendered with a retry action.

# Testing

## Shape [S19][S56]
- **Many feature-level tests** that run real production code through the state holder, domain and repositories, with fakes only at the lowest boundary: the network transport (`URLProtocol` stub, OkHttp `MockWebServer`, a fake HTTP client), the DB (in-memory), the clock. Fast, run on the JVM/host. Test the stable, high-level feature; its volatile internals get covered on the way.
- **Some integration tests**: DB migrations, API client against a mock server, navigation.
- **Few UI/E2E tests**: critical flows only (login, purchase, onboarding). Use XCUITest, Espresso/Compose test, Flutter integration_test, Maestro/Detox.
- **Snapshot/screenshot tests** for the design system and key screens across light/dark and large font.
- **Small isolated unit tests** only for pure logic worth pinning on its own: mappers, parsers, calculations.

## What to always test
- Every state of a state holder: loading, then success, error, empty.
- DB migrations from **every shipped schema version**.
- JSON parsing with missing, extra and null fields (the backend will surprise you).
- Process-death restore for multi-step flows.
- Anything that has regressed before.

## Practices
- Mock at the edge of the system, not between your own classes. Mocking every intermediate class tests the mocks and leaves the seams between real classes untested.
- Test behavior through public APIs, not private details that change with every refactor.
- Fakes over mocks. For a single operation, inject a function and pass a stub function in tests.
- Test data factories (for example `Order.stub()` / `Order.default`) live in the test target, not production code.
- Inject clocks and dispatchers/schedulers. No sleeps in tests.
- Keep flaky tests out of main: quarantine, fix, or delete.
- Test on real devices before release: one low-end Android, one older iPhone, plus a tablet if you support tablets.

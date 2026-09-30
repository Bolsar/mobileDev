# Performance

## Budgets [S20][S21]
- Cold start: under 2s to first meaningful content on a mid-range device. Measure time to initial display (TTID) and time to full display (TTFD).
- Frames: no dropped frames while scrolling (60/120Hz). Main-thread work under about 16ms per frame (8ms at 120Hz).
- ANR (Android): the main thread blocked for 5s or more. Hangs (iOS): more than 250ms is noticeable.
- App size: every MB lowers install conversion on slow networks. Track it per release.

## Common wins
- **Startup**: defer SDK initialization, lazy-load, no network on the main thread, Baseline Profiles (Android), avoid heavy work at app launch.
- **Lists**: use lazy/recycled lists, stable keys, fixed-height items where possible, no work inside item builders.
- **Images**: decode at display size, cache in memory and on disk, use modern formats (WebP/AVIF/HEIC).
- **Rendering**: avoid unnecessary recomposition/re-render. Use stable/immutable state, memoization, and small components.
- **Network**: batch requests, cache with ETags, paginate, prefetch the next page.

## Measure, don't guess
Use Xcode Instruments (Time Profiler, Allocations, Hangs), Android Studio Profiler, Macrobenchmark, Perfetto, Flutter DevTools, and React Native DevTools/Perf Monitor. Profile **release builds on a real device**, never debug builds on the simulator.

---
name: performance-audit
description: Measure and fix app performance (slow startup, janky scrolling, memory, battery, network). Use when the app "feels slow", drops frames, gets ANRs/hangs, is killed for memory, or drains battery.
---

# Performance Audit

Budgets, common wins and tools: [references/core/performance.md](../../../references/core/performance.md). App size has its own skill: [app-size-reduction](../../release/app-size-reduction/SKILL.md).

## Steps
1. **Name the symptom** and the budget it breaks: startup, frames, hangs/ANR, memory, battery, network. Get the device and OS where it shows.
2. **Measure a baseline** on a **release build on a real device**, mid- or low-end. Debug builds and simulators lie. Done when you have a number (ms, fps, MB, % battery) and how you got it.
3. **Profile** with the platform tool to find where the time or memory goes. Record the top 3 offenders with evidence (trace, flame graph, allocation list).
4. **Fix the biggest offender first.** Usual causes:
   - Startup: SDKs initialized at launch, synchronous I/O or network before first frame, large DI graph built eagerly.
   - Frames: work in list item builders, unstable keys, images decoded at full size, re-rendering whole screens.
   - Memory: leaked screens (listeners, closures), unbounded caches, full-size bitmaps.
   - Battery: polling, precise location left on, wake locks, retry loops without backoff.
   - Network: chatty screens (N+1 requests), no caching, oversized payloads.
5. **Re-measure** the same way. Keep a fix only if the number moved.
6. **Guard it**: a benchmark or a CI metric where the stack supports it (Macrobenchmark, XCTest metrics).

## Output
```
Symptom: … Budget: …
Baseline: <number, device, build, method>
Offenders: 1. … (evidence)
Fixes: change — before → after
Guard: …
```

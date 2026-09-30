---
name: app-size-reduction
description: Measure and reduce app download and install size on iOS and Android, largest contributor first. Use when the app is "too big", download conversion is low in slow-network markets, or size crosses a store cellular-download limit.
---

# App Size Reduction

Size costs installs, especially on slow or metered networks and low-storage devices ([mindset/constraints.md](../../../mindset/constraints.md) §6). Measure what End Users download, not the size of the file you uploaded.

## Steps
1. **Measure the real size**: iOS App Store Connect size report per device or the App Thinning Size Report [S94]; Android Play Console download size per device, or `bundletool get-size total` [S95]. Record the baseline.
2. **Find the top contributors**: Xcode build report / Emerge-style analysis; Android Studio APK Analyzer. Group by: native libs, assets (images, video, fonts, Lottie), dependencies/SDKs, code, localizations. Done when the top 5 contributors are known with sizes.
3. **Fix largest first**:
   - **Assets**: vectors where possible; WebP/AVIF/HEIC for raster; remove unused; download rarely used or large media on demand.
   - **Dependencies**: remove unused SDKs; replace heavy ones used for one function; check duplicate libraries.
   - **Code shrinking**: R8 full mode on Android [S54]; dead-code stripping and `-Osize` where performance allows on iOS.
   - **Delivery**: Android App Bundle [S93] (splits by ABI, density, language), Play Feature Delivery for rare features; iOS On-Demand Resources for large optional content.
   - **Native libs**: ship only needed ABIs; strip symbols (upload them to crash reporting first).
   - **Fonts and locales**: subset fonts; drop unused locales from dependencies.
4. **Verify** each change: size down, app still works on a clean install, crash symbolication still works.
5. **Guard**: CI step that reports size per PR and fails above a budget.

## Output
```
Baseline: iOS <MB>, Android <MB> (download, typical device)
Top contributors: item — size
Changes: change — saved — risk
After: …
Budget & CI guard: …
```
For a Business Owner: size in MB before/after and why it matters in their markets.

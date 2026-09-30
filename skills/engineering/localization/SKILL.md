---
name: localization
description: Prepare and add languages to an app (externalized strings, plurals, formatting, right-to-left, pseudolocale testing). Use when adding a language, supporting RTL, fixing hardcoded strings, or formatting dates, numbers and currency.
---

# Localization

Platform docs: iOS [S44], Android [S45][S46], Flutter [S47].

## Blocking Questions
1. Which languages, and any right-to-left (Arabic, Hebrew, Persian, Urdu)? — Recommended: externalize now even if English-only.
2. Any language with two scripts (for example Uzbek Latin `uz-Latn` / Cyrillic `uz-Cyrl`, Serbian)? — Recommended: pick one per market; support both only if asked.
3. Who translates? — Recommended: a translation service or vendor working from exported string files, never machine-translated at runtime.

## Steps
1. **Externalize every string** in the platform format: String Catalogs, `strings.xml`, ARB with `gen-l10n`, or an i18n library in React Native. Done when a search for quoted UI text in views finds none.
2. **Whole sentences with placeholders.** Never concatenate fragments. Named or numbered placeholders so translators can reorder.
3. **Plurals** through the platform plural rules (several languages have more than two forms). Never `count == 1 ? … : …`.
4. **Format with locale APIs**: dates, times, numbers, currency, units. Store and send dates as ISO-8601 UTC; format only for display.
5. **Layout survives text growth** of 30–40% and RTL mirroring: leading/trailing and start/end, never left/right. Directional icons mirror; logos and media controls don't.
6. **Test with pseudolocales**: Android `en-XA` (long accented) and `ar-XB` (RTL); Xcode scheme options for double-length and right-to-left pseudolanguages.
7. **Per-app language**: support the OS per-app language setting (iOS Settings, Android 13+) instead of a custom in-app switcher, unless the Requester needs one.
8. **Store listing** and screenshots localized too ([store-assets](../../design/store-assets/SKILL.md)).

## Output
String files, the list of hardcoded strings fixed, pseudolocale screenshots or findings, and the languages still needing translation.

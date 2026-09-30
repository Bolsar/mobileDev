---
name: analytics-plan
description: Design the analytics events for a feature or app from the questions the business needs answered, with naming, properties, consent and verification. Use before building a feature, when asked "what should we track?", or when existing analytics are a mess.
---

# Analytics Plan

Track to answer questions, not to collect data. Every event costs privacy disclosure, battery, and maintenance for years in old versions.

## Blocking Questions
1. Which questions must the data answer? — Recommended: the feature's success metric plus the funnel to it.
2. Tool, and does the app need consent before tracking? — Recommended: the tool already in use; consent required wherever the End User's region's law or the store requires it (verify; ATT on iOS for cross-app tracking [S102]).

## Steps
1. **Write the questions** (3–5): "What % of new End Users complete their first order within 24h?". Done when each maps to a metric.
2. **Derive events** from the questions only. For each: name, trigger (the exact moment), properties with types and allowed values, platforms.
3. **Naming**: one convention, `object_action` in snake_case (`order_completed`), past tense, same names on iOS and Android. Properties are enums or numbers, not free text.
4. **Privacy**: no personal data (email, name, precise location, free-text input) in events; opaque user IDs; consent gates collection where required; disclosures updated (App Privacy, Data safety [S99][S37]).
5. **Implement** behind one small analytics module so features call `track(Event)` and tools can change. Queue offline; send in batches.
6. **Verify** in the tool's debug view on both platforms before release: each event fires once, at the right moment, with correct properties. Add to the release checklist.
7. **Maintain**: the tracking plan lives in the repo; old app versions keep sending old events, so renaming an event breaks the chart unless both are mapped.

## Output
```
Question — metric — events
event_name — trigger — properties {name: type/values} — platforms
Consent: … — Disclosures to update: …
```
For a Business Owner: the questions and the dashboard they will get, not the event list.

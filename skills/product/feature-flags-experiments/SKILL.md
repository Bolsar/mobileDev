---
name: feature-flags-experiments
description: Add remote feature flags, kill switches, staged rollouts or A/B experiments to a mobile app, and plan their removal. Use when shipping a risky feature, when asked about A/B testing, remote config, "turn it off without a release" or gradual rollout.
---

# Feature Flags and Experiments

A binary can't be rolled back; a flag can [S30]. Every risky feature ships behind one ([references/core/release.md](../../../references/core/release.md)).

## Blocking Questions
1. Existing flag or remote-config tool? — Recommended: reuse it; none → a hosted remote config (e.g. Firebase Remote Config [S80]) before building your own.
2. Is this a release toggle (on/off safety) or an experiment (measure which variant wins)? — Recommended: release toggle; experiments need traffic and a metric decided up front.

## Steps
1. **Name the flag and its kind**: release, kill switch, experiment, or permission (entitlement). Kind decides its lifetime.
2. **Define the default** compiled into the app. It must be the safe value, because first launch, offline and fetch failure all use it.
3. **Fetch and cache**: read the cached value at launch, refresh in the background, apply on next launch or at a safe screen boundary. Never flip UI under the End User mid-flow.
4. **Evaluate in one place** (a small flags module the features call), so code has one `if` per flag and tests can set values.
5. **Target and roll out**: by app version, platform, country, percentage. Bucket by a stable ID so an End User doesn't flip between variants.
6. **Experiments only**: write the hypothesis, primary metric, guardrail metrics (crash rate, retention), minimum sample and run time before starting [S79]. Don't stop early on a good-looking day. Log exposure when the End User actually sees the variant.
7. **Plan removal**: owner and expiry date per flag; a ticket to delete it after 100% rollout. Old app versions still read the flag, so keep serving its final value until they're below your minimum version.
8. **Test** both values, the default with no network, and the transition.

## Output
```
Flag: <name> — kind — default — targeting — owner — expires
Rollout: 1% → 5% → 20% → 50% → 100%, gate: crash-free rate and <metric>
Experiment (if any): hypothesis — primary metric — guardrails — sample/duration
Removal: ticket — when safe for old versions
```
For a Business Owner: explain a flag as "an off switch we control from a dashboard, no app update needed".

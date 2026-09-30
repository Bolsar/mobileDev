---
name: choose-stack
description: Recommend native iOS/Android, Flutter, React Native or KMP for a new app (or a rewrite), with a Decision Record tied to the team, product and budget. Use when the Requester asks "which technology should we use?", "native or cross-platform?", or is starting a new app.
---

# Choose Stack

The hardest-to-reverse decision in the project; a rewrite later costs months. Use the rubric in [mindset/decisions.md](../../../mindset/decisions.md) and pick one.

## Blocking Questions
1. Who will build and maintain it, and what do they already know? — Recommended: the stack your team already knows wins ties.
2. Platforms and must-have device features (widgets, watch, CarPlay, AR, Bluetooth, background audio, heavy camera)? — Recommended: iOS + Android phones, no special hardware.
3. Is there an existing app or web codebase to share with? — Recommended: none.

## Steps
1. **Collect the signals**: team skills, platforms, device features, performance bar, existing code, time to market, hiring market where the team is based.
2. **Knock out options** that fail a hard requirement (a device API with no maintained plugin; a team that can't staff it). Done when ≤ 3 options remain.
3. **Score the rest** on: time to first release, cost of two platforms over 3 years, access to platform APIs, hiring, performance, risk of the framework's own churn.
4. **Check the risky parts** for the leading option: is each must-have device feature supported by a maintained, first-party or widely used package? When unsure, recommend a 2–5 day spike on that feature before committing.
5. **Write the Decision Record.** Then point to the Stack Pack defaults (`references/stacks/<stack>/`) and [choose-architecture](../../engineering/choose-architecture/SKILL.md).

## Pitfalls to name
- Cross-platform shares code, not the release process: still two stores, two reviews, two sets of device bugs.
- "Web wrapper" apps risk App Store rejection for minimum functionality [S9] and feel off to End Users.
- Cross-platform still needs someone who can read native crash logs and platform build config.
- Framework versions move fast; budget upgrade time every year.

## Output
```
Pick: <stack>
Why: 1–3 reasons tied to this team and product
Alternatives: <stack> — better when …
Risks: … — spike: <feature>, <days>
Revisit if: …
```
For a Business Owner: cost and time implications in plain words, one line on hiring, no framework jargon beyond the stack name.

---
name: tech-debt-report
description: Survey a mobile codebase for technical debt and report it ranked by business impact, with the cost of leaving each item and the smallest fix. Use when asked "how healthy is this app?", before taking over a codebase, when planning a refactor, or when velocity has dropped.
---

# Tech Debt Report

Debt matters only where it costs something: crashes, slow delivery, store rejection risk, security, or an OS upgrade you can't take. Not taste ([AGENTS.md](../../../AGENTS.md) §3). Name each item's kind [S78]: deliberate or accidental, prudent or reckless.

## Steps
1. **Measure, don't guess.** Collect what exists: crash-free rate and top crashes, build time, test count and pass rate, app size, min OS and target SDK, dependency ages, lint warnings, open bugs. Missing data is itself a finding.
2. **Scan the hotspots**: files that change most often (git history) and are largest. Debt in code nobody touches is cheap.
3. **Check the forced-upgrade clock**: target SDK deadline on Google Play, required Xcode/SDK for App Store submission, deprecated APIs, abandoned or vulnerable libraries (verify current deadlines in store docs [S9][S10]).
4. **Check the lenses** from [code-review](../../engineering/code-review/SKILL.md) at codebase level: architecture, threading, lifecycle, security, accessibility, tests, release.
5. **Rank each item** by impact × likelihood, then by cost to fix. Done when every item has an owner-ready fix size (S/M/L) and a "cost of waiting".
6. **Propose a plan**: fix-now items (deadlines, security, crashes), fold-in items (fix while touching that code for features), and "leave it" items with the reason.

## Output
```
Health: one line + key numbers
Deadlines: item — date — consequence if missed
Ranked debt: item — impact on End Users/business — cost of waiting — fix (S/M/L)
Plan: now · with features · leave
Couldn't measure: …
```
For a Business Owner: lead with deadlines and risk in money and time terms; no code terms without an explanation.

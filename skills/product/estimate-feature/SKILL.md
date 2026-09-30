---
name: estimate-feature
description: Estimate a mobile feature or app as a range with assumptions and top risks, including the mobile-only costs people forget (two platforms, states, store review, device testing). Use when asked "how long will this take?", "how much will it cost?", or when sizing a backlog.
---

# Estimate Feature

An estimate is a range, the assumptions behind it, and the biggest risk. Never a single number [S17]. Say which it is: an estimate (what we think), a target (what the business wants), or a commitment (what we promise).

## Blocking Questions
1. Are designs and the API ready? — Recommended: assume not; include design-gap and contract time, and say so.
2. One platform or two, and who builds it (team size and seniority)? — Recommended: both platforms, one mid/senior mobile engineer per platform (or one for cross-platform).

## Steps
1. **Break into vertical slices** ([mindset/planning.md](../../../mindset/planning.md) §1). Done when every slice is ≤ ~5 days; split bigger ones.
2. **List screens and states** for each slice (§2). Unlisted states are where estimates go wrong.
3. **Estimate each slice** as best / likely / worst in days. Use similar past work in this codebase when it exists (git history, closed tickets).
4. **Add the mobile tax** as explicit lines, not hidden padding:
   - second platform (cross-platform: ~10–30% for platform-specific fixes; native: roughly a second build)
   - loading/empty/error/offline states, accessibility, localization
   - device and OS testing, dark mode, large text
   - analytics, flags, crash monitoring
   - store submission and review (1–3 days calendar; first submission longer), release notes, screenshots
   - backend and design dependencies the team waits on
5. **Name the top 3 risks** and what each adds if it hits. Unknown platform API → recommend a time-boxed spike first.
6. **Sum to a range.** Report calendar time separately from effort; reviews, waiting and meetings live in calendar time.

## Output
```
Estimate: <low>–<high> <person-days|weeks> effort, <low>–<high> weeks calendar
Slices: name — best/likely/worst
Mobile tax: …
Assumptions: …
Biggest risk: … (+N days if it hits) — spike first? yes/no
```
For a Business Owner: range, what makes it land at the low or high end, and what they can cut to go faster ([mvp-scope](../mvp-scope/SKILL.md)).

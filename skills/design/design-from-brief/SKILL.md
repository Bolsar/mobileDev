---
name: design-from-brief
description: Turn a written brief or idea into flows, a screen inventory and wireframe-level screen specs before building, when no designs exist. Use when the Requester says "design the app/screen", "there's no designer" or describes a feature without mockups.
---

# Design From Brief

No designer, no mockups: the agent designs structure, not art. Output is flows and screen specs that are cheap to change, then UI built under [ui-anti-slop](../ui-anti-slop/SKILL.md). If a Figma MCP tool is available and the Requester wants Figma, draw the wireframes there; it is never required.

## Blocking Questions
1. The one job the End User comes to do? — Recommended: pick the most frequent task and make it reachable in ≤ 2 taps from launch.
2. Brand assets (logo, colors, font)? — Recommended: none yet → platform defaults + one accent color, restyle later through tokens.
3. Platforms? — Recommended: both, sharing brand, native navigation per platform.

## Steps
1. **Jobs and users.** Write the top 3 End User jobs in one line each. Done when every planned screen serves one of them; cut screens that don't.
2. **Flows.** For each job, the step list from entry (launch, push, deep link) to done, including the unhappy path (no network, denied permission, validation error). Include first run: what the End User sees before signing in.
3. **Navigation model.** Tabs/navigation bar for 3–5 top-level destinations, stack for drill-down, sheets for short focused tasks [S5][S6]. Done when every screen has a parent.
4. **Screen inventory.** Per screen: purpose, primary action, content, entry points, states ([mindset/planning.md](../../../mindset/planning.md) §2).
5. **Wireframe specs.** Per screen, a top-to-bottom list of regions with the platform component used (`List`, `LazyColumn`, `TextField`, bottom sheet…) and real copy. ASCII sketch if layout is non-obvious. No colors or pixel sizes yet.
6. **Review with the Requester** before code: flows and inventory, not visuals. Done when they have confirmed the primary action of each screen.
7. **Build** with tokens ([design-system-setup](../design-system-setup/SKILL.md)) and platform components, then run [design-critique](../design-critique/SKILL.md) on the result.

## Output
```
Jobs: 1. … 2. … 3. …
Navigation: tabs [...], stacks [...]
Flow <job>: step → step → done (unhappy: …)
Screen <name>: purpose · primary action · regions [...] · states [...]
Assumptions: …
```
For a Business Owner, add what they must decide now (primary job, brand) versus later (visual polish).

---
name: write-pr
description: Write a pull request title and description for a mobile change, with per-platform evidence, test notes, risk and rollout. Use when asked to open or describe a PR, or after finishing a build.
---

# Write PR

A reviewer should understand what changed, why, and how risky it is without opening the diff. Match the project's PR template and commit style if one exists; this skill fills the gaps.

## Steps
1. **Read the whole diff** and the linked ticket. Done when you can state the change in one sentence.
2. **Check scope.** Unrelated changes (formatting, drive-by refactors) → suggest splitting them out. Rule of thumb: propose a split above ~400 changed lines; review quality drops past that.
3. **Collect evidence**: screenshots or a short video per platform and per changed state (loading, empty, error, dark mode, large text) for UI changes. Can't capture them → list exactly what the reviewer should capture.
4. **Write the description** using the format below [S75]. Done when every section is filled or says "none".
5. **Title**: Conventional Commits style [S28] (`feat(checkout): add Apple Pay`), imperative, under ~70 characters.

## Output
```
<type>(<scope>): <what>

## What
One or two sentences.
## Why
Problem or ticket link.
## How
Only what the diff doesn't make obvious: the approach and the alternatives rejected.
## Screenshots
| | iOS | Android |  (before/after, states)
## Testing
Automated tests added. Manual: devices, OS versions, offline, dark mode, large text.
## Risk & rollout
What could break, for whom. Feature flag? Migration? Backend dependency and deploy order? New permission, SDK or privacy manifest / data-safety change?
```
No "this PR" filler, no restating the diff file by file.

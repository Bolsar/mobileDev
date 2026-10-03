---
name: code-review
description: Review mobile code or a PR for bugs that hurt on real devices (lifecycle, threading, missing states, migrations, security, accessibility). Use when asked to review a diff, PR, branch or file.
---

# Code Review

Flag real problems: crashes, data loss, security, broken old versions, blocked End Users. Skip taste; the project's conventions win ([AGENTS.md](../../../AGENTS.md) §3).

## Steps
1. **Read the intent.** PR description, ticket, or ask. Done when you can say in one line what the change is supposed to do.
2. **Read every changed file fully**, plus the callers of any changed function. A diff hunk alone hides broken callers.
3. **Apply every lens below** to the change. Done when each lens is either clean or has findings.
4. **Rank** findings by severity and write them up.

## Lenses
- **Correctness**: does it do what the intent says? Edge cases: empty, huge, null, concurrent taps, back pressed mid-request.
- **Design**: domain code importing UI frameworks; mutable singletons or a global container passed into features; one-method interfaces that exist only for mocking; booleans that allow contradictory states ([references/core/architecture.md](../../../references/core/architecture.md)).
- **Threading**: UI touched off main; I/O or heavy work on main; work not cancelled when the screen goes away.
- **Lifecycle**: leaks (listeners, closures capturing screens), state lost on rotation or process death.
- **States**: loading, empty, error, offline all handled.
- **Old versions**: API change backward-compatible? DB/preferences migration present and tested? Persisted format changed?
- **Security**: secrets, tokens in logs or plain storage, unvalidated deep link input, new exported components ([references/core/security.md](../../../references/core/security.md)).
- **Accessibility**: labels, target size, dynamic type ([references/core/accessibility.md](../../../references/core/accessibility.md)).
- **Localization**: hardcoded strings, concatenated sentences, locale-unaware formatting.
- **Performance**: work in list item builders, unbounded images, extra re-renders.
- **Release**: needs a flag? New permission or SDK (privacy manifest, data safety form)?
- **Agent safety**: workaround comments that justify a band-aid; a second way of doing something the project already has a paved path for; a new screen missing from `.maestro/feature-map.md` or without test IDs. A repeated finding → propose a lint rule, not just a comment ([mindset/verification.md](../../../mindset/verification.md)).
- **Proof**: does the PR show it works (test output, screenshot, `verify` summary)? Claims without artifacts are unverified.
- **Tests**: new logic covered through real code, with mocks only at the system edge? Regression test for a bug fix?

## Output
```
Summary: <one line: ship / ship after fixes / needs rework>
path:line — blocker|major|minor — problem — fix
```
Blockers first. No praise padding, no style nits unless they change meaning.

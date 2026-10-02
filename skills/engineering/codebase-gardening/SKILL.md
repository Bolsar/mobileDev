---
name: codebase-gardening
description: Find and remove patterns agents would copy badly (workarounds, shims, duplicate ways of doing one thing, dead flags) and add lint rules so they stop spreading. Use on a regular schedule, after a heavy agent-driven sprint, or when the same bad pattern shows up in several new PRs.
---

# Codebase Gardening

One workaround copied by agents becomes the pattern within weeks [S155]. The gardener deletes it, or at least stops it from spreading. This skill acts on the code; for a ranked report to a Business Owner, use [tech-debt-report](../../product/tech-debt-report/SKILL.md).

## Steps
1. **Scan for weeds.** Each one with a count and its paths:
   - Workaround comments: `git grep -nEi 'hack|workaround|temporary|fixme|todo'`, minus TODOs that link a ticket.
   - Two or more ways to do one thing: HTTP clients, date formatters, state holders, navigation calls, error types.
   - Shims for OS versions below the current minimum (`#available`, `Build.VERSION.SDK_INT`, `Platform.Version`) that are now always true.
   - Feature flags fully rolled out or fully off for more than one release ([feature-flags-experiments](../../product/feature-flags-experiments/SKILL.md)).
   - Dead code: unused files, exports and resources (the stack's lint or an unused-code tool).
   - Lint baselines and suppressions that grew since the last pass.
2. **Rank by spread, not size.** Is it growing? `git log -S '<pattern>' --since=1.month` shows how many recent commits added it. A pattern added last week by three PRs beats an old one in one file.
3. **For each weed, pick one:**
   - **Delete**: dead code, finished flags, impossible shims. Do it now.
   - **Converge**: migrate to the paved path. If it's big, migrate the hottest files and leave a ticket for the rest.
   - **Fence**: add a lint rule or CI check that fails on new uses ([agent-ready-codebase](../agent-ready-codebase/SKILL.md) has per-stack recipes) and baseline the existing ones. Use this when cleanup must wait.
4. **Verify.** Each change goes through `harness/verify`; deleting code needs the same proof as adding it ([mindset/verification.md](../../../mindset/verification.md)).
5. **Keep PRs small.** One weed per PR, so a revert is cheap.

## Output
```
Weed — count — trend (new uses last month) — action: delete|converge|fence — PR/ticket
Lint rules added: …
Baseline: <before> → <after>
```

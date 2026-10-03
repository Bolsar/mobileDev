# 0002 — Ship a verify harness script

Status: accepted (2026-10-02). Amends [0001](0001-markdown-only-agentic-tools.md). Amended by [0003](0003-split-stack-packs.md): `verify` now lives in each Stack Pack repo.

## Context
An agent is trusted when it proves its work with artifacts, not when it says "done" [S155]. Proof scripts written fresh by the agent in each session drift and differ. One maintained tool gives the same proof every time.

## Decision
Ship `harness/verify`: one POSIX shell script. It detects the stack, runs lint and tests, optionally runs a Maestro flow, and saves logs, a screenshot and a summary to `.mobile-agent-proof/<timestamp>/`. Ship `harness/feature-map.template.md` as the format for the app's Feature Map. Everything else stays markdown.

## Consequences
- The harness is optional. If it can't run (Windows, missing SDK, no simulator), the agent falls back to the stack commands in `references/stacks/<stack>/tooling.md` and says what is unverified.
- We now maintain code: `sh harness/test.sh` checks stack detection. Run it and `shellcheck` on every change.
- The harness needs local tools (Xcode, Android SDK, Flutter, Node, Maestro). It does not install them.

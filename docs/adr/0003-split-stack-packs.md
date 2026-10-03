# 0003 — Split Stack Packs into their own repos

Status: accepted (2026-10-03). Amends [0002](0002-verify-harness-scripts.md).

## Context
One repo held the shared mindset and skills, four Stack Packs, the verify harness and every eval. Each change touched too much, and the agent carried all four stacks when a project only uses one.

## Decision
- This repo (`mobile-dev`) keeps only stack-agnostic knowledge: AGENTS.md, mindset, skills, `references/core/`, sources.
- Each stack gets its own repo and plugin: `mobile-dev-ios`, `mobile-dev-android`, `mobile-dev-flutter`, `mobile-dev-react-native`. Each holds `defaults.md`, `idioms.md`, `tooling.md`, its stack's `sources.md` and its own `verify` script. Each requires `mobile-dev`.
- `harness/verify` is split: each Stack Pack's `verify` runs only that stack's lint and tests, plus the Maestro flow and device capture. Stack detection moves into `hooks/session-start.sh` (tested by `hooks/test.sh`).
- The `bolsar` marketplace in this repo lists all five plugins.
- Evals trimmed to one smoke file.

## Consequences
- A stack can change and ship without touching this repo, and the reverse.
- The verify skeleton is duplicated four times on purpose; repos ship independently. Fix a skeleton bug in all four.
- Copied installs (non-Claude tools) clone the Stack Pack into `.mobile-agent/stacks/<stack>/`.

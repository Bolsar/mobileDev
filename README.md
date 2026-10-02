# Mobile Developer Agent

An AI agent that works and thinks like a senior mobile engineer, for iOS, Android, Flutter and React Native.

- **Business owners** get stack choice, MVP scope and cost estimates in plain language.
- **Web and backend developers** get mobile concepts mapped to what they already know.
- **Mobile developers** get a peer that reviews, debugs, plans and ships.

It is plain markdown, so it works in any coding agent.

## Install

Pick your tool:
[Claude Code](#claude-code) · [Codex](#codex) · [Cursor](#cursor) · [Gemini CLI](#gemini-cli) · [Antigravity](#antigravity) · [GitHub Copilot](#github-copilot) · [Other tools](#other-tools)

Every tool except the Claude Code plugin starts by copying the agent into your app project. Commit the copy so your team gets it too:
```sh
git clone https://github.com/Bolsar/mobileDev .mobile-agent
rm -rf .mobile-agent/.git
```

### Claude Code
```sh
claude plugin marketplace add Bolsar/mobileDev
claude plugin install mobile-dev@bolsar
```
No copy needed. Restart Claude Code after installing. In a Flutter, React Native, iOS or Android project, the agent turns on by itself when a session starts. Anywhere else, ask for it by name: `/mobile-dev:mobile-dev`.

### Codex
After the copy, add this line to `AGENTS.md` in your project root:
```
Read .mobile-agent/AGENTS.md and follow it for all mobile work.
```

### Cursor
After the copy, add this line to `AGENTS.md` in your project root:
```
Read .mobile-agent/AGENTS.md and follow it for all mobile work.
```
Or create `.cursor/rules/mobile-agent.mdc`:
```md
---
description: Senior mobile engineer agent for all mobile app work
alwaysApply: true
---
Read .mobile-agent/AGENTS.md and follow it for all mobile work.
```

### Gemini CLI
After the copy, add this line to `GEMINI.md` in your project root:
```
Read .mobile-agent/AGENTS.md and follow it for all mobile work.
```
Run `/memory show` to check it loaded.

### Antigravity
Works for the IDE and the `agy` CLI. After the copy, add this line to `AGENTS.md` in your project root:
```
Read .mobile-agent/AGENTS.md and follow it for all mobile work.
```
Or create `.agents/rules/mobile-agent.md`:
```md
---
trigger: always_on
---
Read .mobile-agent/AGENTS.md and follow it for all mobile work.
```

### GitHub Copilot
For the Copilot coding agent. After the copy, add this line to `AGENTS.md` in your project root, then push:
```
Read .mobile-agent/AGENTS.md and follow it for all mobile work.
```
Copilot runs on Linux or Windows, so it can't run the iOS simulator. To let it run your tests, install your toolchain in `.github/workflows/copilot-setup-steps.yml`.

### Other tools
After the copy, add the same line to whichever instructions file your tool reads.

## Use it
Ask for what you need:
- "Plan an MVP for a food delivery app"
- "Review this PR"
- "Why does the app crash on Samsung only?"

## What's inside
| Path | What |
|---|---|
| `AGENTS.md` | Entry point: who the agent is, how it works, skill index |
| `mindset/` | How a mobile engineer thinks |
| `skills/` | Step-by-step skills: engineering, design, collaboration, product, release |
| `references/` | Cited knowledge, plus a pack per stack |
| `harness/` | `verify` script that runs lint and tests and saves proof |
| `evals/` | Test scenarios for the agent itself |

Vocabulary: [CONTEXT.md](CONTEXT.md). Decisions: [docs/adr](docs/adr).

## License
MIT

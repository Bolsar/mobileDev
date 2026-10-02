# Mobile Developer Agent

An AI-agnostic agent that works and thinks like a senior mobile engineer. It is pure markdown and works with any agentic coding tool that can read files: Claude Code, Codex, Cursor, Gemini CLI, Copilot agent.

It is built for anyone who needs to build a mobile app:
- **Business owners**: stack choice, MVP scope, estimates and costs, in plain language.
- **Frontend and backend developers**: mobile concepts mapped to what you already know, plus working code.
- **Mobile developers**: a peer that reviews, debugs, plans and ships.

It covers iOS (Swift/SwiftUI), Android (Kotlin/Compose), Flutter and React Native.

## Install

1. Copy this repo into your app project, and commit it so teammates and cloud agents get it too:
   ```sh
   git clone https://github.com/Bolsar/mobileDev .mobile-agent
   rm -rf .mobile-agent/.git
   ```
2. Point your tool at it with this line, in the file your tool reads (see [per tool](#per-tool) below):
   ```
   Read .mobile-agent/AGENTS.md and follow it for all mobile work.
   ```
3. Ask for what you need: "Plan an MVP for a food delivery app", "Review this PR", "Why does the app crash on Samsung only?"

### Per tool
Tools change how they load instructions. These steps were checked against each tool's docs in October 2026.

**Claude Code**: install the plugin, with no copy needed:
```sh
claude plugin marketplace add Bolsar/mobileDev
claude plugin install mobile-dev@bolsar
```
The `mobile-dev` skill loads `AGENTS.md`. Or use the copy install and put the line in `CLAUDE.md`.

**Codex** (CLI, IDE, cloud): put the line in `AGENTS.md` at the repo root. Codex merges `AGENTS.md` files from the git root down to the working folder, so it won't find `.mobile-agent/AGENTS.md` without the pointer. [Docs](https://developers.openai.com/codex/guides/agents-md)

**Cursor**: put the line in `AGENTS.md` at the repo root, or add a project rule `.cursor/rules/mobile-agent.mdc`:
```md
---
description: Senior mobile engineer agent for all mobile app work
alwaysApply: true
---
Read .mobile-agent/AGENTS.md and follow it for all mobile work.
```
[Docs](https://cursor.com/docs/context/rules)

**Gemini CLI**: it reads `GEMINI.md` by default. Put the line in `GEMINI.md` at the repo root, or make Gemini read `AGENTS.md` too with `.gemini/settings.json`:
```json
{ "context": { "fileName": ["AGENTS.md", "GEMINI.md"] } }
```
Check what was loaded with `/memory show`. [Docs](https://geminicli.com/docs/reference/configuration)

**GitHub Copilot coding agent**: put the line in `AGENTS.md` at the repo root (Copilot uses the nearest `AGENTS.md`) or in `.github/copilot-instructions.md`. The agent works from the GitHub repo, so `.mobile-agent/` must be committed. It runs on Linux or Windows only, so there's no iOS simulator: expect lint and test proof. Install your stack's toolchain (Flutter, Node, JDK) in `.github/workflows/copilot-setup-steps.yml`, in a job named `copilot-setup-steps`. [Docs](https://docs.github.com/en/copilot/how-tos/configure-custom-instructions/add-repository-instructions)

**Other tools**: put the line in whichever instructions file the tool reads. Anything that can read files and run shell commands works.

## What's inside
| Path | What |
|---|---|
| `AGENTS.md` | Entry point: persona, Requester adaptation, Mobile Mindset core, skill index |
| `mindset/` | How a mobile engineer reasons: constraints, questioning, decisions, planning, debugging, verification |
| `.claude-plugin/` | Claude Code plugin and marketplace manifests |
| `harness/` | `verify` script: lint, tests, Maestro flow, screenshot and logs as proof; Feature Map template |
| `skills/` | Skills in 5 groups: engineering, design, collaboration, product, release |
| `references/` | Condensed, cited knowledge. Core plus Stack Packs per stack |
| `evals/` | Scenarios for checking that the agent behaves like a real mobile dev |

See [CONTEXT.md](CONTEXT.md) for vocabulary and [docs/adr](docs/adr) for decisions.

## License
MIT

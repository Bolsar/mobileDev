# Mobile Developer Agent

An AI-agnostic agent that works and thinks like a senior mobile engineer. It is pure markdown and works with any agentic coding tool that can read files: Claude Code, Codex, Cursor, Gemini CLI, Copilot agent.

It is built for anyone who needs to build a mobile app:
- **Business owners**: stack choice, MVP scope, estimates and costs, in plain language.
- **Frontend and backend developers**: mobile concepts mapped to what you already know, plus working code.
- **Mobile developers**: a peer that reviews, debugs, plans and ships.

It covers iOS (Swift/SwiftUI), Android (Kotlin/Compose), Flutter and React Native.

## Install

1. Copy this repo into your app project:
   ```sh
   git clone https://github.com/Bolsar/mobileDev .mobile-agent
   rm -rf .mobile-agent/.git
   ```
2. Add one line to your project's `AGENTS.md` (or `CLAUDE.md`, `.cursorrules`, `GEMINI.md`, or whichever file your tool reads):
   ```
   Read .mobile-agent/AGENTS.md and follow it for all mobile work.
   ```
3. Ask for what you need: "Plan an MVP for a food delivery app", "Review this PR", "Why does the app crash on Samsung only?"

## What's inside
| Path | What |
|---|---|
| `AGENTS.md` | Entry point: persona, Requester adaptation, Mobile Mindset core, skill index |
| `mindset/` | How a mobile engineer reasons: constraints, questioning, decisions, planning, debugging |
| `harness/` | `verify` script: lint, tests, Maestro flow, screenshot and logs as proof; Feature Map template |
| `skills/` | Skills in 5 groups: engineering, design, collaboration, product, release |
| `references/` | Condensed, cited knowledge. Core plus Stack Packs per stack |
| `evals/` | Scenarios for checking that the agent behaves like a real mobile dev |

See [CONTEXT.md](CONTEXT.md) for vocabulary and [docs/adr](docs/adr) for decisions.

## License
MIT

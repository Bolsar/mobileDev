# Mobile Developer Agent

An AI agent that works and thinks like a senior mobile engineer, for iOS, Android, Flutter and React Native.

- **Business owners** get stack choice, MVP scope and cost estimates in plain language.
- **Web and backend developers** get mobile concepts mapped to what they already know.
- **Mobile developers** get a peer that reviews, debugs, plans and ships.

You say what you want. It plans and waits for your OK, then builds, verifies, opens a PR, reviews it and merges. Risky changes (migrations, permissions, signing, agent config) pause for your "merge". Every change and the review are in the PR if you want to look.

It is plain markdown, so it works in any coding agent: a plugin for Claude Code, Copilot CLI, Codex, Gemini CLI and Cursor, or a folder you copy into your project for everything else.

This repo is the shared core. Add the Stack Pack for your app's stack next to it:

| Stack | Repo |
|---|---|
| iOS (Swift) | [mobile-dev-ios](https://github.com/Bolsar/mobile-dev-ios) |
| Android (Kotlin) | [mobile-dev-android](https://github.com/Bolsar/mobile-dev-android) |
| Flutter | [mobile-dev-flutter](https://github.com/Bolsar/mobile-dev-flutter) |
| React Native | [mobile-dev-react-native](https://github.com/Bolsar/mobile-dev-react-native) |

Each Stack Pack holds that stack's defaults, idioms, tooling and a `verify` script. It needs this repo.

## Install

Pick your tool:
[Claude Code](#claude-code) · [GitHub Copilot CLI](#github-copilot-cli) · [Codex](#codex) · [Gemini CLI](#gemini-cli) · [Cursor](#cursor) · [Antigravity, Copilot coding agent and others](#copy-into-your-project)

Each command set installs the agent once, for every project on your machine. Replace `<stack>` with `ios`, `android`, `flutter` or `react-native`.

### Claude Code
```sh
claude plugin marketplace add Bolsar/mobileDev
claude plugin install mobile-dev@bolsar
claude plugin install mobile-dev-<stack>@bolsar
```
Restart Claude Code after installing. In a Flutter, React Native, iOS or Android project, the agent turns on by itself when a session starts. Anywhere else, ask for it by name: `/mobile-dev:mobile-dev`.

To let it ship without a prompt at every step, use auto mode, or allow `git` and `gh pr` commands and deny the dangerous ones in `.claude/settings.json`:
```json
"permissions": {
  "allow": ["Bash(git *)", "Bash(gh pr *)"],
  "deny": ["Bash(git push * main*)", "Bash(git push *:main*)", "Bash(git push *+main*)", "Bash(git push --force*)", "Bash(git push -f*)", "Bash(*--no-verify*)", "Bash(gh pr merge *--admin*)", "Bash(gh pr merge *--auto*)"]
}
```
The deny list is a backstop only: it can't catch a bare `git push` while on `main`. Turn on GitHub branch protection for `main` as the real guard.

Guarded steps, such as committing agent config, come back to you as `!` commands to run.

### GitHub Copilot CLI
```sh
copilot plugin marketplace add Bolsar/mobileDev
copilot plugin install mobile-dev@bolsar
copilot plugin install mobile-dev-<stack>@bolsar
```

### Codex
```sh
codex plugin marketplace add Bolsar/mobileDev
```
Then open `/plugins` in Codex and install `mobile-dev` and `mobile-dev-<stack>` from the `bolsar` marketplace.

### Gemini CLI
```sh
gemini extensions install https://github.com/Bolsar/mobileDev
gemini extensions install https://github.com/Bolsar/mobile-dev-<stack>
```
Run `/extensions list` to check both loaded.

### Cursor
Open **Settings → Plugins → Install from Repository** and add both:
```
https://github.com/Bolsar/mobileDev
https://github.com/Bolsar/mobile-dev-<stack>
```

Outside Claude Code there is no session hook, so the agent doesn't turn on by itself. Ask for it: "use mobile-dev", or just ask for mobile work and the `mobile-dev` skill picks it up.

### Copy into your project
For Antigravity, the Copilot coding agent, and any other tool. It also pins the agent per project so your whole team gets it from git. Copy the agent into your app project and commit the copy:
```sh
git clone https://github.com/Bolsar/mobileDev .mobile-agent
git clone https://github.com/Bolsar/mobile-dev-<stack> .mobile-agent/stacks/<stack>
rm -rf .mobile-agent/.git .mobile-agent/stacks/*/.git
```
Then add this line to the instructions file your tool reads (`AGENTS.md` for Codex, Cursor, Antigravity and Copilot; `GEMINI.md` for Gemini CLI):
```
Read .mobile-agent/AGENTS.md and follow it for all mobile work.
```
The Copilot coding agent runs on Linux or Windows, so it can't run the iOS simulator. To let it run your tests, install your toolchain in `.github/workflows/copilot-setup-steps.yml`.

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
| `references/` | Cited, stack-agnostic knowledge |
| `hooks/` | Claude Code session hook: detects the stack and turns the agent on |
| `.claude-plugin/`, `.codex-plugin/`, `.cursor-plugin/`, `.agents/plugins/`, `gemini-extension.json`, `GEMINI.md` | Plugin manifests per tool |
| `evals/` | Smoke scenarios for the agent itself |

Vocabulary: [CONTEXT.md](CONTEXT.md). Decisions: [docs/adr](docs/adr).

## License
MIT

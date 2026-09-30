# 0001 — Markdown only, for agentic tools

Status: accepted (2026-09-30)

## Context
The agent must work with any AI, not just one vendor. The options were: a runnable program with an LLM provider abstraction, an MCP server, or plain markdown.

## Decision
The agent is plain markdown, with no runtime code and no per-tool adapter files. The entry point is `AGENTS.md`. Skills follow the open Agent Skills `SKILL.md` format. We target only agentic tools that can read files (Claude Code, Codex, Cursor, Gemini CLI, Copilot agent). Plain chat UIs are not supported.

## Consequences
- Any agentic tool works with zero install. The Requester copies the repo in as `.mobile-agent/`.
- We cannot run code, enforce behavior or call APIs. Quality depends on prompt quality and on the host LLM, so evals are run by hand.
- A chat-UI bundle can be added later without changing this repo's structure.

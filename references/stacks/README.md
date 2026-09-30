# Stack Packs

One folder per stack: `ios/`, `android/`, `flutter/`, `react-native/`. Each has the same three files:

| File | Holds | Read it when |
|---|---|---|
| `defaults.md` | Greenfield picks (one per concern), project layout, how dependencies and state are wired | Starting a project or feature with no existing convention |
| `idioms.md` | Concurrency, lifecycle, UI idioms, the stack's classic bugs, how to read an existing project | Writing or reviewing code in that stack |
| `tooling.md` | Toolchain, lint, test, profiling, build and release commands, the "done" check | Setting up, verifying, or shipping |

Rules:
- **Existing project wins.** A pick in `defaults.md` is for greenfield only. If the project already uses another library for the same job, keep it and flag only real problems (see AGENTS.md §3).
- **Versions move.** Library names here are stable picks, not pinned versions. Check the current docs and the project's lockfile before adding or upgrading anything, and check the min OS before using a newer API.
- Stack-agnostic rules live in `references/core/`. A Stack Pack only says how they look in that stack.

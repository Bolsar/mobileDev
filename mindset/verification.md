# Verification

The Requester trusts what you can show, not what you say [S155]. "Done" means proof is attached.

## Proof first
1. **Before building, write down the proof.** One line per acceptance point: which test, which screen state, which value or log line will show it works.
2. **Collect it.** Run the Stack Pack's `verify` from the app root (add `--flow .maestro/<flow>.yaml` for UI work). It saves logs, a screenshot and a summary to `.mobile-agent-proof/`. If it can't run, use the commands in the Stack Pack's `tooling.md`.
3. **Report it.** Quote the decisive lines (test count, `RESULT PASS`, the log line), give the proof folder path, and say what each item proves.

Proof ranked, strongest first:
1. The change exercised on a running simulator, emulator or device: screenshot plus log.
2. A test that fails without the change and passes with it.
3. Lint, type check and the full test suite pass.
4. "It compiles". This is not proof of behavior.

Never:
- Claim a test passes or a build works without running it.
- Paraphrase tool output. Quote it.
- Hide a failing or skipped step. Say "unverified: <what> — check by <exact steps>".

## When you're corrected: climb the trust ladder
A correction, or the same mistake twice, means a class of bug, not one instance. Fix the instance, then add a guard at the highest layer that works:

1. **Code structure** makes the mistake impossible: a type that can't hold the bad state, a module boundary, a sealed set of screen states, one paved path for networking, state and navigation.
2. **Static checks**: a lint rule, a compiler flag or a CI check. A lint rule stops the bleeding even before the old code is cleaned up.
3. **Written guidance**: a project rule, a skill, or an instruction to the AI review bot. It can be skipped, so it ranks below enforcement.
4. **Human review and style guide**: the last resort. It doesn't scale.

Propose the guard in the same change, or in a ticket if it's bigger. Stack recipes: [agent-ready-codebase](../skills/engineering/agent-ready-codebase/SKILL.md).

## The codebase is memory
Agents, you included, extend whatever pattern is in context. One workaround gets copied until it is the pattern.
- Before copying a pattern, check it's the project's paved path and not a workaround.
- Don't write comments that justify a band-aid ("temporary fix", "workaround for…"). Fix the root cause, or leave a ticket link and say so in your report.
- Leave code you'd be happy to see copied ten times.

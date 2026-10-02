---
name: ship-change
description: Commit, push, open a PR, review it and merge it the safe way, one branch and one PR per change, never pushing or force-pushing to main. Use when asked to commit, push, open a PR, review, merge, or "ship it", and at the end of every build in the delivery loop.
---

# Ship Change

Every change goes branch → commit → PR → review → merge. Nothing lands on `main` except through a merged PR. Every step is visible in the PR, so the Requester can inspect it whenever they want.

## Rules
- **Never** commit on `main`, push to `main`, or use `--force` / `--force-with-lease` on `main`. On a feature branch, force-push only with `--force-with-lease` and only after saying why.
- **Never** skip hooks or signing (`--no-verify`, `--no-gpg-sign`) or rewrite published history unless the Requester asks for it.
- **One change per branch.** Unrelated edits in the working tree stay out; stage files by name, never `git add -A` blindly.
- **Never commit secrets**: `.env`, keystores, `.p8`/`.p12`, `google-services.json` with live keys, `local.properties`. A secret staged or in a commit → stop and say so. An unrelated secret file in the tree → leave it unstaged and say so.
- **Never bypass protection**: no `gh pr merge --admin`, no `--auto`. Branch protection blocks the merge → pause and report.
- **Approval**: an approved plan, or an explicit "ship it" / "merge it" for this change, covers the merge, unless the change is risky (below) or drifted from what was approved. No such approval → pause for "merge". Approval of one PR doesn't cover the next.

## Steps
1. **Look first.** `git status`, `git diff`, `git branch --show-current`, `git log --oneline -5`. Done when you can say in one sentence what will be committed and nothing unexpected is in the tree.
2. **Branch.** `git fetch origin`, then `git switch -c <type>/<short-slug> origin/main` (`feat/`, `fix/`, `docs/`, `chore/`); uncommitted changes carry over. Already on a branch for this change → stay. On an unrelated branch → stash first, branch from `origin/main`, then `git stash pop`.
3. **Commit.** `git add <files>` then commit in the repo's style, else Conventional Commits [S28] (`fix(cart): show empty state offline`). Run the project's checks (`harness/verify` or the stack's lint and tests) before committing. Done when `git status` is clean for the files in scope.
4. **Push.** `git push -u origin <branch>`. Never `origin main`. No remote or no `gh` → stop here and report the branch and commit.
5. **Open the PR.** `gh pr create --base main --title "<commit title>" --body-file <file>`, body from [write-pr](../write-pr/SKILL.md). Report the PR URL.
6. **Wait for checks.** `gh pr checks <n> --watch`. "no checks reported" counts as green only if the repo has no CI config (for example, `.github/workflows/` is empty or missing). With CI config, runs may not be registered yet: retry for a few minutes before treating it as missing, and then pause. Red → fix on the same branch, push again; don't merge around it.
7. **Self-review.** Run [code-review](../../engineering/code-review/SKILL.md) on `gh pr diff <n>`. If your tool has subagents (Claude Code's Agent tool), run the review in a fresh-context subagent so the reviewer isn't the author; otherwise review in place. Ask the reviewer to also name any risky category (below) it sees. Post the result with `gh pr comment <n> --body-file <file>`. Blocker or major findings → fix on the branch, re-verify, push, rerun step 6, review again. Only the reviewer's re-run clears a finding; never reclassify one yourself. Still not clean after 2 rounds → pause and ask.
8. **Merge when every gate passes:**
   - verify or tests passed in this session on the PR's head commit, with output quoted. Anything marked unverified, or no runnable tests → pause
   - CI green, or the repo has none
   - review has no blocker or major findings
   - the change isn't risky (below)

   Then `gh pr merge <n> --squash --delete-branch --match-head-commit <reviewed sha>` (or the repo's merge style), and `git switch main && git pull --ff-only`. Done when `main` contains the change and the branch is gone.

## Risky: pause before merge
Classify from `gh pr diff <n> --name-only` plus the content. If you or the reviewer flag any item, stop after step 7, say which item applies, and wait for the Requester's "merge":
- DB, preferences or persisted-format migrations
- New permission, SDK or tracking (privacy manifest, data safety form)
- Secrets, signing, CI/CD config
- Backend or API contract changes
- Store release, versioning or force-update config
- Anything that deletes End User data
- Agent config: `.claude/`, `.mobile-agent/`, `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.cursor/`, `.codex/`, `.github/copilot-instructions.md`, plugin, hook or skill files

## When a step is blocked
A permission prompt, auto mode or a hook may block a command, for example committing `.claude/settings.json`, because an agent changing its own config is guarded on purpose. Don't retry it another way and don't work around the guard. Stop, say which step was blocked and why, and hand the Requester the exact remaining commands to run themselves with the `!` prefix:

```
! git switch -c chore/enable-plugin
! git add .claude/settings.json
! git commit -m "chore: enable mobile-dev plugin"
! git push -u origin chore/enable-plugin
! gh pr create --base main --fill
```

Then continue from the next step once they've run it.

## Output
Branch, commit hash and title, PR URL, check status, review verdict, and merged or paused with the reason. Anything skipped or blocked is said plainly, never implied done.

---
name: ship-change
description: Commit, push, open a PR and merge it the safe way, one branch and one PR per change, never pushing or force-pushing to main. Use when asked to commit, push, open a PR, merge, or "ship it".
---

# Ship Change

Every change goes branch → commit → PR → merge. The Requester sees each step and can stop it. Nothing lands on `main` except through a merged PR.

## Rules
- **Never** commit on `main`, push to `main`, or use `--force` / `--force-with-lease` on `main`. On a feature branch, force-push only with `--force-with-lease` and only after saying why.
- **Never** skip hooks or signing (`--no-verify`, `--no-gpg-sign`) or rewrite published history unless the Requester asks for it.
- **One change per branch.** Unrelated edits in the working tree stay out; stage files by name, never `git add -A` blindly.
- **Never commit secrets**: `.env`, keystores, `.p8`/`.p12`, `google-services.json` with live keys, `local.properties`. See them in the diff → stop and say so.
- **Merge needs a green light**: checks pass (or the repo has none) and the Requester said to merge, in this conversation, for this PR. Approval of one PR doesn't cover the next.

## Steps
1. **Look first.** `git status`, `git diff`, `git branch --show-current`, `git log --oneline -5`. Done when you can say in one sentence what will be committed and nothing unexpected is in the tree.
2. **Branch.** On `main` → `git switch -c <type>/<short-slug>` (`feat/`, `fix/`, `docs/`, `chore/`). Already on a branch for this change → stay.
3. **Commit.** `git add <files>` then commit in the repo's style, else Conventional Commits [S28] (`fix(cart): show empty state offline`). Run the project's checks (`harness/verify` or the stack's lint and tests) before committing. Done when `git status` is clean for the files in scope.
4. **Push.** `git push -u origin <branch>`. Never `origin main`.
5. **Open the PR.** `gh pr create --base main --title "<commit title>" --body-file <file>`, body from [write-pr](../write-pr/SKILL.md). Report the PR URL.
6. **Wait for checks.** `gh pr checks <n> --watch`. Red → fix on the same branch, push again; don't merge around it.
7. **Merge only when told.** `gh pr merge <n> --squash --delete-branch` (or the repo's merge style), then `git switch main && git pull --ff-only`. Done when `main` contains the change and the branch is gone.

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
After each run: branch, commit hash and title, PR URL, check status, and merged or waiting. Anything skipped or blocked is said plainly, never implied done.

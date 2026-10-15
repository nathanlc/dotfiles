---
name: jira-release-cherry-pick
description: >-
  Cherry-pick a merged Jira ticket's commit from main onto its release branch
  and open a draft PR. Use when the user says "cherry-pick ATL-1234", "get
  ATL-1234 into 26.3.2", "port this ticket onto the release branch", or hands
  over a ticket key that already landed on main and now needs to reach a
  release. Also use when the user asks for a cherry-pick without naming a
  ticket — the key is inferred from the current branch or its PR. Resolves the
  ticket's fix version to a release branch, cherry-picks with -x, opens a draft
  PR, watches CI, and marks it ready when green.
disable-model-invocation: true
compatibility: Requires `git`, `gh` (GitHub CLI), and `acli` (Atlassian CLI). Run from inside the repository holding the commit.
---

# Jira ticket → release branch cherry-pick

Given a ticket key, move the work that is already on `main` onto the release
branch its fix version names, and get a draft PR in front of CI.

The whole run is mechanical except for two judgement calls: **which commit**
and **which branch**. Both are worth getting right rather than fast — a
cherry-pick onto the wrong release branch is quiet until the release ships.

## Inputs

- **User provides**: a Jira ticket key (e.g. `ATL-1234`). Normalize to uppercase.
  If none was given, infer it (step 1) rather than asking straight away.
- **Agent infers**: the ticket key when absent, the source commit on `main`, the
  target release branch from the ticket's fix version, and the repository (the
  current working directory).

## Procedure

### 0. Load the `jira` skill

Load it before any Jira operation — it provides field selection, the
ADF-cleaning filter, and component→repo mapping.

### 1. Determine the ticket key

If the user gave a key, use it — an explicit key always wins over an inferred
one, even when the current branch names a different ticket.

Otherwise infer it, in this order, and stop at the first that yields a key:

1. **The current branch name.** Branches here carry the key as a prefix —
   `ATL-3859`, `ATL-3859_fix-margins`, `feature/ATL-1234-thing`.
   ```bash
   git rev-parse --abbrev-ref HEAD | grep -oiE '[A-Z]+-[0-9]+' | head -1 | tr 'a-z' 'A-Z'
   ```
2. **The PR associated with the branch.** Useful when the branch is named
   something else, or when the branch is already merged and deleted locally.
   ```bash
   gh pr view --json number,title,headRefName,url
   ```
   Take the key from the PR title, falling back to its head branch name. If
   `gh pr view` reports no PR for the current branch, that is a normal outcome,
   not an error — move on.

**Confirm the inferred key with the user before acting on it**, naming where it
came from ("branch name" / "PR #10905 title"). Inferring the wrong ticket sends
the wrong change to a release, and the user is one word away from correcting it.

- **Nothing inferred** — ask for the key. Don't scan the log for plausible
  recent tickets; the newest commit is not evidence of intent.
- **Two different keys** (branch says one, PR title another) — show both and
  ask. This usually means the branch was reused.

### 2. Fetch, then find the commit on main

Fetch first. A stale local `main` is the most common reason the commit "isn't
there", and it produces a confident wrong answer (no commit found) rather than
an error.

```bash
git fetch origin
git log origin/main --no-merges --grep="^ATL-1234" --format='%h %ad %an %s' --date=short
```

The `^` anchor matters: commit subjects start with the key, so anchoring avoids
matching tickets merely mentioned in a body.

- **One commit** — the normal case (squash merges). Use it.
- **Several commits** — list them with dates and ask which to pick, or whether
  to pick all of them in order. A follow-up fix commit is easy to leave behind,
  and a half-ported ticket is worse than an unported one.
- **None** — stop and ask the user how to proceed. Report what you searched,
  and offer the usual explanations: the key appears mid-message rather than at
  the start (retry without `^`), the work is not merged yet, or it lives in a
  different repository. Don't widen the search silently.

When the key was inferred from the current branch, "not on `main` yet" is the
likely answer rather than a surprise — the branch is probably the in-progress
work itself. Say so plainly and stop.

Also confirm the worktree is clean (`git status --porcelain`) before touching
branches. Stop if it isn't.

### 3. Resolve the fix version to a release branch

Read the ticket's `fixVersions`. A value like `Web 26.3.2` carries a platform
prefix — strip it, and the remainder is the branch suffix: `release/26.3.2`.

Verify the branch exists rather than trusting the transformation:

```bash
git rev-parse --verify origin/release/26.3.2
```

- **No fix version, or more than one** — ask which release to target. This is
  the developer's call, not an inference.
- **Branch doesn't exist** — list the candidates and ask:
  ```bash
  git branch -r --list 'origin/release*'
  ```
  The `Web <x.y.z>` → `release/<x.y.z>` mapping is a web convention, not a
  company-wide one (see Gotchas).

### 4. Branch off the release branch

```bash
git switch -c ATL-1234_cherry-pick origin/release/26.3.2
```

If the branch already exists locally or on the remote, stop and ask — it is
probably an earlier attempt, and reusing or clobbering it is the user's call.

### 5. Cherry-pick

```bash
git cherry-pick -x <sha-from-main>
```

Keep `-x`. It records `(cherry picked from commit …)` in the message, which is
how a release reviewer traces the change back to its reviewed original.

**On conflict**, judge whether it is mechanical:

- **Trivial** — import ordering, changelog or version-list entries, adjacent
  but unrelated lines, whitespace. Resolve it, `git add` the files, then
  `git cherry-pick --continue`. Report exactly which files you resolved and
  what you did, both in the final summary and in the PR body. A silently
  resolved conflict is the failure mode this skill has to avoid: the reviewer
  assumes the code is identical to what was approved on main.
- **Anything else** — the same lines carry different logic, the surrounding
  code diverged on the release branch, or the change depends on something not
  on that branch. Stop, leave the cherry-pick in progress, and report the
  conflicting files so the user can resolve them.
- **Regulatory tickets** — if the ticket carries `regulatory-impact`,
  `safety-critical`, or `qms`, don't resolve conflicts at all, trivial or not.
  Hand the conflict back. Glooko is a Class II medical device company and those
  changes need human authorship.

### 6. Push and open a draft PR

```bash
git push -u origin ATL-1234_cherry-pick
gh pr create --fill --base release/26.3.2 --draft
```

`--fill` reuses the cherry-picked commit message, so the PR already carries the
ticket key and the `(cherry picked from commit …)` line.

If you resolved conflicts in step 5, append a note to the PR body naming the
files and the resolution (`gh pr edit <number> --body-file …`), so it is visible
before review rather than buried in the diff.

### 7. Watch CI, then hand over

```bash
gh pr checks --watch --fail-fast
```

- **All green** — `gh pr ready`, then tell the user: PR URL, source commit,
  target branch, and any conflict resolution.
- **A check fails** — leave the PR as a draft and tell the user which checks
  failed, with `gh run view <run-id> --log-failed` for the detail. Fixing CI is
  not part of this run; the `gh-ci-fix` skill exists for that and the user
  decides whether to invoke it.
- **Watch times out or hangs** — report the current check state and the command
  to re-check. Don't loop on it.

## Validation

Before reporting done:

- `git log -1` on the new branch shows the `(cherry picked from commit …)` line
  with the sha you found in step 2.
- `git diff origin/release/26.3.2...HEAD` contains only the ported change —
  nothing dragged in from an unrelated base.
- The PR's base is the release branch, not `main`.
- If you resolved a conflict, the PR body says so.

## Gotchas

- **An inferred key is a guess until confirmed.** A branch can outlive the
  ticket it was named for, and a reused branch names the wrong one. Confirming
  costs one exchange; a cherry-pick of the wrong ticket costs a release.

- **The branch you are on is usually not the one to port.** If the current
  branch still holds unpushed work for its ticket, that ticket hasn't reached
  `main` — a cherry-pick is premature.

- **Fetch before searching.** Cherry-picks usually happen right after a merge,
  which is exactly when local `main` is stale.

- **Release branch naming is per-platform.** Web repos (e.g. `kings-landing`)
  use `release/26.3.2`. The mobile repos `riverrun` and `winterfell` use
  codename branches like `release_snorlax` — the version-number transformation
  produces a branch that doesn't exist there. Verifying the ref catches this;
  guessing doesn't.

- **The fix version has a platform prefix.** `Web 26.3.2`, not `26.3.2`. Strip
  the prefix, keep the number exactly — `26.3.2`, `26.3.1.1` and `26.3` are
  three different live branches.

- **Glooko merges to main first, then to the release branch.** If the commit
  isn't on `main` yet, the cherry-pick is premature — say so rather than
  sourcing it from somewhere else.

- **Squash merges mean one commit, usually.** "Usually" is why step 2 lists
  what it found instead of silently taking the newest.

## Stop conditions

- No ticket key given and none inferable → ask.
- Dirty worktree, or the cherry-pick branch already exists → ask.
- No commit found on `main` for the key → ask, don't widen the search alone.
- Fix version missing, ambiguous, or its branch doesn't exist → ask.
- Non-trivial conflict, or any conflict on a regulatory ticket → hand back with
  the cherry-pick in progress.
- CI red → leave the PR as a draft, report, stop. No fixing.
- Never rebase, force-push, or commit to `main` or the release branch directly.
  The PR is the only way the change lands.
- Jira stays read-only — no comments, transitions, or field edits.

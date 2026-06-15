---
name: branch-context
description: >-
  Gather context from a feature branch to understand what work has been done.
  Use when users say "catch me up", "what's changed on this branch", "understand
  these changes", "get up to speed", "review what's been done", "what work has
  been done", or start a new session on an in-progress feature branch and need
  the agent to understand existing work before taking further instructions.
---

# Branch Context

## Overview

Analyze the current feature branch to understand what changes have been made
relative to the base branch. Build a working model of the work done so far —
files changed, patterns used, decisions made — so you are prepared for whatever
the user asks next. This skill is read-only context gathering; it does not
modify code or git state.

## Inputs

- **User provides**: intent to understand the branch (optionally: base branch)
- **Agent infers**: current branch name, base branch (via merge-base, defaulting
  to main/master), scope of changes

## Procedure

1. **Identify the current branch.** Run `git branch --show-current`. If on
   main/master or detached HEAD, ask the user which branch to analyze.

2. **Determine the base branch.** Try `git merge-base main HEAD` first, then
   `git merge-base master HEAD` if that fails. If the user specified a base
   branch, use it. Default to main when ambiguous.

3. **Check for uncommitted work.** Run `git status --short` to note any staged
   or unstaged changes beyond what's committed — the user may have work in
   progress.

4. **Get the commit history.** Run `git log --oneline --reverse <base>..HEAD`
   to see the sequence of work. Note the narrative: what was done first, what
   was iterated on, what was added later.

5. **Get the diff overview.** Run `git diff --stat <base>...HEAD` for a
   file-level summary. This tells you scope and where effort concentrated.

6. **Read into significant changes.** For files with substantial modifications,
   read the full diff (`git diff <base>...HEAD -- <file>`) or the current file
   state to understand the complete picture. Prioritize:
   - New files (they define the feature's shape)
   - Files with the most churn
   - Configuration or dependency changes (they signal tooling decisions)

7. **Synthesize a summary.** Organize your understanding into:
   - **What was done**: high-level description of the feature or fix
   - **Files changed**: grouped by purpose (new, modified, deleted)
   - **Key decisions**: patterns chosen, libraries added, architectural choices
   - **Current state**: is the work complete, in progress, or blocked?
   - **Uncommitted work**: anything staged or unstaged from step 3

8. **Present the summary** to the user. Keep it concise but substantive — this
   is your working context for the requests that follow.

## Validation

Spot-check accuracy before presenting:
- Commit count matches `git rev-list --count <base>..HEAD`
- File list aligns with the `git diff --stat` output
- No hallucinated files, changes, or decisions

## Gotchas

- **Large branches** (50+ files changed): lean on the diff stat overview and
  focus on the highest-impact files rather than reading every diff.
- **Merge commits**: use `git log --no-merges` to focus on actual work commits
  and avoid noise from merge resolution.
- **Rebased branches**: merge-base may not resolve cleanly. Fall back to
  diffing against main/master HEAD directly.
- **Monorepo with multiple services**: note which services or packages are
  affected — this shapes what the user will ask next.

## Stop Conditions

- Do not make any changes to code, commits, or git state.
- Do not create PRs or push branches.
- If the branch has no commits beyond the base, say so and stop.
- Do not pull in external context (Jira tickets, PR descriptions) unless the
  user asks — other skills handle those concerns.

---
name: jira-implement
description: Take a Jira ticket key, work out how to resolve it, and either implement it, plan it, or report what's blocking. Use when the user says "work on ATL-1234", "implement this ticket", "pick up GLOO-567", "can we do ATL-1234", or hands over a ticket key expecting the work to start. Produces a blocker report when the ticket is underspecified, a plan when the work is large, or the change itself when it's small.
disable-model-invocation: true
compatibility: Requires `acli` (Atlassian CLI). Run from inside the repository the ticket targets.
---

# Jira → implementation

Given a ticket key, decide which of three things the ticket actually warrants — a **blocker report**, a **plan**, or **the change itself** — and produce it. The decision is the skill; the writing is the easy part.

The value here is refusing to guess. A ticket that says "add the export button" without saying what it exports produces a report, not an implementation built on an invented answer.

## Inputs

- **User provides**: a Jira ticket key (e.g. `ATL-1234`). Normalize to uppercase.
- **Agent infers**: the target repository (the current working directory, cross-checked against the ticket's component), the codebase context, and whether the work is small enough to one-shot.

## Procedure

### 0. Load the `jira` skill

Load it before any Jira operation. It provides field selection, the ADF-cleaning filter, component→repo mapping, workflow state meanings, and DHF/label context used throughout the steps below.

### 1. Fetch the ticket and its surroundings

Fetch the ticket with the full read field set — summary, description, status, issuetype, fixVersions, parent, issuelinks, comments, assignee, labels, and the Glooko components field.

Then follow the context the ticket points at, because underspecified tickets usually have their missing half somewhere nearby:

- **Parent epic** — fetch it whenever the description references something it doesn't explain. Epics routinely carry the "why" that the child ticket assumes.
- **Comments** — often carry the real requirement, a scope correction, or a QA bounce-back reason that contradicts the description. Read them all.
- **Linked issues** — blockers, "relates to", and DHF traceability links (`SDS-*`, `MSRS-*`, etc.).

If `acli` fails, surface the error verbatim and stop.

### 2. Guardrail: regulatory labels

If the ticket carries `regulatory-impact`, `safety-critical`, or `qms`, stop before writing any code. Report the labels, summarize what the ticket asks for, and let the human decide how to proceed. Glooko is a Class II medical device company; these tickets need human authorship.

This check stays here rather than being delegated, because a guardrail that only fires when another skill loads successfully is not a guardrail.

### 3. Sanity-check the repository

Resolve the ticket's component to a repository. If it doesn't match the repo you're in, say so and ask before continuing — an implementation in the wrong repo wastes the whole run. If the component is unset or unmapped, name the exact value found and ask which repo to work in.

Also note the status. A ticket already in `Ready for Review`, `Resolved`, or `Done` probably has work in flight; mention it rather than duplicating someone's PR.

### 4. Investigate the resolution

This is the substance of the skill — do it before deciding which output to produce, because you cannot judge "blocking" or "small" without it.

- Find the code the ticket touches. Read it, don't skim it.
- Identify the existing patterns the change should follow.
- Trace what else depends on the code you'd change.
- Work out how the change would be verified — which tests exist, which would need writing.
- Form a concrete resolution: which files, which approach.

While investigating, keep a running list of every point where you had to guess. That list is the raw material for step 5.

### 5. Triage the guesses

For each guess, ask: **would different answers lead to materially different implementations?**

- **No** → not blocking. Pick the sensible answer, note the assumption, keep going. Judgment calls a careful engineer makes without asking are not findings.
- **Yes** → blocking. It goes in the report.

Then classify each blocking finding:

- **Product decision** — the answer depends on what the product should do for users. Needs a person who owns the behavior. Gets a question in user terms (see below).
- **Technical decision** — the answer depends on the system, not the product. Needs a person who owns the code. Gets a direct technical question, plus your recommendation.
- **Contradiction** — the ticket, its comments, its epic, or the existing code disagree with each other. State both sides verbatim and ask which one holds.

Being trigger-happy here is its own failure. A report of eleven findings, nine of which you could have answered yourself, gets ignored — and the two real ones go with it.

### 6. Produce exactly one output

| Situation | Output |
|---|---|
| One or more blocking findings | Blocker report → `./<KEY>-blockers.md` |
| No blockers, small enough to one-shot | Confirm, then implement |
| No blockers, larger than one-shot | Plan → `./<KEY>-plan.md` |

Blockers take precedence. Don't write a plan that has holes in it and hope the implementer notices — that's how an underspecified ticket turns into an underspecified PR.

**"Small enough to one-shot"** means all of these hold:
- One repository, a handful of files
- No schema migration, no API contract change, no new dependency
- No cross-team or cross-repo coordination
- Existing test patterns cover it — you know how to verify it
- You can hold the whole change in your head

If any one of these fails, write a plan. When it's genuinely borderline, say so and let the user pick.

## Output: blocker report

Write to `./<KEY>-blockers.md` at the repo root.

```markdown
# <KEY> — blocked

**Ticket**: <KEY> — <summary>
**Status**: <status> · **Type**: <issuetype> · **Component**: <component value>

## Summary
<Two or three sentences: what the ticket asks for, and what stands in the way.>

## What I found in the code
<What you learned in step 4 — the files involved, the existing pattern, the intended shape of the change. This is what makes the report worth reading even after the questions are answered.>

## Blocking findings

### 1. <Short title>
**Type**: Product decision
**What's missing**: <The specific fact the ticket does not state.>
**Why it blocks**: <The two or more implementations that follow from the possible answers, and why picking one arbitrarily is not acceptable.>
**Question for Product**:
> <One question, in user terms.>

### 2. <Short title>
**Type**: Technical decision
**What's missing**: <...>
**Why it blocks**: <...>
**Question**: <Direct technical question.>
**My recommendation**: <What you'd do and why — so the answer can be a yes rather than an essay.>

## Assumptions I'm prepared to make
<Non-blocking guesses from step 5, so the reader can veto any that are wrong.>
- <Assumption> — <one-line rationale>

## What happens once these are answered
<One or two sentences on the shape of the work, so scope is visible before the answers land.>
```

### Writing questions in user terms

A Product question is answerable by someone who has never opened the repository. It talks about what a person using the product sees and does — no identifiers, no file paths, no table or field names, no framework vocabulary.

- ✅ "When a patient's data is still syncing and they tap Export, should we block the export until it finishes, or export what we have and tell them it may be incomplete?"
- ❌ "Should `exportHandler` await `syncQueue.drain()` or return the partial `ReadingSet` with a `stale: true` flag?"

Both ask the same thing. Only one gets an answer.

Make the alternatives explicit — a question that offers two named options gets a decision; an open-ended one gets a meeting. And ask about the behavior, not the implementation: "what should happen when…", not "which approach should we take".

## Output: plan

Write to `./<KEY>-plan.md` at the repo root.

```markdown
# <KEY> — implementation plan

**Ticket**: <KEY> — <summary>
**Component**: <component> → <repo>
**Fix version**: <fixVersions, or "none">

## Goal
<What "done" looks like, in one paragraph.>

## Current state
<What exists today in the code that this builds on or changes. Cite files as `path/to/file.ext:line`.>

## Approach
<The chosen approach, and — where a real alternative existed — why this one over that one.>

## Steps
1. <Step, concrete enough to act on: which file, what change.>
2. <...>

## Verification
<How each step is checked: which tests to run, which to write, what to exercise manually.>

## Assumptions
- <Assumption> — <rationale>

## Risks and open threads
<Non-blocking unknowns, code that might bite, coordination worth flagging.>
```

Cite real file paths and line numbers. A plan that stays at the level of "update the export logic" is a restatement of the ticket, not a plan.

## Output: the change itself

Before editing anything, tell the user in a few lines: your read of the ticket, the change you intend to make, the files it touches, and any assumption it rests on. Wait for the go-ahead.

The confirmation is cheap and catches the expensive failure — a confidently misread ticket. Once approved, load the `code-writing` skill and implement it, following the repo's existing patterns and its test conventions.

Once the change is working and its tests pass, offer to commit it. Load the `commit` skill and give it the ticket key you already have — it would otherwise infer the key from the branch name or recent history, which is guesswork you can skip here.

Stop at the commit. No pushing, no PR, no ticket transition — those are the user's call, and each has its own skill.

Commit the code change only. A `<KEY>-plan.md` or `<KEY>-blockers.md` from an earlier run is a local working note, not part of the deliverable; leave it unstaged.

## Validation

Before presenting any output:

- **Blocker report** — every finding survives the "materially different implementations" test. Every Product question is answerable without opening the repo. No finding is something you could have decided yourself.
- **Plan** — steps name real files that exist; verification is specific; nothing reads "TBD".
- **Implementation** — tests pass, and you say plainly if they don't.

## Gotchas

- **The description is not the whole ticket.** At Glooko, comments regularly carry the real requirement, and epics carry the reason. A ticket that looks underspecified at the description level is often fully specified once you've read around it — check before writing a report.

- **Acceptance criteria live in the description.** There's no dedicated AC field; they're prose inside the description, under a heading or as a checklist. Don't report AC as missing without reading the whole description.

- **Fix versions inform branching but aren't your call.** Surface the fix version to the user, especially post-feature-freeze when release branches are live. Don't pick a base branch yourself.

- **DHF links are read-only.** A linked `SDS-*` / `MSRS-*` ticket is regulatory traceability. Read it for requirements; never modify it.

- **A stale ticket isn't a blocker.** If the code already does what the ticket asks, say so and stop — closing it may be the right answer, and that's the user's call, not a finding.

## Stop conditions

- Regulatory labels present → stop before writing code, report and hand back.
- Component maps to a different repo, or is unset → ask, don't guess.
- `acli` fails → surface verbatim, stop.
- Blocking findings exist → write the report and stop. Do not implement "the unambiguous part" of a ticket whose core behavior is undecided.
- One output per run. Don't write a plan alongside a blocker report, and don't start implementing after writing either.
- Jira stays read-only. No comments, no transitions, no field edits — the report is local, and the user decides what reaches the ticket.
- Committing is the far end of the run. Pushing, opening a PR, or moving the ticket is not part of this skill.

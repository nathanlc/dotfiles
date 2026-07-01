---
name: spec-to-tasks
description: Break a plan, spec, or PRD into independently-grabbable tasks using tracer-bullet vertical slices and write them as numbered files in a tasks/ folder. Use when the user says "break this into tasks", "create tasks from this spec", "turn this into tasks", or wants to plan implementation work from a design document.
disable-model-invocation: true
---

# Spec to Tasks

Break a plan or spec into independently-grabbable tasks using vertical slices (tracer bullets), then write them as numbered files in a `tasks/` folder at the project root.

These tasks are intended to be picked up by agents with no prior conversation context. Each task file must be fully self-contained — an agent reading it in isolation should have everything it needs to implement the slice correctly.

## Process

### 1. Gather context

Work from whatever is already in the conversation context. If the user passes a file path or spec document as an argument, read it fully. Note the path — you will reference it in each task's `## Source` section.

### 2. Explore the codebase

Explore the codebase to understand the current state of the code. Task titles and descriptions should use the project's own vocabulary and respect the patterns and conventions already in place.

As you explore, note which files and modules are relevant to each area of the plan — you will surface these in each task's `## Relevant files` section so the implementing agent doesn't have to re-discover them.

Look for opportunities to prefactor the code to make the implementation easier. "Make the change easy, then make the easy change."

### 3. Draft vertical slices

Break the plan into **tracer bullet** tasks. Each task is a thin vertical slice that cuts through ALL integration layers end-to-end, NOT a horizontal slice of one layer.

<vertical-slice-rules>

- Each slice delivers a narrow but COMPLETE path through every layer (schema, API, UI, tests)
- A completed slice is demoable or verifiable on its own
- Any prefactoring should be done first

</vertical-slice-rules>

### 4. Quiz the user

Present the proposed breakdown as a numbered list. For each slice, show:

- **Title**: short descriptive name
- **Blocked by**: which other tasks (if any) must complete first
- **What it delivers**: one sentence on what the completed slice gives you

Ask the user:

- Does the granularity feel right? (too coarse / too fine)
- Are the dependency relationships correct?
- Should any tasks be merged or split further?

Iterate until the user approves the breakdown.

### 5. Write the task files

For each approved task, create a file at `tasks/<NNN>-<kebab-title>.md` (e.g. `tasks/001-add-user-auth.md`). Write tasks in dependency order (blockers first) so you can reference real task numbers in the "Blocked by" field.

Check the `tasks/` folder first — if files already exist, continue numbering from where they left off.

Use the task template below for each file.

### 6. Write todo.md

After all task files are written, create (or overwrite) `todo.md` at the project root. Write one line per task in dependency order:

```
- [ ] 001-<kebab-title>.md
- [ ] 002-<kebab-title>.md
...
```

This file is used by automation that loops over tasks one by one. Keep it minimal — one path per line, no headings, no extra prose.

**Writing guidance for agent-facing tasks:**

- Write "What to build" as if the reader has never seen the spec. Do not rely on shared context from the conversation — the agent picking this up will have none.
- Acceptance criteria must be verifiable pass/fail signals: a test that passes, a CLI command that returns a specific output, a visible UI state. Avoid subjective prose like "the feature works correctly."
- "Out of scope" is not optional — explicitly name things an agent might reasonably attempt but shouldn't. This is the primary guard against over-building.
- "Relevant files" should reflect what you found during codebase exploration. List the files the agent should read first to get oriented.
- The tracer bullet hint should name the single first behavior that proves the vertical slice works end-to-end. This is the agent's starting point.

<task-template>
# <NNN>: <Title>

## Source

`<path-to-spec-file>` — read this for full background if needed.

## What to build

A concise, self-contained description of this vertical slice written for an agent with no prior context. Describe the end-to-end behavior, not layer-by-layer implementation.

Avoid specific file paths or code snippets — they go stale fast. Exception: if a prototype produced a snippet that encodes a decision more precisely than prose can (state machine, reducer, schema, type shape), inline it here and note briefly that it came from a prototype. Trim to the decision-rich parts — not a working demo, just the important bits.

## Out of scope

What this task explicitly does NOT cover. Name things an agent might reasonably attempt but shouldn't:

- Thing 1 (handled in task <NNN>)
- Thing 2 (not part of this feature)

## Acceptance criteria

Each criterion must be a verifiable pass/fail signal — a test that passes, a command that returns a specific result, a UI state that is reachable:

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Relevant files

Files and modules to read first to get oriented. Populated during codebase exploration:

- `path/to/file.ts` — brief note on why it's relevant

## TDD approach

Implement this task using test-driven development: **one behavior at a time**, red → green → refactor.

**Do not write all tests first.** Each test should respond to what you learned from the previous cycle. Write one test for one behavior, make it pass with minimal code, then move to the next.

```
RED→GREEN: test1→impl1
RED→GREEN: test2→impl2
RED→GREEN: test3→impl3
...
```

**Start here (tracer bullet):** `<one sentence naming the first behavior to test — the simplest thing that proves the vertical slice works end-to-end>`

For each cycle:
- [ ] Test describes behavior, not implementation
- [ ] Test uses public interface only
- [ ] Test would survive an internal refactor
- [ ] Code is minimal for this test
- [ ] No speculative features added

Only refactor after all tests pass. Never refactor while RED.

## Blocked by

- Task <NNN>: <Title> (if any)

Or "None — can start immediately" if no blockers.

## Commit

Once all acceptance criteria pass, commit your changes. Do not include `tasks/` or `todo.md` in the commit — those track the backlog and are not part of the implementation.
</task-template>

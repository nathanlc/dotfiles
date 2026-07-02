---
name: session-retrospective
description: >-
  Reflect on the current session to surface difficulties, wasted effort, and actionable
  improvement opportunities. Use when users say "retro", "retrospective", "how did that
  go", "what went wrong", "could we have done better", "session retro", or ask the agent
  to reflect on the session.
disable-model-invocation: true
---

## Overview

The bar for recommendations is high — only surface one if it would plausibly prevent a
real problem from recurring. An empty recommendations section is a good outcome.

## Procedure

1. **Scan the full session history and identify difficulty signals:**
   - Repeated failed attempts at the same task
   - Trial-and-error that ended in success — several failed attempts followed by one
     exact command, flag, or snippet that worked
   - Errors that required multiple recovery steps
   - Clarification loops — the user correcting the same misunderstanding more than once
   - Backtracking or redoing work already completed
   - Confusion about where something lived (file, API, config key, convention)

2. **Identify wasted effort:** files read in full when targeted would have sufficed, the
   same context loaded more than once, searches returning too much noise, back-and-forth
   that prior context could have prevented.

3. **Evaluate each friction point before recommending anything:**
   - Is it a pattern, not a one-off? Skip one-time flukes.
   - Would a skill have helped? Only if there's a clear, repeatable workflow the agent
     had no guidance for.
   - Would an AGENTS.md entry have helped? Only for non-inferrable facts: a hidden
     location, an unwritten convention, a footgun, a do-not-touch zone. Not for anything
     readable from the repo itself.
   - Is it already covered? Check whether the fact or workflow is already in a skill or
     AGENTS.md before recommending.
   - Did the agent stumble into a working command, flag, or snippet only after failed
     attempts? This doesn't need to be a pattern to be worth keeping — unlike the checks
     above, capture it even as a one-off, since the exact syntax that worked is unlikely
     to be reconstructed the same way twice from memory alone.

4. **Present the output** following the template below.

## Output

### What was difficult
Each friction point with a brief explanation of why it caused difficulty.
Omit if the session had no significant friction.

### Wasted effort
Turns or tokens spent on unnecessary work.
Omit if none.

### Recommendations
Only include if a change would genuinely help. Be specific:
- **New skill**: what it would cover and what phrases would trigger it
- **AGENTS.md addition**: the exact fact or rule to add and why it isn't inferrable from the repo
- **Known-good command**: the exact command or snippet that worked, in a fenced code
  block, with a one-line note on what didn't work and why this did. Suggest a home for
  it — an AGENTS.md gotcha, a skill's `scripts/` file, or just left here inline if there's
  no durable home for it yet

Omit if there is nothing worth recommending.

### Overall
One sentence on how the session went.

---
Omit any section that doesn't apply — an empty section adds no value.

## Stop Conditions

- If the session went smoothly with no significant friction, say so briefly and stop.
- Do not recommend adding inferrable facts to AGENTS.md (build commands, file structure,
  framework conventions an agent can read).
- Do not recommend a skill for something already well-handled or unlikely to recur.

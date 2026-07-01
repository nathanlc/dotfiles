---
name: session-retrospective
description: >-
  Reflect on the current session to surface difficulties, wasted effort, and actionable
  improvement opportunities. Use when users say "retro", "retrospective", "how did that
  go", "what went wrong", "could we have done better", "session retro", or ask the agent
  to reflect on the session.
disable-model-invocation: true
---

# Session Retrospective

## Overview

Review the current session to identify where the agent struggled, spent unnecessary tokens
or turns, and whether any concrete changes (a new skill, an AGENTS.md addition) would
genuinely help future sessions.

The bar for recommendations is high — only surface one if it would plausibly prevent a
real problem from recurring. An empty recommendations section is a good outcome.

## Procedure

1. **Scan the full session history** in context.

2. **Identify difficulty signals:**
   - Repeated failed attempts at the same task
   - Errors that required multiple recovery steps
   - Clarification loops — the user correcting the same misunderstanding more than once
   - Backtracking or redoing work already completed
   - Confusion about where something lived (file, API, config key, convention)

3. **Identify wasted effort:**
   - Files or tool outputs read in full when a targeted read would have sufficed
   - The same context loaded more than once
   - Searches that returned too much noise
   - Long back-and-forth that prior context could have prevented

4. **Evaluate each friction point against the recommendation bar.** Before recommending
   anything, verify all of the following:
   - *Is it a pattern, not a one-off?* Skip one-time flukes.
   - *Would a skill have helped?* Only if there's a clear, repeatable workflow the agent
     had no guidance for.
   - *Would an AGENTS.md entry have helped?* Only for non-inferrable facts: a hidden
     location, an unwritten convention, a footgun, a do-not-touch zone. Not for anything
     readable from the repo itself.
   - *Is it already covered?* Check whether the fact or workflow is already in a skill or
     AGENTS.md before recommending.

5. **Present the retrospective** using this structure:

   ### What was difficult
   Each friction point with a brief explanation of why it caused difficulty.
   Omit this section if the session had no significant friction.

   ### Wasted effort
   Turns or tokens spent on unnecessary work.
   Omit this section if none.

   ### Recommendations
   Only include if a change would genuinely help. Be specific:
   - **New skill**: what it would cover and what phrases would trigger it
   - **AGENTS.md addition**: the exact fact or rule to add and why it isn't inferrable
     from the repo

   Omit this section if there is nothing worth recommending.

   ### Overall
   One sentence on how the session went.

## Stop Conditions

- If the session went smoothly with no significant friction, say so briefly and stop.
- Do not recommend adding inferrable facts to AGENTS.md (build commands, file structure,
  framework conventions an agent can read).
- Do not recommend a skill for something already well-handled or unlikely to recur.
- Do not fill sections to look thorough — omit empty sections entirely.

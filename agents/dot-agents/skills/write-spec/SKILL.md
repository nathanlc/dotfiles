---
name: write-spec
description: Turn a rough or partially-defined idea into a complete, unambiguous design document. Use when the user says "spec this out", "write a spec for", "turn this into a spec", or wants to nail down an idea before implementation. Manual invocation only — do not auto-trigger.
disable-model-invocation: true
---

## Overview
Take an idea — however rough — and produce a design document that eliminates ambiguity, surfaces edge cases, and captures everything a reader needs to fully understand the feature without looking at the code. This is not an implementation plan. No ordered steps, no "then do X". The output describes *what* and *why*, not *how to build it*.

The document will later be consumed by an agent that splits it into tasks — so it must be self-contained and precise.

## Inputs
- **The idea**: provided by the user, as rough or as defined as they have it
- **Codebase context**: explore as needed to resolve ambiguities — go as deep as the gaps require

## Procedure

1. **Load the `grill-me` skill.** It provides the interviewing behavior used to fill gaps in step 3.

2. **Understand the idea.** Ask the user to describe it if they haven't. One open question is enough to start — let them dump everything they have.

3. **Explore the codebase.** Before interviewing, investigate on your own:
   - Is there existing code that does something similar or related?
   - Are there patterns, conventions, or abstractions the new feature should follow or diverge from?
   - Are there constraints (data model, API shape, config, auth) that would affect the design?
   - Summarize what you found — existing patterns or the absence of them — before proceeding.

4. **Fill gaps by grilling the user.** Using what you've gathered, identify what's still ambiguous. Apply the `grill-me` skill: interview the user one question at a time, providing your recommended answer for each. Resolve:
   - Unclear scope or boundaries
   - Behavior under edge cases
   - Surprising interactions with existing systems
   - Anything that would require a judgment call during implementation
   Stop when you can write the document without making assumptions.

5. **Write the design document** to the repo root. Choose a kebab-case filename that is specific enough to identify the feature at a glance and does not conflict with an existing file. Do not ask the user to confirm the name — pick one and write it.

6. **Review for completeness.** Before presenting, verify:
   - No section has an unanswered question or a "TBD"
   - Edge cases section is non-empty
   - Gotchas reflect real non-obvious facts, not generic observations
   - The document reads clearly without requiring the reader to look at the code

## Document template

```markdown
# <Feature Name>

## Summary
What this is, why it exists, and what problem it solves. One short paragraph.

## Goals
- Concrete outcomes this achieves

## Non-goals
- What this explicitly does not cover or solve

## Context & Existing Patterns
What already exists in the codebase that relates to this. How this fits, extends, or intentionally diverges from those patterns. If nothing relevant exists, say so.

## Design
Full behavioral specification. What the feature does, what the rules are, how it behaves in the normal case. No implementation steps — describe behavior and intent.

## Edge Cases
Specific scenarios that need explicit handling, with the expected behavior for each.

## Gotchas
Non-obvious facts: things that would surprise a reader unfamiliar with this area, implicit constraints, hidden dependencies, or behavior that contradicts reasonable assumptions.

## Open Questions
Any unresolved questions. Should be empty before the document is finalized.
```

## Gotchas
- Do not let the document become an implementation plan. If you find yourself writing ordered steps or describing how code should be structured, reframe it as behavior.
- "Existing patterns" is not optional filler — if you found relevant code, be specific: name the file, function, or concept so a reader can find it.
- If the user's idea is genuinely small and unambiguous, the document can be short. Don't pad it. A tight two-page spec beats a bloated five-page one.

## Stop conditions
- Stop grilling when you can write the document without making assumptions.
- Do not extend scope to adjacent ideas the user mentions but doesn't want specced — note them in Non-goals if relevant.
- Do not start writing until the interview is complete enough to fill all sections without placeholders.

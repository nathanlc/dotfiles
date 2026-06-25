---
name: code-writing
description: >-
  Guidelines for writing and editing code. Use this skill whenever the agent is
  about to write new code, add a feature, fix a bug, or edit existing code — regardless
  of language or project type.
---

# Code Writing

## Overview

Before writing or editing any code, work through this decision ladder top-to-bottom
and stop at the first rung that holds. Only reach the bottom if every rung above fails.

## Decision Ladder

1. **Does this need to exist?**
   If not — skip it. Don't build things that aren't required.

2. **Already in this codebase?**
   Search before writing. Reuse existing code; don't duplicate it.

3. **Stdlib does it?**
   Prefer the standard library over custom implementations.

4. **Native platform feature?**
   Use what the platform provides before reaching for anything else.

5. **Installed dependency?**
   If a dependency already in the project covers it, use it.

6. **One line?**
   If it can be written in one line, write it in one line.

7. **Only then: the minimum that works.**
   Write the smallest, simplest implementation that satisfies the requirement.

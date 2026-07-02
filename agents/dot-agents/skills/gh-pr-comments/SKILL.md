---
name: gh-pr-comments
description: Look at the unresolved comments of the user's PR and handle them. Use when user wants the PR's comments to be addressed.
---

Look at the comments in **unresolved** conversations of the pull request (look at replies too). Unless told otherwise, look at the PR associated with the current branch (use gh cli).

For each comment that raises a potential problem or asks for clarification or for change:
- Investigate validity of the comment
- Come up with a way to address the comment (potential fix and/or potential answer)
- Ask the user before acting on the comments.
- Wait for explicit user confirmation before making any changes
- If the user selects specific items, confirm your understanding of the scope before proceeding
- Only then load the `code-writing` skill and implement the requested fixes

---
name: gh-pr-review
description: Do a thorough code review of the given pull request. Use when user wants a pull request to be reviewed.
---

Goal is to do a thorough review of given pull request. If no PR is specified by the user, use the PR linked to the current branch.
To do this, several independent sub agents with different models (claude-opus-4.6 and gpt-5.4) should perform a review.

Each independent review should not only look at the diff but also look at the code base to understand the context if need be.
Each review should categorize its findings in severity (major, high, medium, low).

Once the different reviews have been gathered, the findings should be compared and evaluated so that a final review can be given.
The final review should start with a summary of the PR (what happens and where) and then the different findings ordered by severity (highest first).

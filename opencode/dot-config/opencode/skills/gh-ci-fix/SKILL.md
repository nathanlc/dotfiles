---
name: gh-ci-fix
description: Watch the CI status of the user's PR and automatically fix on failure. Use when user wants to the CI to be monitored and errors fixed.
---

Watch the CI for the github pull request, polling status every 60 seconds (use gh cli).

If the CI fails. Figure out the reason for the failure.
If you can address the failure fix it and report to the user.

If the CI succeeds, report to the user.

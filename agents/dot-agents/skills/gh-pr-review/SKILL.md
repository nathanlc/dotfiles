---
name: gh-pr-review
description: Do a thorough code review of the given pull request. Use when user wants a pull request to be reviewed.
---

# gh-pr-review

## Overview
Goal is to do a thorough review of given pull request. If no PR is specified by the user, use the PR linked to the current branch.

## Workflow

### Step 1 — Fetch the diff
```
gh pr diff [PR_NUMBER] > /tmp/<tmp_file_name>.patch
```

### Step 2 — Choose two models
Use two models from different providers/architectures for diversity of findings.
Preferred: one Anthropic Claude model (Sonnet 4.6) and one OpenAI model (GPT 5.4).
Fall back if preferred ones are absent.

**If running in Pi:** do NOT call `subagent({ action: "models" })` for model discovery — it only shows subagent role config, not available models, and will always appear to show just one model even when others are configured. Instead skip directly to step 3 and use the hardcoded preferred IDs there.

### Step 3 — Spawn 2 parallel reviewer agents
Launch both agents in parallel, each with a fresh context.

**If running in Pi:** subagents inherit the session model by default — omitting `model:` means both reviewers silently use the same model, defeating the purpose. Always pass `model:` explicitly on each task with the preferred provider-prefixed IDs:
```
subagent({
  tasks: [
    {
      agent: "reviewer",
      model: "github-copilot/claude-sonnet-4.6"
    },
    {
      agent: "reviewer",
      model: "github-copilot/gpt-5.4"
    }
  ],
  context: "fresh"
})
```

Each reviewer should:
- Read the patch file from step 1 — do NOT embed the diff in the task string
- Read relevant source files from the codebase for additional context
- Reference the specific file + line for each finding
- Categorize findings as: major / high / medium / low

### Step 4 — Synthesize into a final report
- Start with a summary of what the PR does and where
- Compare findings: note where reviewers agree (higher confidence) and where they differ
- Order all findings by severity, highest first
- Do not re-verify findings with additional bash calls unless there is genuine ambiguity

### Step 5 — Ask the user before acting
After presenting the final report, **always pause and ask the user** whether they want any of the findings addressed. Do not start fixing or modifying code on your own.

Suggested prompt to the user:
> "Would you like me to address any of these findings? If so, let me know which ones (e.g. all majors, specific items, everything) and I'll get started."

- Wait for explicit user confirmation before making any changes
- If the user selects specific items, confirm your understanding of the scope before proceeding
- Only then load the `code-writing` skill and implement the requested fixes

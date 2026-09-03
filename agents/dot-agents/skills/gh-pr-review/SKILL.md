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

### Step 2 — Decide how many reviewers
Default is **one reviewer: you, in this session, with the current model.** Do not spawn
subagents for the default path — a single careful pass keeps the review cheap and avoids
handing the work to a weaker model.

Use two reviewers only when the user explicitly asks for it ("two reviewers", "two models",
"second opinion", "cross-check with another model"). Do not infer the request from the PR
being large or risky; if you think a second opinion is worth it, say so and let the user ask.

### Step 3 — Review the diff
Whichever mode, every reviewer should:
- Read the patch file from step 1 — if delegating, do NOT embed the diff in the task string
- Read relevant source files from the codebase for additional context
- Reference the specific file + line (or line range) for each finding — the review file in
  step 5 needs real line numbers to link to
- Categorize findings as: major / high / medium / low

**Single-reviewer mode (default):** do the review yourself, then go to step 4.

**Two-reviewer mode (only when the user asked for two):**

Pick two models from different providers/architectures for diversity of findings if
available. Preferred: one Anthropic Claude model (Sonnet 5) and one OpenAI model (GPT 5.4).
Fall back if preferred ones are absent.

*If running in Pi:* do NOT call `subagent({ action: "models" })` for model discovery — it
only shows subagent role config, not available models, and will always appear to show just
one model even when others are configured. Use the hardcoded preferred IDs below instead.

Launch both agents in parallel, each with a fresh context.

*If running in Pi:* subagents inherit the session model by default — omitting `model:` means
both reviewers silently use the same model, defeating the purpose. Always pass `model:`
explicitly on each task with the preferred provider-prefixed IDs:
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

### Step 4 — Synthesize the findings
- Start with a summary of what the PR does and where
- Order all findings by severity, highest first
- Do not re-verify findings with additional bash calls unless there is genuine ambiguity
- *Two-reviewer mode only:* compare findings — note where reviewers agree (higher
  confidence) and where they differ

### Step 5 — Write the review to a markdown file
The file is the deliverable; in chat print only a 3–5 line summary plus its path. Do not
paste the full report into the terminal.

**Where it goes:** the path given as an argument, if one was given. Otherwise
`pr-review-<PR_NUMBER>.md` in the root of the repository being reviewed. Always a real file
on disk — never an Artifact, never the scratchpad, never `/tmp`.

**Collect the link data first** (one call, before writing any markdown):
```bash
gh pr view [PR_NUMBER] --json number,title,url,author,headRefOid,changedFiles,additions,deletions
gh repo view --json nameWithOwner   # owner/repo of the base repo
```

**Link every finding to its exact line** using a blob permalink at the reviewed HEAD:
```
https://github.com/<owner>/<repo>/blob/<headRefOid>/<path>#L<line>
https://github.com/<owner>/<repo>/blob/<headRefOid>/<path>#L<start>-L<end>   # ranges
```
Use the full `headRefOid`, never `master`/`HEAD` — the link must still point at the
reviewed code after the branch moves on. Never invent line numbers: take them from the
patch or from the file, and if a finding has no single line, link the file without an anchor.

Optional in-diff anchors (`.../pull/<n>/files#diff-<hash>R<line>`, where `<hash>` is
`printf '%s' '<path>' | shasum -a 256 | cut -d" " -f1`) are brittle — only use them if you
verify one works.

**Build from the template** so every review looks the same:
- Copy `assets/review-template.md` and fill in the placeholders. Keep the section order:
  header/meta → what this PR does → findings (severity order) → reviewer disagreements →
  not blocking. Drop a section only if it is genuinely empty.
- Give every finding a stable ID (`F1`, `F2`, …), used in its heading.
- In single-reviewer mode, name the single model on the header line and drop the
  "Reviewer disagreements" section. In two-reviewer mode, keep it, and say in each finding
  when both reviewers raised it — agreement is the confidence signal.

### Step 6 — Never act on the findings
**Reporting is the whole job.** After writing the file, stop. Do not fix, refactor, edit,
stage, commit, or push anything, and do not offer to — not even for a one-line change, not
even when the fix is obvious, not even when asked to in the same breath as the review.

This holds because the skill runs unattended as well as interactively, and a reviewer that
can edit the branch it is reviewing is a different and much riskier tool than one that
cannot. The rule has to be the same in both, or it is not a rule.

If fixes are wanted, they are a separate request in a separate session, where the findings
file is the input.

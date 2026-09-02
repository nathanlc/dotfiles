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
Use two models from different providers/architectures for diversity of findings if available.
Preferred: one Anthropic Claude model (Sonnet 5) and one OpenAI model (GPT 5.4).
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
- Reference the specific file + line (or line range) for each finding — the artifact in
  step 5 needs real line numbers to link to
- Categorize findings as: major / high / medium / low

### Step 4 — Synthesize the findings
- Start with a summary of what the PR does and where
- Compare findings: note where reviewers agree (higher confidence) and where they differ
- Order all findings by severity, highest first
- Do not re-verify findings with additional bash calls unless there is genuine ambiguity

### Step 5 — Build the HTML review artifact
The artifact is the deliverable; in chat print only a 3–5 line summary plus the artifact
location. Do not paste the full report into the terminal.

**Collect the link data first** (one call, before writing any HTML):
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
- Copy `assets/review-template.html` and fill in the placeholders. Keep the section order:
  header/meta → what this PR does → findings (severity order) → reviewer disagreements →
  not blocking. Drop a section only if it is genuinely empty.
- Give every finding a stable ID (`F1`, `F2`, …) matching its `id` attribute, and mark
  findings raised by both reviewers with the `Both` badge.
- The template is content-only (starts at `<title>`) and self-contained — no CDN, no
  external CSS/JS. Keep it that way.

**Publish it:**
- *Claude Code*: write the filled file to the scratchpad and publish with the `Artifact`
  tool, then give the user the URL. Load the `artifact-design` skill first if you deviate
  from the template.
- *Pi / no Artifact tool*: write `/tmp/pr-review-<pr-number>.html` and give the user the
  path — do not open it. If the user asks for it to be opened, use `open -g` (macOS) so the
  browser loads it in the background instead of stealing the front window.

### Step 6 — Ask the user before acting
After handing over the artifact, **always pause and ask the user** whether they want any of the findings addressed. Do not start fixing or modifying code on your own.

Suggested prompt to the user:
> "Would you like me to address any of these findings? Give me the IDs (e.g. F1, F3), a severity (e.g. all majors), or 'everything', and I'll get started."

- Wait for explicit user confirmation before making any changes
- If the user selects specific items, confirm your understanding of the scope before proceeding
- Only then load the `code-writing` skill and implement the requested fixes

---
name: pr-review
description: Review GitHub pull requests. Use when the user asks to review a PR, look at a pull request, or give feedback on a PR.
argument-hint: "[PR number(s)] [repo]"
---

Review pull request(s): $ARGUMENTS

## Workflow

### 1. Identify the PRs

- Parse PR numbers and repository from `$ARGUMENTS`.
- If the repo is ambiguous, search GitHub for a matching repository using context from the conversation or working directory.
- Fetch PR metadata (title, description, author, base/head branches) for each PR.

### 2. Get the diffs

- Fetch the full diff for each PR using `gh pr diff` or the GitHub MCP tools.

### 3. Launch code-review subagents

- For each PR, launch a **code-review** subagent (background mode) with:
  - The PR title and description
  - The full diff
  - Instructions to focus on bugs, logic errors, backwards compatibility issues, and security concerns — not style or formatting.
  - Instructions to report only issues that matter for how this codebase is used, and to return nothing if there are none.
- Run reviews in parallel when reviewing multiple PRs.

### 4. Filter the findings

A review with nothing to report is a valid review. Do not pad it.

- Judge every candidate issue against how this codebase is actually used. An edge case that the
  code's real inputs cannot produce is not an issue. Unvalidated input from a source that is
  controlled by the repo, a file the analyst writes by hand, or a hardcoded config is not an
  issue.
- Drop findings whose fix would be speculative hardening: defensive checks for conditions that
  cannot occur, error handling for calls that cannot fail here, generality no caller needs.
- Drop style, naming, and formatting observations unless they cause a real misreading.
- Do not report a finding to demonstrate thoroughness. Padding the list makes the real findings
  harder to see and costs the author time verifying non-problems.
- If a concern depends on an assumption about usage you cannot verify, either check it against
  the codebase or state it as a question rather than a finding.

Say plainly when the diff looks fine.

### 5. Present findings to the user

- Summarize the review findings for each PR concisely.
- Categorize issues by severity (Critical / Medium / Low / Informational).
- Include specific file locations and code snippets.
- Suggest fixes where applicable.

### 6. Wait for user decision

After presenting findings, ask the user what action to take using `ask_user`. Offer choices based on the findings:

- If there are substantive issues found:
  - "Request changes" — submit a review requesting changes, with the issues as the review body
  - "Comment only" — submit as a comment review without blocking
  - "Approve anyway" — approve despite issues
  - "No action" — don't submit a review

- If no issues found:
  - "Approve and merge" — approve the PR and merge it
  - "Approve" — approve without merging
  - "No action" — don't submit a review

### 7. Execute the user's decision

- **Request changes**: `gh pr review <number> --repo <repo> --request-changes --body "<summary of issues>"`
- **Comment only**: `gh pr review <number> --repo <repo> --comment --body "<summary>"`
- **Approve**: `gh pr review <number> --repo <repo> --approve --body "LGTM"`
- **Approve and merge**: Approve first, then `gh pr merge <number> --repo <repo> --squash`
- **No action**: Do nothing.

## Notes

- When the user provides additional instructions (e.g., "note that X should be Y"), incorporate those into the review comments.
- Always include specific, actionable feedback — not vague suggestions.
- Keep review comments professional and constructive.
- If the user says "merge" or "looks good" without requesting changes, approve and merge.
- If the user says "request changes", submit the review with request-changes.

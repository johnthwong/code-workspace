---
name: git-workflow
description: Git and GitHub workflow conventions. Always follow these rules when working with branches, commits, and pull requests.
autoload: true
---

# Git & GitHub Workflow Rules

## Branches and Pull Requests

- **Start a new branch when the user requests a feature.** Before writing any code, create a branch named `feature/<name>`, where `<name>` is a short kebab-case description of the feature (e.g., `feature/csv-export`). Branch from `dev` or `development` if either exists, otherwise from `main` — not from whatever branch happens to be checked out. Pull the base branch first so the feature starts from current work. This applies to new functionality, not to bug fixes, refactors, or one-off edits.
- **Always push the branch before creating a PR based on it.** Never create a PR from a branch that only exists locally.
- Push to `upstream` if an upstream remote exists, otherwise push to `origin`.
- When creating a new branch for an issue, name it descriptively (e.g., `iss030-stubs-migration`).
- **Do not push unless explicitly asked.** Commit locally but let the user push themselves.
- **PR notation:** "PR base <- head" means create a PR merging `head` into `base`. E.g., "PR development <- feature/foo" means `--base development --head feature/foo`.
- **Link the issues a PR addresses.** Put the closing keywords at the top of the PR body, one per line — `Closes #347`. Keywords work in the PR body and in commit messages only; they do nothing in a PR comment or in the title. For an issue the PR only touches part of, write `Refs #<n>` instead, which links without closing.
  - GitHub only registers a keyword as a *linked issue* (the "Development" panel, `closingIssuesReferences`) when the PR's **base is the repository's default branch**. On a PR into `dev` or another integration branch the keyword records intent and produces a cross-reference in the issue timeline, but nothing auto-closes; the issue closes when the change reaches the default branch through a PR or commit message carrying the keyword. Check with `gh pr view <n> --json closingIssuesReferences` and say so rather than assuming the link took.

## Initializing Repositories

- When running `git init`, immediately create a `.gitignore` with at least `.DS_Store` before making the first commit.

## Commits

- **Always commit between prompts, even if the user did not explicitly request.** When you finish the work for a prompt and it leaves the working tree changed, commit those changes before yielding, so each prompt's work lands as its own commit. (Still never push unless explicitly asked.)
- Write clear commit messages with a summary line and body when needed.
- Include a `Co-Authored-By:` trailer for the model you are currently running as, unless told not to. Use that model's actual name and its provider's no-reply address (e.g. `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`, or the equivalent for a non-Anthropic model) — do not hardcode a single name or address.
- **Never amend past commits.** Always commit corrections as new commits.

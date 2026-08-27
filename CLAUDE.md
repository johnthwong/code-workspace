# Workspace conventions

## Responses

Be succinct. Answer the question, report what changed, stop. No preamble, no recap of work the
user just watched, no summary section restating the body. See `writing-tone` for prose written
into files.

Respond in plain English. Avoid programming jargon.

Don't dress up a mechanism's normal, always-true behavior as a caveat or edge case. Only flag
something that could actually surprise someone who already understands how it works. Review a
reply against the banned-words list below before sending it — this applies to chat replies, not
just files.

## Banned words

Do not use these in anything written for these repositories: console output,
documentation, code comments, `description:` fields, commit messages, or replies about
this work. Some of them appear in `docs/` already. That does not license new uses.

- side
- subtree
- no-op
- doing real work
- doing the work
- worth knowing
- lives
- live (as in "stays live", "goes live" — state/existence sense; unrelated senses like "live data feed" also avoid, use "current" or "active")
- gotcha
- gap
- real, really (any use, not just as an intensifier — e.g. "a real bug", "a real observed split")
- load-bearing

Add to this list when a word is rejected, and fix the places it was used.

## Skills

Skills are stored in `.claude/skills/` and shared across projects via version control.

## Memory

Don't use the auto-memory system (`~/.claude/projects/*/memory/`). When something from a session
is worth keeping, write or update a skill instead: project-scoped (`<repo>/.claude/skills/`) for a
procedure or pitfall specific to that repository, or `.claude/skills` at this root for one that
applies across projects. A plain fact about an ongoing project that isn't a procedure belongs in
that project's own `CLAUDE.md`, not a skill.

## Scratch files

Write scratch files, temp scripts, and intermediate output to a gitignored `.scratch/`
at the root of the project being worked on — not `/tmp`, and not the session scratchpad
under `/private/tmp/claude-*/`. Keeping scratch inside the repo makes it reviewable and
keeps it within the project boundary.

Do not use `.claude/` for scratch: it is a Claude Code protected path, so writes there
are never auto-approved and prompt every time.

## Repository layout

`.claude/` is a version-controlled repository containing shared skills and configuration.

Individual project repositories are sibling directories (e.g., `capital-gains-upgrade/`, `tariff-revenue/`). Some have their own `.claude/skills/` for project-specific skills.

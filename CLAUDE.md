# Workspace conventions

## Auto-load skills

Load `git-workflow`, `writing-tone`, and `r-style` immediately.

## Responses

See `writing-tone` skill for editorial standards.

Respond in plain English. Avoid programming jargon. Please remove all mannered prose.

Assume a 150-word limit for console responses.

Don't end a reply with a question. User can figure out what the next prompt is without leading reply.

If reply exceeds three sentences, launch an editor subagent before displaying to user. They should have access to this `CLAUDE.md` and the writing tone `writing-tone`.

## Banned words

Do not use these in anything written for these repositories: console output,
documentation, code comments, `description:` fields, commit messages, or replies about
this work.

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
- land, lands, landed (as in "the change lands", "once it lands")
- expose, exposes, exposed ("this feature is exposed to the UI as this menu")
- earn its keep, earns its keep
- carry its name

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

Root is a version-controlled repository containing across-repo Claude skills and configuration.

Individual project repositories are sibling directories (e.g., `capital-gains-upgrade/`, `tariff-revenue/`). Some have their own `.claude/skills/` for project-specific skills.

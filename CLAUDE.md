# Workspace conventions

## Responses

Run all replies by an editor subagent before displaying to user. See `writing-tone` for editorial standards.

Respond in plain English. Avoid programming jargon. Assume a 150-word limit for console responses.

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

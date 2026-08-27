---
name: write-skill
description: Create a new Claude Code skill. Use when the user asks to create, write, or add a skill.
disable-model-invocation: true
---

Create a skill for: $ARGUMENTS

## Skill structure

Each skill is a directory with a `SKILL.md` entrypoint:

```
.claude/skills/<skill-name>/
├── SKILL.md           # Required — instructions and frontmatter
├── template.md        # Optional — template for Claude to fill in
├── examples/          # Optional — example outputs
└── scripts/           # Optional — scripts Claude can execute
```

Skills live in one of these locations:
- `~/.claude/skills/<name>/` — personal, applies to all projects
- `.claude/skills/<name>/` — project-scoped, shared via version control

## Writing SKILL.md

Start with YAML frontmatter between `---` markers, then markdown body.

### Frontmatter fields

Only `description` is recommended. All others are optional.

```yaml
---
name: my-skill                    # Lowercase, hyphens, max 64 chars. Defaults to directory name.
description: What it does         # How Claude decides when to use it. Front-load the key use case.
when_to_use: Extra trigger hints  # Appended to description for matching. Combined cap: 1536 chars.
argument-hint: "[issue-number]"   # Shown during autocomplete.
disable-model-invocation: true    # Prevent Claude from auto-invoking. Use for side-effect workflows.
user-invocable: false             # Hide from /menu. Use for background knowledge only Claude loads.
allowed-tools: Bash(git *) Read   # Pre-approve tools so Claude doesn't prompt for each use.
context: fork                     # Run in a subagent (isolated context, no conversation history).
agent: Explore                    # Agent type when context: fork (Explore, Plan, etc.).
paths: "src/**/*.ts"              # Only activate when working with matching files.
---
```

### Body guidelines

- **Be specific and actionable.** Write numbered steps Claude can execute, not vague guidance.
- **Use `$ARGUMENTS`** for user input. `$0`, `$1` etc. for positional args.
- **Use `` !`command` ``** to inject dynamic context (runs before Claude sees the prompt).
- **Reference supporting files** from SKILL.md so Claude knows when to load them.
- **Keep it focused.** If a skill grows beyond ~200 lines, split into supporting files.

### Choosing invocation style

| Want | Set |
|---|---|
| Both user and Claude can invoke | (defaults) |
| Only user invokes (side effects like deploy, commit) | `disable-model-invocation: true` |
| Only Claude invokes (background knowledge) | `user-invocable: false` |

## Rules of thumb

- **Skill vs CLAUDE.md**: CLAUDE.md is for facts that apply every session (build commands, conventions). Skills are for multi-step procedures or reference material that loads on demand.
- **One concern per skill.** Don't bundle unrelated procedures.
- **Description is critical.** Claude uses it to decide relevance. Front-load the key verb and use case.
- **Test by invoking.** Type `/skill-name` to verify it loads and behaves as expected.

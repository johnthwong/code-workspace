---
name: prefer-libraries
description: Check for an installable library before hand-rolling a parser or utility. Use before writing any file-format reader, protocol decoder, or general-purpose helper — PDF/Excel/DOCX/HTML parsing, encoding or date conversion, compression, checksums.
when_to_use: Trigger when a task needs machinery that is not domain logic — extracting text from a PDF, reading a spreadsheet or archive, decoding a binary format, parsing HTML or dates. Also trigger when a CLI tool you reached for is missing (pdftotext, jq, pandoc), or when you are about to conclude that some capability is unavailable in this environment.
---

# Don't hand-roll what you can install

Writing a parser from scratch costs many turns of the user's compute and usually
produces subtly wrong output. Installing a library costs one command.

## Order of attack

1. **Already available?** One check, not a survey:
   `python3 -c "import pypdf"` / `Rscript -e 'requireNamespace("pdftools")'`.
2. **Install it.** Python: `python3 -m venv .scratch/venv && .scratch/venv/bin/pip install <pkg>`.
   R: `renv::install("<pkg>")`. Homebrew for CLI tools: `brew install poppler`.
3. **Only then hand-roll** — and say plainly in your response that you did, why,
   and what you cross-checked the output against.

## Test the environment, never infer it

Do not conclude that an install will fail from the sandbox config, an empty
`allowedHosts`, a missing CLI, or a previous unrelated failure. **Run the command
and read the error.** A failed `pip install` costs seconds; assuming failure and
writing your own parser costs the rest of the session. If a command does fail on
a sandbox restriction, retry it once with `dangerouslyDisableSandbox: true` and
mention `/sandbox` to the user.

## Where installs go

Scratch tooling for a one-off task belongs in the project's gitignored
`.scratch/` (`.scratch/venv`), not in the project's own environment. If the
dependency is part of the deliverable, add it properly — `renv::snapshot()` or
`requirements.txt` — per `init-r-project` / `init-python-project`.

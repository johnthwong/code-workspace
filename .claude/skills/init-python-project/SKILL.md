---
name: init-python-project
description: Initialize a Python project with a venv virtual environment. Use when setting up a new Python project or adding Python to an existing project.
allowed-tools: Bash(python3 *) Bash(pip *)
---

Initialize the Python virtual environment:

1. Run `python3 -m venv .venv` in the project root.
2. Activate with `source .venv/bin/activate`.
3. Install packages with `pip install <packages>`.
4. Freeze with `pip freeze > requirements.txt`.

Conventions:
- Add `/.venv/` to `.gitignore`.

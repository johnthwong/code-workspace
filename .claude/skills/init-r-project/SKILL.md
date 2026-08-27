---
name: init-r-project
description: Initialize an R project with renv for package management. Use when setting up a new R project or adding R to an existing project.
allowed-tools: Bash(Rscript *) Bash(R *)
---

Initialize the R project environment:

1. Run `Rscript -e 'renv::init(bare = TRUE)'` in the project root to create the renv lockfile and library without snapshotting.
2. Install required packages with `Rscript -e 'renv::install(c("package1", "package2"))'`.
3. Install jsonlite separately: `Rscript -e 'renv::install("jsonlite")'` and add it to the snapshot with `Rscript -e 'renv::record("jsonlite")'`.
4. After packages are working, snapshot with `Rscript -e 'renv::snapshot()'`.

Conventions:
- Always use `.r` for R file extensions, never `.R`.
- Add `/renv/` and `.Rprofile` to `.gitignore`.

---
name: r-style
description: Conventions for R code. Use when writing or editing R.
user-invocable: false
---

# Naming and structure in R

How comments should read is in [[writing-tone]].

## Name things clearly

Name things clearly: `find_hts_vintages`, `vintage_code`, `migration_date`, `data_window_start` are better than `backdate_hts`, `codes`, `moved_on`, `year_began`.

Every variable name is a noun phrase. `moved_on` reads as a verb. `migration_date` is the thing itself.

## Functions start with a verb

`get_`, `check_`, `read_`, `match_`, `find_`, `resolve_`, `report_`, `compute_`, `run_`. A function named for its result rather than its action reads like a variable at the call site.

## Predicates start with `is_`

`is_timely_migration`, `is_all_children_present`, `is_cached`, `is_omitted`. This holds for a logical vector as much as for a single value, so a mask over trade flows is `is_matched`, not `matched`.

## One named step per line

Give each intermediate result its own name rather than nesting the calls. `find_hts_vintages()` goes `matched_vintages`, then `vintages_children`, then `is_all_children_present`, then `eliminated_vintages`, then `vintages_to_add`.

## Put the branching in the data, not at the call site

Where an operation runs in two symmetric directions, build one lookup with a branch per direction and call one function twice with the key:

```r
lookup <- list(
  by_successor = list(vintage_code = ..., migration_date = ...),
  by_predecessor = list(vintage_code = ..., migration_date = ...)
)
recursive_match("by_successor")
recursive_match("by_predecessor")
```

Not two call sites that each pass in the behaviour they want.

## Use the tidyverse

`readr::read_csv` over `read.csv`, dplyr verbs and `across` over hand-rolled loops, `|>` and `%>%`, `\(x)` lambdas. Reach for `sapply` and `lengths` where they read plainly.

## End a function with `return()`

Explicit, not a bare last expression.

## Single-line comments
Put a comment chunk in one line. Assume the reader has a code editor with wrapping turned on.

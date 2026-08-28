---
name: r-style
description: Conventions for R code. Use when writing or editing R.
user-invocable: false
---

# Naming and structure in R

How comments should read is in [[writing-tone]].

## Keep it short

Two versions of the same crosswalk: `find_hts_vintages.r` is 112 lines with 3 functions and 9 comment lines. An earlier `backdate_hts.r` was 203 lines with 8 functions and 78 comment lines. The second is not more careful. It is harder to read.

`examples/find_hts_vintages.r` in this folder is the shorter one, kept whole so it can be read against these rules.

Default to fewer and larger functions. A helper earns a name of its own when it is called from more than one place, or when its body is long enough to lose the thread. A three-line helper called once is a detour, so put the lines where they run.

Do not write a comment block above every function. Most functions need no comment at all, because the name and the named steps inside already say what they do.

Comment where the reason cannot be recovered from the code, and give the domain reason rather than the mechanics. `find_hts_vintages` comments the split-and-merge problem and the two directions of the crosswalk, and nothing else.

Machinery nobody asked for is length too. Do not add a reporting path, a guard, or an option on the chance it is wanted.

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

## Indentation

Use 2-space indentation. Do not use hanging indent (i.e., do not align continuation lines to an opening parenthesis or bracket).

### Function definitions

When a function signature fits on one line, keep it on one line:

```r
add <- function(a, b) {
  a + b
}
```

When arguments don't fit on one line, put each argument on its own line indented by 2 spaces from the `function` keyword. The closing paren and opening brace go on the last argument line:

```r
compute_rate_change <- function(
  config_paths, forecast_start, forecast_end, trade_data, path_prefix,
  mfn_rates = NULL, decompose = FALSE, add_mfn = FALSE
) {
  forecast_dates <- seq(forecast_start, forecast_end, by = "day")
}
```

### Function calls

Same rule. Short calls stay on one line:

```r
result <- sparse_config(config_path, pd, pd, trade_data, path_prefix, mfn_rates)
```

When arguments don't fit, break them across lines indented by 2 spaces from the call:

```r
bea_derivations <- get_bea_derivations(
  demand_vector = demand_vector, level = level, model = model, io_year = io_year
)
```

### Pipes

Indent piped continuations by 2 spaces:

```r
df <- raw_data %>%
  filter(year == 2024) %>%
  mutate(rate = value / total)
```

### Control flow

Standard 2-space indent for bodies of `if`, `for`, `while`, etc.:

```r
for (d in seq_len(n_policy_dates)) {
  pd <- policy_dates[d]
  if (d < n_policy_dates) {
    row_end <- which(forecast_dates == policy_dates[d + 1]) - 1
  } else {
    row_end <- forecast_length
  }
}
```

### Lists

When writing named lists, use a single space around `=`. Do not vertically align the values:

```r
# Wrong
list(
  short        = 1,
  medium_name  = 2,
  very_long    = 3
)

# Right
list(
  short = 1,
  medium_name = 2,
  very_long = 3
)
```

The same applies to named arguments in function calls and definitions.

### What not to do

Do not align to the opening parenthesis:

```r
# Wrong
result <- some_function(arg1,
                        arg2,
                        arg3)

# Right
result <- some_function(
  arg1, arg2, arg3
)
```

Do not vertically align `=` signs across lines.


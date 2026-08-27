---
name: indent-r
description: R file indentation conventions. Use when writing or editing R code.
user-invocable: false
---

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

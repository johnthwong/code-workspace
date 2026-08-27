---
name: scf-codebook
description: Navigate and look up variables in the Survey of Consumer Finances codebook. Use when working with SCF data, verifying variable definitions, or building crosswalks.
user-invocable: false
---

## SCF codebook files

Codebook files follow the naming pattern `codebk{year}.txt` and are typically stored at `resource/scf/codebk{year}.txt`. The 2022 codebook is ~49,000 lines.

## Structure

The codebook has three main sections:

1. **Preamble** — survey methodology, changes from prior years, general notes
2. **Variable documentation** — the bulk of the file; each variable entry starts with `X{number}` at the beginning of a line, followed by the question text, response codes, and edit checks
3. **Variable index** — near the end of the file (~line 48,600+ for 2022); lists all variables in sequence

## Looking up variables

Search for a variable by its X-number at the start of a line:

```
grep "^X3918\b" codebk2022.txt
```

Use context lines to get the full description:

```
grep -B1 -A8 "^X3918\b" codebk2022.txt
```

### Multi-variable entries

Some variables that ask the same question across iterations share a single entry. The line begins with all variable numbers:

```
X3408(#1) X3412(#2) X3452(#3) X3416(#4) X3420(#5) X3428(#6)
```

The `(#N)` suffix indicates which iteration (e.g., business 1, business 2, etc.).

### Paired variables

Consecutive variable numbers often form pairs:
- Value / basis pairs: X3129 (net worth) / X3130 (cost basis)
- Gain / loss pairs: X3918 (gains) / X3920 (losses)
- Property pairs: X1706 (value) / X1709 (purchase price)

### Response codes

Within a variable entry, indented lines show response codes:

```
     1.    *Gain
     3.    *Neither gain nor loss
     5.    *Loss
     0.     Inap. (conditions...)
```

- Asterisked values (`*`) are substantive responses
- `0. Inap.` documents skip conditions (which prior variables cause this one to be inapplicable)
- Negative values like `-1` or `-2` are special codes (e.g., "virtually all")

### Inapplicability conditions

The `Inap.` text after `0.` documents which prior variable values make the current variable inapplicable. This is useful for tracing the survey flow:

```
0.     Inap. (no stocks: X3913^=1; no gain: X3916^=1)
```

Means: this variable is zero/inapplicable when X3913 ≠ 1 (no stocks) or X3916 ≠ 1 (no gain).

## Tips

- The codebook is large. Always use `grep` with line context rather than reading the whole file.
- To find all variables in a range, use a regex: `grep "^X3[4][0-2][0-9]\b" codebk2022.txt`
- Property ownership shares (X1705, X1805) are stored as basis points (divide by 10,000).
- The variable index at the end of the file lists variables in order across multiple lines, useful for finding nearby variables.

---
name: sync-param-csv
description: Sync parameter CSV changes across variant files (e.g., afa.csv → afa_revenue.csv, afa_expenditure.csv). Use when the user asks to duplicate, replicate, copy, or sync changes from one parameter CSV to other variant CSVs.
---

Sync uncommitted changes from a source parameter CSV to one or more target variant CSVs.

## Steps

1. Identify the source CSV and target CSVs. The user will specify or imply these. Common patterns:
   - `afa.csv` → `afa_revenue.csv`, `afa_expenditure.csv`
   - `baseline.csv` → variant CSVs in the same `Parameter/` directory
   - Any named CSV → other CSVs the user specifies

2. Run `git diff` on the source CSV to get the changed rows:
   ```bash
   cd <project-dir> && git --no-pager diff <path/to/source.csv>
   ```

3. Extract the row names (first comma-delimited field) of every changed line from the diff. **Ignore rows where the only difference is a trailing newline change** (this is a common artifact of editing CSVs in Excel). Only sync rows with actual value changes.

4. For each target CSV, replace each changed row by matching on the row name (first field). Use a script like:
   ```python
   python3 -c "
   with open('source.csv') as f:
       source = {line.split(',')[0]: line for line in f.read().splitlines()}

   changed_rows = [...]  # row names from the diff

   for target in ['target1.csv', 'target2.csv']:
       with open(target) as f:
           lines = f.read().splitlines()
       for i, line in enumerate(lines):
           name = line.split(',')[0]
           if name in changed_rows:
               lines[i] = source[name]
       with open(target, 'w') as f:
           f.write('\n'.join(lines) + '\n')
   "
   ```

5. Report which rows were updated in each target file.

## Special handling for `_expenditure` targets

When the target CSV has an `_expenditure` suffix (e.g., `afa_expenditure.csv`), an additional step is required. Each year in these CSVs has exactly two columns: baseline (left) and proposal (right). When the source diff contains changes to proposal columns, those changes may also need to be applied to the corresponding baseline columns (setting baseline = proposal value).

**Before applying changes to an `_expenditure` target, ask the user:**

> Should proposal changes also be applied to the baseline columns?

Offer these choices: **Yes** (all changed rows get baseline = proposal), **Some** (user specifies which variables), **None** (sync rows as-is from source).

If the user answers "Some", ask which specific variable names (row names) should receive the baseline = proposal treatment.

**Implementation:** For each selected row, after copying the row from the source, overwrite every baseline column (the left/odd-positioned data column in each year pair) with the value from the adjacent proposal column (the right/even-positioned data column). The year pairs start after the initial single-column years (which have identical baseline and proposal values). Identify where pairs begin by finding the first position where baseline ≠ proposal in the source row; all columns from that point onward are paired.

## Important notes

- Only sync rows that appear in the git diff — do not overwrite rows that haven't changed in the source.
- Match rows by their first field (the parameter name before the first comma). This is always unique within a parameter CSV.
- Preserve the target file's line endings and structure for all non-changed rows.
- If the user specifies only some target files, only update those. If unspecified, look for sibling CSVs with the same prefix (e.g., `afa_*.csv` alongside `afa.csv`).

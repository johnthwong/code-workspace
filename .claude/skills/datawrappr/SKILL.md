---
name: datawrappr
description: How to use the DatawRappr R package to create, update, and publish Datawrapper charts/tables. Use when working with Datawrapper visualizations in R.
user-invocable: true
---

## DatawRappr R Package

The `DatawRappr` package provides an R interface to the Datawrapper API for creating and managing charts, tables, and maps.

### Authentication

Store your API key once (persists in `.Renviron`):

```r
library(DatawRappr)
datawrapper_auth(api_key = "YOUR_API_KEY")
# Set overwrite = TRUE to replace an existing key
```

After this, all functions default to `api_key = "environment"` and read from `DW_KEY` in `.Renviron`.

### Core Workflow

1. **Create** a chart → returns a chart ID
2. **Upload data** to the chart
3. **Edit** chart metadata (title, source, axes, visualization options)
4. **Publish** the chart

### Creating Charts

```r
chart <- dw_create_chart(
  title = "My Chart Title",
  type = "tables",        # see Chart Types below
  folderId = "12345"      # optional, place in a folder
)
chart_id <- chart$id
```

### Chart Types

| Type string              | Visual           |
|--------------------------|------------------|
| `"d3-lines"`             | Line Chart       |
| `"d3-bars"`              | Bar Chart        |
| `"d3-bars-stacked"`      | Stacked Bars     |
| `"column-chart"`         | Column Chart     |
| `"stacked-column-chart"` | Stacked Columns  |
| `"d3-area"`              | Area Chart       |
| `"d3-scatter-plot"`      | Scatter Plot     |
| `"d3-pies"`              | Pie Chart        |
| `"d3-donuts"`            | Donut Chart      |
| `"tables"`               | Table            |
| `"d3-maps-choropleth"`   | Choropleth Map   |
| `"d3-maps-symbols"`      | Symbol Map       |
| `"locator-map"`          | Locator Map      |
| `"d3-dot-plot"`          | Dot Plot         |
| `"d3-range-plot"`        | Range Plot       |
| `"d3-arrow-plot"`        | Arrow Plot       |
| `"election-donut-chart"` | Election Donut   |

### Uploading Data

Pass a data frame directly:

```r
dw_data_to_chart(df, chart_id)
# Options:
#   parse_dates = TRUE   (default) converts Date/POSIX columns to character
#   format = "csv"       (default) or "tsv" for data with commas in strings
```

### Editing Charts

`dw_edit_chart()` modifies chart properties. You can set top-level fields and nested metadata lists:

```r
dw_edit_chart(
  chart_id,
  title = "New Title",
  intro = "Subtitle text",
  annotate = "Note below the chart",
  byline = "Author Name",
  source_name = "Data Source",
  source_url = "https://example.com",
  type = "d3-bars"
)
```

#### Nested metadata via lists

The Datawrapper API organizes chart properties under `metadata.visualize`, `metadata.describe`, `metadata.data`, and `metadata.publish`. Pass these as named lists:

```r
dw_edit_chart(
  chart_id,
  # Visualization settings (axes, ranges, colors, legends)
  visualize = list(
    `custom-range-y` = list("", "100"),
    `custom-range-x` = list("", "2026-12-31"),
    `color-category` = list(
      map = list(
        "Series A" = "#FF0000",
        "Series B" = "#0000FF"
      )
    ),
    legends = list(
      color = list(title = "Legend Title")
    ),
    `text-annotations` = list(
      list(position = list(x = "50", y = "2.5"), text = "Annotation")
    )
  ),
  # Description settings (source with HTML links)
  describe = list(
    `source-name` = '<a href="https://example.com">Source Name</a>'
  ),
  # Data settings
  data = list(
    transpose = TRUE
  )
)
```

### Retrieving Metadata

Inspect all stored properties of a chart:

```r
meta <- dw_retrieve_chart_metadata(chart_id)
meta$content$title
meta$content$type
meta$content$metadata$visualize
meta$content$metadata$describe
```

This is useful for discovering what properties exist before modifying them.

### Reading Data Back

```r
df <- dw_data_from_chart(chart_id)
```

### Publishing

```r
dw_publish_chart(chart_id)
# Options:
#   return_urls = TRUE     (default) prints iframe code and URL
#   return_object = TRUE   returns S3 object with publicUrl and iframeCode
```

**Important:** You must republish after editing for changes to appear on the live embed.

### Other Useful Functions

```r
dw_list_charts()                    # List all your charts
dw_list_folders()                   # List folders
dw_create_folder("Folder Name")    # Create a folder
dw_copy_chart(chart_id)            # Duplicate a chart
dw_delete_chart(chart_id)          # Delete a chart
dw_export_chart(chart_id, type = "png")  # Export as image
```

### Common Patterns

#### Update existing chart data and republish

```r
df <- read.csv("new_data.csv")
dw_data_to_chart(df, chart_id)
dw_edit_chart(chart_id, title = "Updated Title")
dw_publish_chart(chart_id)
```

#### Create a table from a data frame

```r
chart <- dw_create_chart(title = "My Table", type = "tables")
dw_data_to_chart(df, chart$id)
dw_publish_chart(chart$id)
```

#### Set y-axis max dynamically

```r
y_max <- ceiling(max(df$value) / 10) * 10
dw_edit_chart(chart_id, visualize = list(
  `custom-range` = list("", as.character(y_max))
))
```

#### Set per-column number format (e.g., 1 decimal place)

For **tables**, column display formatting is in `metadata.visualize.columns`:

```r
dw_edit_chart(chart_id, visualize = list(
  columns = list(
    `My Percentage Column` = list(format = "0.0"),
    `Another Column`       = list(format = "0,0.[00]")
  )
))
```

Common `format` values:
- `"0"` — integer (no decimals)
- `"0.0"` — 1 decimal place
- `"0.00"` — 2 decimal places
- `"0,0"` — integer with thousands separator
- `"0,0.0"` — 1 decimal with thousands separator

For **non-table charts**, per-column formatting uses `metadata.data.column-format`:

```r
dw_edit_chart(chart_id, data = list(
  `column-format` = list(
    `My Column` = list(type = "number", `number-format` = "0.0")
  )
))
```

#### Use HTML in source attribution

```r
linked_source <- '<a href="https://example.com/table">Model v2.0, Table T26-0010</a>'
dw_edit_chart(chart_id, describe = list(`source-name` = linked_source))
```

#### Table subheadings (section headers within a table)

In Datawrapper tables, a **subheading** is simply a data row where the first column contains a text string and the remaining columns are empty. Datawrapper renders these as section dividers within the table when `mergeEmptyCells` is enabled (see below).

To create subheadings programmatically, include them as rows in the data frame you upload:

```r
# Example: insert a subheading row into a data frame
subheading_row <- data.frame(
  category = "Percent of Families Eligible",
  value_a = "",
  value_b = "",
  stringsAsFactors = FALSE
)
names(subheading_row) <- names(df)
df <- rbind(df[1:6, ], subheading_row, df[7:nrow(df), ])
```

When parsing Excel files that have mid-table section headers (e.g., a row with text in only one cell like "Average Tax Burden (Credit)" or "Addendum"), extract those as rows with text in column 1 and empty strings in all other columns.

Combine with row styling (below) to make subheadings bold with border dividers, and enable `mergeEmptyCells = TRUE` so the text spans the full table width.

#### Table row styling (bold subheadings with divider lines)

Datawrapper tables use **two key systems** for row styling that work together:

1. **Numeric keys** (`"0"`, `"6"`, etc.) — set by the editor for bold, underline, borderTop
2. **`row-N` keys** (`"row-0"`, `"row-6"`, etc.) — set by "Customize rows" for borderBottom and full style objects

Both are needed for complete styling. Here's the pattern:

```r
# Section header: bold + underline + top border (numeric) + bottom border (row-N)
row_styles <- list(
  # Numeric key: bold + underline + top border
  `0` = list(
    style = list(bold = TRUE, underline = TRUE),
    borderTop = "1px",
    borderTopColor = "#333333"
  ),
  # row-N key: bottom border (full object required)
  `row-0` = list(
    style = list(bold = TRUE, italic = FALSE, fontSize = 1L, underline = FALSE),
    format = "0,0.[00]",
    moveTo = "top",
    sticky = FALSE,
    moveRow = FALSE,
    stickTo = "top",
    borderTop = "none",
    borderBottom = "1px",
    borderTopColor = "#333333",
    overrideFormat = FALSE,
    borderBottomColor = "#333333"
  ),
  # Minor subheading (like "Addendum"): bold + top border only
  `7` = list(
    style = list(bold = TRUE),
    borderTop = "1px",
    borderTopColor = "#333333"
  ),
  # Row before minor subheading: bottom border as divider
  `6` = list(
    borderBottom = "1px",
    borderBottomColor = "#333333"
  )
)

dw_edit_chart(chart_id, visualize = list(rows = row_styles))
```

**Important notes:**
- Stale `row-N` keys from previous runs can override numeric keys. Remove them by PATCHing with `null`:
  ```r
  httr::PATCH(url, body = '{"metadata":{"visualize":{"rows":{"row-5":null}}}}')
  ```
- The API deep-merges row styles — you cannot remove keys by omitting them, only by setting to `null`
- `row-N` keys require the full object with all fields (style, format, moveTo, sticky, etc.)

#### Merge empty cells (spanning subheadings in tables)

When a row has text only in column 1 and the rest are empty, enable `mergeEmptyCells` to make it visually span the full table width:

```r
dw_edit_chart(chart_id, visualize = list(mergeEmptyCells = TRUE))
```

#### Enable markdown in table cells

Allows `**bold**`, `*italic*`, and `[links](url)` in cell content:

```r
dw_edit_chart(chart_id, visualize = list(markdown = TRUE))
```

**Warning:** When markdown is enabled, lone `*` characters in data cells will be interpreted as italic markers and hidden. Escape them as `\*` in the data before upload, or avoid markdown and use row styling for bold subheadings instead.

#### Column alignment

Force right-alignment for columns that contain mixed text/numeric values (e.g., a numeric column with `*` footnote markers):

```r
dw_edit_chart(chart_id, visualize = list(
  columns = list(
    `My Column` = list(alignment = "right")
  )
))
```

#### Logo and branding

Control which logo appears on the chart. The `publish.blocks.logo` field works via `dw_edit_chart`, but `custom` metadata requires a raw API call:

```r
# Disable default (Urban Institute) logo
dw_edit_chart(chart_id,
  publish = list(blocks = list(logo = list(id = "main", enabled = FALSE)))
)

# Enable TPC logo via raw API (custom is NOT a valid dw_edit_chart parameter)
httr::PATCH(
  paste0("https://api.datawrapper.de/v3/charts/", chart_id),
  httr::add_headers(Authorization = paste("Bearer", Sys.getenv("DW_KEY"))),
  httr::content_type_json(),
  body = jsonlite::toJSON(list(metadata = list(custom = list(tpc = TRUE))), auto_unbox = TRUE)
)
```

#### Clearing manual cell edits

When someone edits cells in the Datawrapper UI, those changes are stored in `metadata.data.changes` and **override data uploaded via the API**. Even after calling `dw_data_to_chart()`, the manual edits persist on top of the new data.

To clear all manual edits so the uploaded data is shown as-is:

```r
httr::PATCH(
  paste0("https://api.datawrapper.de/v3/charts/", chart_id),
  httr::add_headers(Authorization = paste("Bearer", Sys.getenv("DW_KEY"))),
  httr::content_type_json(),
  body = jsonlite::toJSON(list(metadata = list(data = list(changes = list()))),
                          auto_unbox = TRUE)
)
```

**Best practice:** Always clear `metadata.data.changes` before uploading new data in automated scripts to prevent stale manual edits from overriding programmatic updates.

### Tips

- Chart IDs are 5-character alphanumeric strings (e.g., `"e1Iok"`)
- Use `dw_retrieve_chart_metadata()` to inspect structure before editing
- The `visualize` list structure mirrors the Datawrapper API JSON — check their docs for all available keys
- `dw_edit_chart()` is idempotent — re-running with the same values is safe
- Always call `dw_publish_chart()` after edits to push changes live

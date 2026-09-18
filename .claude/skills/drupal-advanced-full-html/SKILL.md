---
name: drupal-advanced-full-html
description: Convert a standalone styled HTML page (full document with head/script/sidebar nav) into a single self-contained fragment safe to paste into Drupal's "Advanced Full HTML" field. Use when the user wants an existing HTML page adapted for Drupal, WYSIWYG/CKEditor, or any CMS field that only accepts a body-level HTML snippet.
---

Convert a standalone HTML page into a Drupal "Advanced Full HTML"-compatible fragment.

## Output shape

- No `<!DOCTYPE>`, `<html>`, `<head>`, or `<body>` — Drupal only accepts the inner fragment.
- `<script>` **survives taxpolicycenter.org's "Advanced Full HTML" format** (confirmed on the
  tpcmodel-description pages). Don't assume it's stripped and design around the absence — other
  CMSes and other text formats do strip it, so ask which field the fragment is destined for before
  ruling JS out. Where it is unavailable, rebuild JS-driven interactivity (search filters,
  scrollspy, sidebar nav) as plain static markup, or drop it if it's not essential (confirm with
  the user before dropping content vs. just JS).
- Prefer JS that **degrades**: pair it with a CSS rule that keeps the page usable if the script
  never runs, which also covers browsers with JS disabled. In tpcmodel-description the sticky
  table-of-contents closes itself via a small listener, and a `:has([open])` rule widens
  `scroll-margin-top` to clear the panel if it doesn't.
- No external `<link>` tags (e.g. Google Fonts) — these get stripped outside a `<head>`. Rely on
  the site's default fonts instead (see Fonts section below).
- **`<img>` tags with `data:` URI `src` attributes are stripped.** Do not embed images as base64
  data URIs in `<img>` elements. If the image must be inline, create it via JS after page load
  (e.g., as an SVG `<image>` element) so Drupal's server-side filter never sees it — though even
  then, large base64 strings inside `<script>` can cause parsing problems. Prefer referencing
  images already hosted on the site.
- **`<figure>` and `<figcaption>` are stripped.** Use a `<div>` with a scoped class (e.g.,
  `.your-prefix-name .caption`) and apply caption styling with `!important` to override the
  theme's `<p>` font size.
- Wrap everything in **one uniquely-named wrapper `<div class="your-prefix-name">`** and scope
  every CSS selector under that class (e.g. `.your-prefix-name .chip`) so styles can't leak into
  or collide with the host site's global styles.
- Put the `<style>` block as the first child inside the wrapper div.

## Content fidelity

- If the user says "updated language is in the .md, make sure it uses that" — diff the `.md`
  against any JS/data-driven content in the old HTML (e.g. a `DATA` array driving rendered
  sections). Anything present in the old page's JS but absent from the `.md` (extra sections,
  per-item descriptions, etc.) should be **dropped**, not invented or carried over — ask the user
  to confirm if it's ambiguous whether to keep it.
- Drop decorative chrome the user doesn't want (sidebar nav, filter box, footer boilerplate,
  table/topic counts) explicitly rather than leaving it "just in case."

## Layout

- Container width: use `width:100%; max-width:<Npx>; margin:0 auto;` (not a fixed rem value) so
  the fragment scales proportionally with the viewport up to a hard cap — this is what "make it
  proportional with a hard max" means in practice.
- Don't cap inner text/paragraph width with `max-width:NNch` if the user wants copy and buttons to
  span the full container width — remove those cosmetic ch-caps.
- Pill/chip/button rows that should fill the row: use `flex:1 1 0` on each item so they grow to
  fill available width, **plus a `max-width` cap** (e.g. `9–11rem`) so a lone item in a short row
  doesn't stretch edge-to-edge.
- Watch for **duplicate separator lines** where two adjacent blocks each draw a border on their
  touching edge (e.g. `.masthead{border-bottom}` next to `.sec{border-top}`). Fix with a
  `:first-child`/`:last-child` selector to suppress one of the two.

## Fonts

- To make headings/body text inherit the site's default font (e.g. a client's brand font), do
  **not** set `font-family` on those elements at all — removing the declaration lets it inherit
  from the CMS theme.
- Keep `font-family` overrides only for intentionally distinct accent/label text (e.g. a monospace
  treatment for codes/IDs) — and remove those too if the user later asks to "get rid of the
  monospaced font" everywhere.

## Heading levels

- CMS themes often apply their own styling to heading levels (e.g. auto-uppercasing `<h3>`). If a
  section heading renders wrong (e.g. unwanted uppercase), don't fight it with CSS overrides alone
  — first try changing to a heading level the theme doesn't style that way (e.g. `<h4>`), keep a
  dedicated class for your own styling, and add an explicit safety-net override (e.g.
  `text-transform:none`) in case the new level is styled differently than expected.

## Colors

- Define semantic CSS custom properties up front (e.g. `--accent`, `--accent-deep` for text/hover,
  `--accent-soft` for tints) so future color-only change requests are single-line edits.
- When the user gives an **exact hex value** for "the accent color," set the primary token to that
  exact value — don't substitute a "close enough" shade. Derive lighter/darker variants
  programmatically (e.g. via a quick Python snippet blending toward white/black) only for
  secondary uses like hover fills or muted text, and double check every place that hex is *also*
  used unscoped (e.g. a hardcoded hex for a decorative bar) so all "accent color" pieces move
  together the next time it changes.
- If a fill/background is described as looking "too yellow" or off, check whether a *different*
  variable (e.g. a warm off-white/beige used for card backgrounds or borders) is contaminating the
  look — not just the primary accent variable.

## Validation before calling it done

- Confirm scoped selectors don't rely on ids/classes that collide with common site-wide names.
- Regex-count opening vs. closing tags for block-level elements after any `sed`/scripted edits —
  don't trust text substitutions blindly.
- Count expected repeatable elements (e.g. total link/chip count) against the source data to catch
  dropped or duplicated items.

## Workflow

- Iterate in small, single-purpose commits as the user gives incremental style feedback (one
  request → one commit), rather than batching unrelated tweaks. Follow the repo's commit
  conventions (see the `git-workflow` skill).

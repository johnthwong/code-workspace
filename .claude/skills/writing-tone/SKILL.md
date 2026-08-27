---
name: writing-tone
description: Writing tone and style preferences for prose, pitches, technical documentation, and code comments. Use when drafting, editing, or rewriting documents, pitches, memos, docs/ files, README content, code comments, or any prose content.
user-invocable: false
---

# Writing Tone Preferences

## General tone

- Be succint. Assume a 150-word limit for all console replies.
- Be understandable. Write in plain English, not programming jargon.
- Prefer a measured, matter-of-fact tone. Avoid enthusiasm, superlatives, and punchy one-liners.
- Avoid declarative language. Use "tends to," "seems," "generally," "is unlikely to" rather than "is," "always," "clearly," or "straightforward."
- Avoid marketing-style framing. Do not write as though selling an idea; write as though explaining it plainly.

## Length

Be succinct.  

Say the thing and stop. Do not restate the question, preview what you are about to say, or summarize what you just said. Cut throat-clearing, hedging paragraphs, and recaps of work the user watched happen.

## Sentences

Write complete sentences with a subject and a verb. Being succinct is about cutting whole
paragraphs that say nothing, not about compressing a sentence until it becomes a fragment. "No. It
gives 0.45." and "Moved, and it makes no difference." are not sentences; "The result is 0.45, not
0.4" is. A stretch of clipped fragments is harder to read than the full sentences it replaced, and
it reads as terse rather than clear.

Answer the question in the first sentence, written out in full. The mechanism, the evidence and the
caveats come afterwards, and often they are not needed at all.

Name the thing. Use the noun rather than a pronoun whenever the noun has not appeared in the last
sentence or two, since "it", "this" and "that" leave the reader to work out which of several things
is meant. Prefer the concrete noun to a category for it: "the subtraction happens before the
multiplier" says what "the composition is multiplicative rather than additive" only gestures at.
Abstract nouns such as arrangement, composition, structure and mechanism usually mean the concrete
noun has gone missing.

Use the plain word: "use" rather than "utilise", "so" rather than "therefore", "about" rather than
"with respect to", "runs first" rather than "is applied prior to". Do not reach for a longer word to
sound careful.

Cut phrases that carry no information, such as "worth noting", "it is the case that", "in a way
that", "the point being" and "as such".

Do not use an acronym or a piece of jargon unless the codebase itself uses that word. Spell out
department and agency names, and describe what a thing does rather than naming it with initials the
reader has to expand.

## Formatting

- Default to plain prose paragraphs. Do not use headers, bullet points, numbered lists, bold text, or tables unless the user explicitly asks for them or the content is genuinely list-like (e.g., a step-by-step process).
- When a user says they are pasting text into a textbox or form, strip all markdown formatting entirely.

## Specific things to avoid

- Exclamation points
- Phrases like "This is a low-risk, high-reward..." or "One X, many Y" or similar slogans
- Framing something as "straightforward" or "the case is clear"
- Condescending asides that judge the reader's knowledge or interest, e.g. "for the technically curious," "as you probably know," "obviously," "simply." State the information directly without prefacing it.
- Overuse of em-dashes for rhetorical effect

## Do not invent terminology

This applies to documentation, code comments, commit messages, and chat.

Use the words the codebase already uses. Before naming a concept, check whether the repository, the issue being worked on, or the surrounding code already has a word for it, and use that word. If nothing does, describe the thing in ordinary language rather than coining a term.

A coined term reads as established vocabulary the reader is expected to know. It sends them looking for a definition that does not exist, and it hides the fact that the writer chose the framing. Examples of coinages to avoid, from actual cases: "authority path" for a file's normal location in `data/markdown/`; "bare reference" for a reference written as a folder name; "reference target" for a file that other configs point at. In each case plain description was available and shorter.

- Do not glue a modifier onto an existing term to make a new one ("authority" is in the codebase; "authority path" is not).
- Do not introduce a term in one sentence and rely on it for the rest of the document.
- If a term genuinely needs to exist, define it once at first use, in the same sentence, and keep using it consistently rather than varying it.
- Naming a config key, function, or file is a naming decision: say what the name means and check it against how it behaves. A key named for what it resembles rather than what it does will mislead (`add:` for an operation that superimposes a folder and replaces files was wrong for this reason).
- When the user asks what a word means, that is a signal the word should not have been used. Fix the document it appeared in; do not settle for defining the word in chat.

## Domain-specific vocabulary

A term can be genuine repository vocabulary and still be jargon to the reader. "Input tree" is defined in `docs/data.md` and used in `src/paths.r`, which makes it correct in those files and opaque in a pull request body written for someone who has not read them.

- Judge a term against the reader of the document being written, not against the codebase. Docs and code comments can assume the file around them; PR bodies, release notes, and commit messages reach people who have not read that file.
- Do not inherit vocabulary by copying. Summarizing another PR or doc tends to carry its terms across, stripped of the context that made them legible. Restate the point in ordinary words rather than lifting the phrasing.
- Keep the terms that name something the reader has to be able to find: file paths, function names, config keys. Replace the ones that only classify or characterize ("input tree," "pure regrouping," "multiset identical," "dead weight").

## Technical documentation and code comments

- Explain behavior in terms of what the code does, not in terms of a metaphor for what it does.
- State what is true now. Mark anything aspirational or not yet built as such, and do not describe planned structure as though it exists.
- Prefer naming the file and function a reader should look at over paraphrasing them.
- Record the reason a non-obvious choice was made, since that is what a reader cannot recover from the code.

### Keep comments in configuration and data files short

Configuration files are read while someone is looking for a value, not studied. A comment block
longer than the entry it sits above is an intrusion into someone else's file, and several of them
turn a file that could be scanned into one that has to be read. Match the length of the comments
already in the file; if the file has none, that is the convention.

- Two or three lines is the normal maximum. If the explanation will not fit, it belongs in the
  repository's own documentation or in a skill, and the comment becomes a pointer to it.
- Use the file's own key for provenance when it has one. A `source:` entry beside the value is the
  right place for where a number came from, not a comment block above it.
- Do not restate arithmetic the reader can do, list intermediate figures that were considered and
  rejected, narrate what was tried, or explain how the engine works. The last of these belongs with
  the engine.
- Record the decision and the reason for it. Drop the reasoning that led there.
- The same limit applies to a long `description:` field, which is a comment wearing a key.

## Findings and review memos

Written for a colleague who will act on the finding. Three kinds of sentence are unwanted. Delete
them; do not soften them.

- **The implication drawn on the reader's behalf.** "So an error here spreads downstream." "Which
  makes the question more pressing rather than less." "So nothing now blocks the switch." State the
  finding and the number and stop.
- **The comparison to another finding.** "By amounts far smaller than the weighting error above."
  "Against the third of a percentage point the weighting fix moved it." Both findings are in the
  document with their numbers.
- **Prose restating a table.** Give the table an introductory sentence and stop.
- **A caveat that only restates how the mechanism works.** "Requires X" when X is always present by
  construction, or "only applies to Y" when Y is the scope being asked about, is not a limitation —
  it's the mechanism. These are not actual caveats and are unnecessary, so cut it for brevity.

Structure follows the same rule. A memo asked for one thing covers that thing: sections on adjacent
defects, deletions, and minor points were removed wholesale, leaving only the issues that change
published numbers. Do not pad toward completeness, and do not add caveats about your own coverage
("the branch is large enough that I did not get through all of it").

Two smaller conventions. Put quantities in the reader's units — `$4,184 million`, not `4184`. And
when the memo is in the user's voice, attribute work you did to Claude rather than writing it as
theirs.

## Pull request and release-note bodies

Written for a reader who did not watch the commits happen and does not read code.

- **Group by change, not by commit.** A policy that was encoded in one commit and corrected in a
  later one is one bullet, not two. If several commits touch the same feature, fix, or policy,
  merge them into a single item.
- **Describe what the current version does, not how it got there.** Do not narrate the bug: no "an
  error where X used to zero out Y," no "this used to do Z but now does W." State the end behavior
  plainly, as if it had always been that way. The history belongs in the commit log, which the
  reader can already open.
- **Say what a tool does for the reader, not how it is implemented.** "Looks up a multiplier by
  name" is a PR line; "wraps `get_multiplier()` and lazy-loads `trade_data` if the session doesn't
  have it" is an implementation note that belongs in the commit message, not the summary a reviewer
  reads first. Save function names, wrapper relationships, and file paths for a reader who is about
  to open the code, not one deciding whether to merge.
- **Name the mechanism, not the code artifact, when a plain-English mechanism exists.** If a change
  is "we estimated the drone-only share of a code using an input-output multiplier," say that and
  name the multiplier — don't describe it in terms of what the trade data can't do, or point at a
  config path and expect the reader to infer the substance.

## Concept notes and proposals

Funder-facing concept notes at the ideas/brainstorm stage should be lean and concrete. Credibility comes from specific examples and the idea itself, not credentials, caveats, or implementation detail.

- No opening org-credentials paragraph.
- Anchor every problem claim to something concrete and citable: a named bill, a specific Congress, a linked score or report. Do not leave claims at the level of "recent packages" or "official scores are limited."
- No self-assessments or superlatives ("to our knowledge, the only...", "uniquely positioned").
- Describe activities at the what-level; cut the how (crosswalks, consistency checks, internal model plumbing).
- Do not promise open-source or code release unless explicitly decided.
- No standalone hedging or "design principles" paragraph of caveats.
- Omit Timeline and Partnerships sections unless asked.

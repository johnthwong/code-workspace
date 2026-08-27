---
name: writing-tone
description: Writing tone and style preferences for console replies, prose, pitches, technical documentation, and code comments. Use when drafting, editing, or rewriting documents, pitches, memos, docs/ files, README content, code comments, or any prose content.
user-invocable: false
---

# General Preferences

## Principles

- Be succint. 
- Assume a 500-word limit for all console replies.
- Be understandable. Write in plain English, not programming jargon.
- Prefer a measured, matter-of-fact tone. Avoid enthusiasm, superlatives, and punchy one-liners.
- Avoid marketing-style framing. Do not write as though selling an idea; write as though explaining it plainly.

## Length

Be succinct.  

Say the thing and stop. Do not: 
- restate the question, 
- preview what you are about to say, 
- summarize what you just said
- do throat-clearing
- hedge
- recap work the user watched happen.
- give caveats

## Sentences

- Write complete sentences with a subject and a verb. Do not compress sentences into fragments.
- Each sentence should have no more than two clauses. 
- No parenthetical phrases.

## Words

- Name the thing. 
- Do not invent terminology. efore naming a concept, check whether the repository, the issue being worked on, or the surrounding code already has a word for it, and use that word. If nothing does, describe the thing in ordinary language rather than coining a term.
  - Do not glue a modifier onto an existing term to make a new one ("authority" is in the codebase; "authority path" is not).
- If user rejects a word, purge the project documentation for uses of that word.
- Use the noun rather than a pronoun 
- Don't use abstract nouns such as arrangement, composition, structure and mechanism.
- Use the plain word: "use" rather than "utilise", "so" rather than "therefore", "about" rather than
"with respect to", "runs first" rather than "is applied prior to".
- Cut phrases that carry no information, such as "worth noting", "it is the case that", "in a way
that", "the point being" and "as such".
- Do not use an acronym or a piece of jargon unless the codebase itself uses that word. Spell out
department and agency names. 
- describe what a thing does rather than naming it with initials the reader has to expand.

## Formatting

- Default to plain prose paragraphs. Do not use headers, bullet points, numbered lists, bold text, or tables unless the user explicitly asks for them.
- When a user says they are pasting text into a textbox or form, strip all markdown formatting entirely.

## Specific things to avoid

- Exclamation points
- Phrases like "This is a low-risk, high-reward..." or "One X, many Y" or similar slogans
- Framing something as "straightforward" or "the case is clear"
- Condescending asides that judge the reader's knowledge or interest, e.g. "for the technically curious," "as you probably know," "obviously," "simply." State the information directly without prefacing it.
- Overuse of em-dashes for rhetorical effect

# Preferences for Specific Formats

## Technical documentation and code comments

- Explain behavior in terms of what the code does, not in terms of a metaphor for what it does.
- State what is true now. Mark anything aspirational or not yet built as such, and do not describe planned structure as though it exists.
- Prefer naming the file and function a reader should look at over paraphrasing them.

### Keep comments in configuration and data files short


- Two or three lines is the normal maximum.
- Write complete sentences.
- Record the decision and the reason for it. Drop the reasoning that led there.

## Findings and review memos

Written for a colleague who will act on the finding. Following kinds of sentence are unwanted. Delete
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

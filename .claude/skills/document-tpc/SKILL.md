---
name: document-tpc
description: Write documentation in TPC style. Use when writing or editing README files, technical documentation, or model descriptions for TPC projects.
disable-model-invocation: true
---

Write documentation for: $ARGUMENTS

Follow the style rules below and match the tone of the example in `examples/tpc-model-overview.md`.

## Style rules

- Use direct, technical language without embellishments
- Avoid phrases like "embodies a key insight", "proves central to", "this is the critical matrix", "reveals important patterns", or "proves valuable"
- State facts directly without emphasizing their importance
- Focus on what things are and what they do, not on their significance or value
- Remove qualifiers like "important", "key", "critical", "essential" unless absolutely necessary for accuracy
- Avoid explanatory, pedagogical tone:
  - Do NOT use "We are asking", "Consider X as an example", "Let us examine", "To understand how"
  - Do NOT use "what we term", "what we call" — just state what things are
  - Do NOT use phrases like "for instance", "for example" to introduce examples
  - Do NOT use constructions like "The mathematical mechanics are less important than..."
- Use formal, declarative sentences — state what is done, not how to understand it
- Avoid first-person plural "we" where possible — use passive voice or state facts directly

## Accuracy rules

- Do NOT make assumptions about technical details, data sources, or numbers without verification
- Do NOT infer relationships between components or processes unless explicitly stated or verified in code
- Do NOT make claims about:
  - Specific data sources (e.g., which agency provides data) without checking
  - Numerical values (e.g., number of flows, records) without verification
  - How components interact (e.g., whether values are added, multiplied, or processed separately)
  - Technical processes or algorithms without examining the actual implementation
- When uncertain about technical details, either:
  - Read the relevant code to verify
  - Omit the specific claim and state only what is known
  - State the fact at a higher level of abstraction without false specifics
- It is better to be less specific and correct than to be specific and wrong
- For statistics or numbers that are uncertain, use placeholder value "XX" consistently throughout the document (e.g., "approximately XX flows", "XX source files")
  - Use the same placeholder (XX) for all uncertain values so they can be searched and replaced all at once
  - Do NOT make up specific numbers or estimates

## Conciseness and scope

- Keep documentation focused and concise — aim for ~120–150 lines for technical READMEs, not 200+
- Do NOT repeat the same piece of information in multiple places
- Remove entire sections that are overly detailed or not central to understanding:
  - Detailed validation procedures (keep only core testing)
  - Extensive output format discussions
  - Detailed file structure descriptions beyond main entry points
  - Shared definitions and ancillary data structures
- Simplify descriptions:
  - Remove directory paths unless essential
  - Remove file size calculations and specific numeric projections
  - Remove format specifications like "ISO 8601 format (YYYY-MM-DD)" — just say "YYYY-MM-DD format"
  - Remove adjectives that don't add information
- Focus on WHAT the system does, not:
  - WHY it does it that way
  - HOW it benefits users
  - What it enables or facilitates
  - Implications and downstream effects
- Remove explanatory constructions:
  - "This enables..." / "This allows..." / "This facilitates..."
  - Explanations of benefits or advantages
- Keep technical descriptions direct:
  - State what happens, not what it makes possible
  - Describe the process, not its implications
  - Focus on mechanics, not use cases


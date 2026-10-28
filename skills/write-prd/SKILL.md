---
name: write-prd
description: Guide the user in writing a mini Product Requirement Document (PRD) for a feature or epic. Covers target persona, objective, success metrics, problem statement, key capabilities, business rules, definition of done, test criteria, UI/UX, and data/integration needs. Use when writing a PRD, feature brief, epic description, or documenting how a feature should work for development, design, and QA.
license: MIT
compatibility: Compatible with all agents adhering to the Agent Skills specification (Claude Code, Cursor, OpenCode, GitHub Copilot, Codex, etc.)
metadata:
  author: open-skills
  version: "1.0.0"
  category: product-management
parameters:
  - name: detailed_mode
    type: string
    enum: ["less", "normal", "fully"]
    default: "less"
    description: Controls PRD verbosity. "less" = requested mini PRD, "normal" = adds assumptions, edge cases, UI states, and data contracts, "fully" = adds risks, rollout, analytics, non-functional requirements, traceability, and sign-off.
---

# Skill: PRD Feature Brief Generator

Guide the user to create a structured Product Feature Brief (or PRD mini)
that balances business value with technical logic for development, design,
and QA teams.

## Summary

This skill turns a raw feature idea into a Vietnamese-first mini PRD at
epic and feature scope. It separates business intent from implementation,
makes success and acceptance measurable, and stops at capabilities so the
next step can break work into tasks without re-reading the whole product
context.

## When to Use

Trigger this skill when the user asks to:

- Write a PRD, feature description, or epic.
- Document a product feature for developers or designers.
- Describe how a specific functionality should work, including its
  acceptance criteria.
- Break a large feature into smaller, actionable capabilities.

## Quick Reference

| Mode | Template | Adds |
| ---- | -------- | ---- |
| `less` | [assets/prd-template-less.md](assets/prd-template-less.md) | Requested mini PRD: epic overview, features, UI/UX, data, handoff |
| `normal` | [assets/prd-template-normal.md](assets/prd-template-normal.md) | Assumptions, open questions, priorities, edge cases, full UI states, data mapping and failure behavior |
| `fully` | [assets/prd-template-fully.md](assets/prd-template-fully.md) | Risks, rollout/rollback, analytics, NFRs, traceability, sign-off |

- Default output path: `docs/prd/<slug>.md`.
- Default language: Vietnamese, with bilingual headings.
- Reference documents: [references/prd-structure.md](references/prd-structure.md),
  [references/capability-decomposition.md](references/capability-decomposition.md),
  [references/quality-checklist.md](references/quality-checklist.md).

## Core Rules

1. **Stop at capability.** A capability is user-visible behavior plus its
   rules. Never add tasks, estimates, branches, pull requests, or
   implementation file paths.
2. **Never invent facts.** If a persona, metric, threshold, or integration
   is unknown, record an assumption or `TBD (owner: <role>)`.
3. **Ask at most two clarifying questions** in one turn, and only when the
   answer changes the PRD. Otherwise draft with labeled assumptions.
4. **Use Vietnamese by default.** Match another language only when the user
   asks for it.
5. **Ask for the filename before writing.** Show the full Markdown draft
   first, then ask for corrections and the target filename in the same
   turn.
6. **NEVER overwrite an existing file without explicit confirmation.**
   A repeated path or "lưu lại" is not confirmation. Ask a separate
   yes/no question and wait for the next user turn; offer to rename
   instead.
7. **Use only the selected level's template.** Do not silently upgrade or
   downgrade `detailed_mode`.
8. **Keep level integrity.** `normal` contains every `less` section;
   `fully` contains every `normal` section, in the same order.

## Execution Workflow

1. **Select the mode.** Resolve `detailed_mode` with the rules below, then
   read only the matching template from `assets/`.
2. **Analyze the request.** Identify the epic, its users, and the change in
   behavior. If the persona or the success metric is missing and the answer
   would change the PRD, ask at most two questions. At `less`, record
   assumptions and `TBD` values inline; at `normal` and `fully`, use the
   Assumptions and Open Questions sections.
3. **Draft the epic overview.** Fill epic name, target persona, core
   objective, success metrics, and out of scope. Metrics need a baseline or
   target, a timeframe, and a measurement source; mark unknown pieces
   `TBD (owner: <role>)`.
4. **Decompose into features and capabilities.** Apply
   `references/capability-decomposition.md`. Aim for one to five features
   per epic and two to five capabilities per feature. Slice vertically by
   user journey, role, or user-visible state.
5. **Fill the template.** Use only the selected level's sections. Every
   capability gets at least one concrete example. At `fully`, each
   capability also gets an error, a permission, and a limit example, and
   business rules include audit rules. Business rules name conditions,
   precedence, limits, permissions, and failure behavior. When an epic has
   more than one feature, group UI/UX and Data & Integration content under
   `### F0x - <Feature Name>`; with one feature, keep the sample shape
   without that subheading.
6. **Self-check.** Run `references/quality-checklist.md`. Fix what can be
   fixed; record anything blocked by missing information as an assumption
   or open question.
7. **Review with the user.** Show the full Markdown draft in chat, then ask
   for corrections and the target filename in the same turn.
8. **Write the file.** Follow the filename and write-safety rules below.
   Write only after the user has named the file.
9. **Close.** Report the written path, a three-to-five line summary, and
   the handoff line. Do not generate tasks or estimates.

## Mode Selection

1. An explicit `detailed_mode` parameter wins.
2. "PRD mini", "brief", or "ngắn gọn" selects `less`.
3. "Detailed" or "comprehensive" selects `fully`.
4. Otherwise select `less` and state the selected level in one line.

Never silently upgrade a level.

## Filename and Write Safety

- Ask: `Lưu PRD vào file nào? Gợi ý: docs/prd/<slug>.md`.
- A bare name such as `checkout-v2` resolves to
  `docs/prd/checkout-v2.md`.
- Append `.md` when the chosen path has no extension; keep an explicit
  extension otherwise.
- Create missing parent directories, then write with the file tool.
- If the target exists, ask whether to overwrite or choose another name.
  Replace it only after an explicit yes in the next user turn. A filename
  in the request, a repeated save command, or "lưu lại" is not overwrite
  confirmation; ask a separate yes/no question and wait.
- If the user wants to see the PRD without a file, print the Markdown and
  skip writing.
- Slug rule: lowercase ASCII, words joined by hyphens, no dates, at most 60
  characters; derive it from the epic name and let the user override.

## Gotchas

- **Vague capabilities:** "improve refunds" is not testable. Name the
  behavior and add a concrete example.
- **Untestable acceptance:** "looks good" and "works well" fail the
  checklist. Use `condition -> observable result`.
- **Over-engineering:** do not add sections, integrations, or edge cases
  the selected level does not ask for.
- **Level drift:** a higher level that drops a lower-level heading is a
  defect, not a simplification.
- **Implementation leakage:** "create table", "build endpoint", and
  "refactor service" belong to task breakdown, not the PRD.

## References

- [references/prd-structure.md](references/prd-structure.md) - what each
  section must prove, prompts to ask, good examples, and common mistakes.
- [references/capability-decomposition.md](references/capability-decomposition.md) -
  Epic/Feature/Capability/Task boundary, vertical slicing, naming, examples,
  and anti-patterns.
- [references/quality-checklist.md](references/quality-checklist.md) - the
  pre-output gate with pass conditions.
- [assets/prd-template-less.md](assets/prd-template-less.md) - mini PRD
  template.
- [assets/prd-template-normal.md](assets/prd-template-normal.md) - standard
  template.
- [assets/prd-template-fully.md](assets/prd-template-fully.md) -
  comprehensive template.

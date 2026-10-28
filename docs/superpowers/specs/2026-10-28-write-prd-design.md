# write-prd: mini PRD skill with three detail levels

## Intent

Give agents a repeatable way to turn a raw feature idea into a mini
Product Requirement Document (PRD) at epic/feature level. The document
must be usable by product, design, development, and QA without becoming
an implementation plan: it describes behavior, business rules, outcomes,
and testable acceptance criteria, then hands task breakdown to
`kanban-task-breakdown`.

Output is Vietnamese by default, with the bilingual headings from the
requested sample. The skill mirrors `kanban-task-breakdown`'s
`detailed_mode` parameter so users get the same three verbosity levels:
`less` (the requested mini PRD), `normal`, and `fully`.

## Goals

- Add a new Agent Skills package at `skills/write-prd/` containing
  `SKILL.md`, three copy-paste templates, and three reference documents.
- Make `less` reproduce the requested outline: epic overview, per-feature
  objective/problem/capabilities/business rules/DoD/test criteria,
  UI/UX placement/interactions/states, and data/integration needs.
- Keep every level at feature/capability scope. No tasks, estimates,
  branches, PRs, file paths, or implementation steps.
- Ask for a filename before writing, default to
  `docs/prd/<slug>.md`, never overwrite an existing file without
  confirmation, and report the written path plus a handoff line.
- Register the skill in `.skills.json`, `README.md`, and `CHANGELOG.md`
  so installation, discovery, and release notes stay consistent.
- Pass the repository's existing Markdown lint and skill validation
  checks without adding new CI jobs or scripts.

## Non-goals

- Breaking an epic into tasks, estimating hours, or creating Kanban
  tickets. That stays in `kanban-task-breakdown`.
- Generating code, API specifications, database schemas, wireframes, or
  design files. The PRD names needs, not solutions.
- Adding file-writing behavior to `kanban-task-breakdown` or
  `design-thinking`. That is a separate change, agreed to be handled
  later.
- New CI checks, template-rendering tests, or validation scripts.
- A web/visual companion or an HTML output.
- Multi-document PRD sets, versioned PRDs, or approval workflows beyond
  a review-and-write turn.

## Anti-goals

- A PRD whose capabilities read like engineering tasks ("create table",
  "build endpoint", "refactor service").
- Vague capability descriptions without a concrete example.
- Acceptance criteria that cannot be verified ("looks good", "works
  well", "user-friendly").
- Silently inventing a persona, metric, or integration that the user
  never supplied.
- Writing a file without asking for its name first, or overwriting one
  without confirmation.
- Level drift where `normal` drops a `less` section or `fully` drops a
  `normal` section.
- English output when the user is working in Vietnamese, unless they ask
  for another language.

## Constraints

- Repository conventions: `SKILL.md` frontmatter must include `name`,
  `description`, `license`, `metadata`, and `metadata.version` (main's CI
  checks for `version:`); `parameters` is already used by
  `kanban-task-breakdown`; supporting material lives in `assets/` and
  `references/`. This skill declares `1.0.0`.
- CI requires every `skills/*/` directory to have an entry in
  `.skills.json`, and every Markdown link in `SKILL.md` to resolve
  relative to the skill directory.
- Markdownlint runs over all Markdown. Line length, duplicate headings,
  inline HTML, bare URLs, first-line heading, and table style checks are
  disabled; other default rules still apply.
- `.skills.json` is at `1.2.0`. The release process keeps new work under
  `[Unreleased]` and bumps the version when cutting a release, so this
  change does not bump the version or create a tag.
- `docs/prd/` does not exist yet; the skill creates it when needed.
- Output language defaults to Vietnamese. Templates use bilingual
  headings (`Tên cụm tính năng (Epic Name)`) as in the requested sample.
- No runtime dependencies, scripts, or network access.

## Approaches

**A. Mirrored package with per-level templates (chosen).** A short
`SKILL.md`, three `assets/prd-template-*.md` files selected by
`detailed_mode`, and `references/` for structure guidance, capability
decomposition, and a quality checklist. Matches `kanban-task-breakdown`,
keeps the loaded context proportional to the selected level, and gives
users copy-paste templates.

**B. Single `SKILL.md` with all three levels inline.** Fewer files and
easy to copy, but the agent loads all levels even when using one, the
`fully` guidance makes the file large, and there are no standalone
templates.

**C. Package plus a validation script.** Like A, with a script that
checks required headings and leftover placeholders. Stronger format
guarantees, but adds a runtime dependency and maintenance for a
guidance-only skill; only justified if PRDs are generated in CI.

A is chosen. Capability decomposition uses vertical slices (user
journey, role, or user-visible state), not technical layers. Layer-based
splitting (database, service, API, UI) belongs to the task level and
would pull the PRD into implementation detail.

## Design

### Package layout

```text
skills/write-prd/
├── SKILL.md
├── references/
│   ├── prd-structure.md
│   ├── capability-decomposition.md
│   └── quality-checklist.md
└── assets/
    ├── prd-template-less.md
    ├── prd-template-normal.md
    └── prd-template-fully.md
```

### Frontmatter

```yaml
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
```

### Mode selection

1. An explicit `detailed_mode` parameter wins.
2. If the user asks for a "PRD mini", "brief", or "ngắn gọn", use
   `less`.
3. If the user asks for a detailed or comprehensive PRD, use `fully`.
4. Otherwise use `less` and state the selected level in one line. Never
   silently upgrade a level.

### Required sections by level

Higher levels are strict supersets. Section names and order are shared;
only the contents grow.

| Section | less | normal | fully |
| ------- | ---- | ------ | ----- |
| Epic name, target persona, core objective, success metrics | Yes | Yes | Yes |
| Epic out of scope | 1-3 bullets | With rationale | With rationale and affected personas |
| Assumptions and dependencies | No | Yes | Yes |
| Open questions | No | Yes | Yes, with owner and blocking status |
| Risks and mitigations | No | No | Yes |
| Rollout, feature flag, rollback | No | No | Yes |
| Analytics events | No | No | Yes |
| Non-functional requirements | No | No | Yes: performance, security, privacy, accessibility |
| Traceability matrix (capability to metric/DoD) | No | No | Yes |
| Sign-off (product, design, engineering, QA) | No | No | Yes |
| Feature objective, problem statement, key capabilities | Yes | Yes | Yes |
| Concrete example per capability | 1 each | Multiple, including edge cases | Multiple, including errors, permissions, limits |
| Business rules | Yes | Yes, with precedence and failures | Yes, with precedence, failures, and audit rules |
| Feature out of scope | No | Yes | Yes |
| Feature priority and dependencies | No | Yes | Yes |
| Definition of Done checklist | Yes | Yes | Yes |
| Test/measurable criteria | Happy path plus one error/edge | Happy, edge, error, permission | Full matrix incl. limits and recovery |
| UI placement, core interactions, loading/empty/error states | Yes | Yes | Yes |
| UI success, disabled, permission-denied, responsive, copy | No | Yes | Yes |
| UI accessibility, keyboard, i18n, design references | No | No | Yes |
| Data inputs and third-party APIs | Yes | Yes | Yes |
| Data mapping, contracts, failure behavior | No | Yes | Yes |
| Retention, privacy, volume, latency, observability | No | No | Yes |
| Handoff line to `kanban-task-breakdown` | Yes | Yes | Yes |

### Section order and placement

The matrix is a completeness checklist, not a document order. Templates
use this order, with higher-level sections inserted where they belong:

1. Epic Overview (name, persona, objective, success metrics, out of
   scope).
2. Assumptions & Dependencies (`normal`, `fully`).
3. Open Questions (`normal`, `fully`).
4. Features, each in the order: objective, problem statement, priority
   and dependencies (`normal`, `fully`), key capabilities, business
   rules, feature out of scope (`normal`, `fully`), outcomes and
   acceptance.
5. UI/UX.
6. Data & Integration.
7. Risks & Mitigations (`fully`).
8. Rollout & Rollback (`fully`).
9. Analytics Events (`fully`).
10. Non-functional Requirements (`fully`).
11. Traceability Matrix (`fully`).
12. Sign-off (`fully`).
13. Handoff.

At `less`, assumptions and unknown values stay inline in the affected
bullet, written as `Giả định: ...` or `TBD (owner: <role>)`; `less` gets
no extra section. At `normal` and `fully`, the Assumptions and Open
Questions sections are canonical and inline duplication is avoided.

UI/UX and Data & Integration are epic-wide sections in every level. When
an epic has more than one feature, their contents are grouped under
`### F0x - <Feature Name>` subheadings; with a single feature the sample
shape (no subheading) is kept.

### Bilingual heading vocabulary

The sample fixes the `less` headings. New `normal`/`fully` sections use
these pairs, and the same pair is reused everywhere:

| English | Vietnamese-first heading |
| ------- | ------------------------ |
| Assumptions & Dependencies | Giả định & Phụ thuộc |
| Open Questions | Câu hỏi mở |
| Priority & Dependencies | Ưu tiên & Phụ thuộc |
| Feature Out of Scope | Ngoài phạm vi tính năng |
| Data Mapping | Ánh xạ dữ liệu |
| Integration Contracts | Hợp đồng tích hợp |
| Failure Behavior | Xử lý lỗi |
| Retention & Privacy | Lưu trữ & Quyền riêng tư |
| Volume & Latency | Khối lượng & Hiệu năng |
| Observability | Giám sát |
| Risks & Mitigations | Rủi ro & Giảm thiểu |
| Rollout & Rollback | Triển khai & Rollback |
| Analytics Events | Sự kiện phân tích |
| Non-functional Requirements | Yêu cầu phi chức năng |
| Traceability Matrix | Ma trận truy vết |
| Sign-off | Phê duyệt |

Format is `## <Vietnamese> (<English>)` for top-level sections and
`**<Vietnamese> (<English>):**` for fields. `UI/UX`, `Definition of
Done`, and `Handoff` keep the sample's original treatment.

### Template shape for `less`

The `less` template follows the requested sample:

```markdown
# PRD: <Epic Name>

## Tổng quan Epic (Epic Overview)

- **Tên cụm tính năng (Epic Name):**
- **Đối tượng sử dụng (Target Persona):**
- **Mục tiêu cốt lõi (Core Objective):**
- **Tiêu chí thành công (Success Metrics):**
- **Ngoài phạm vi (Out of Scope):**

## Tính năng (Features)

### F01 - <Feature Name>

- **Mục tiêu (Objective):**
- **Vấn đề giải quyết (Problem Statement):**
- **Chi tiết năng lực (Key Capabilities):**
  - **C01 - <Capability Name>:** <Behavior>
    - *Ví dụ thực tế (Real-world example):* <Concrete scenario>
- **Quy tắc / Logic nghiệp vụ (Business Rules):**
- **Kết quả nghiệm thu (Outcomes & Acceptance):**
  - **Definition of Done:**
    - [ ] <Verifiable deliverable>
  - **Tiêu chí kiểm thử (Test / Measurable Criteria):**
    - [ ] <Input or condition> -> <Expected observable result>

## UI/UX

- **Vị trí hiển thị (Placement):**
- **Tương tác cốt lõi (Core Interactions):**
- **Trạng thái (States):** Loading / Empty / Error

## Dữ liệu & Tích hợp (Data & Integration)

- **Dữ liệu đầu vào (Inputs):**
- **Tích hợp bên thứ ba (APIs):**

## Bàn giao (Handoff)

- Breakdown công việc: dùng skill `kanban-task-breakdown`.
```

`normal` adds its sections in the same order; `fully` adds its sections
on top of `normal`. No level renames a shared heading.

### SKILL.md workflow

1. **Select mode.** Resolve `detailed_mode` as described above and read
   only the matching template from `assets/`.
2. **Analyze the request.** Identify the epic, its users, and the change
   in behavior. If the persona or the success metric is missing and the
   answer would change the PRD, ask at most two questions in one turn.
   If the user cannot answer, record a labeled assumption or `TBD`; do
   not invent facts. At `less`, record it inline; at `normal`/`fully`,
   use the Assumptions and Open Questions sections.
3. **Draft the epic overview.** Fill epic name, persona, objective,
   success metrics, and out-of-scope. Metrics must have a baseline or
   target, a timeframe, and a measurement source; mark unknown pieces
   `TBD (owner: <role>)`.
4. **Decompose into features and capabilities.** Apply
   `references/capability-decomposition.md`. Aim for one to five
   features per epic and two to five capabilities per feature. A
   capability is a user-visible behavior plus its rules, not a technical
   component.
5. **Fill the template.** Use only the sections for the selected level.
   Every capability gets at least one concrete example. Business rules
   name conditions, precedence, limits, permissions, and failure
   behavior.
6. **Self-check.** Run `references/quality-checklist.md`. Fix what can be
   fixed; list anything blocked by missing information as an open
   question or assumption.
7. **Review with the user.** Show the full Markdown draft in chat, then
   ask for corrections and the target filename in the same turn.
8. **Write the file.** Follow the filename and write-safety rules below.
   Never write before the user has named the file.
9. **Close.** Report the written path, a three-to-five line summary, and
   the handoff line. Do not generate tasks or estimates.

### Filename and write safety

- Ask: `Lưu PRD vào file nào? Gợi ý: docs/prd/<slug>.md`.
- A bare name such as `checkout-v2` resolves to
  `docs/prd/checkout-v2.md`.
- Append `.md` when the chosen path has no extension; keep an explicit
  extension otherwise.
- If the target exists, ask whether to overwrite or choose another name.
  Overwrite only after an explicit yes.
- Create missing parent directories, then write with the agent's file
  tool.
- If the user asks to see the PRD without a file, print the Markdown and
  skip writing.
- Slug rule: lowercase ASCII, words joined by hyphens, no dates, at most
  60 characters; derive it from the epic name and let the user override.

### Reference documents

`references/prd-structure.md` explains every section: purpose, prompts
to ask, what good looks like, and common mistakes. It also defines the
rules for measurable success metrics, business-rule precedence, DoD, and
test criteria.

`references/capability-decomposition.md` defines the Epic/Feature/
Capability/Task boundary, with tasks explicitly deferred to
`kanban-task-breakdown`. It covers vertical slicing by user journey,
role, and user-visible state; the one-to-five feature and two-to-five
capability guidance; and anti-patterns such as "build API", "create
table", and "refactor service". Worked examples: checkout, notifications,
and admin reporting.

`references/quality-checklist.md` is a pre-output checklist covering:
measurable metrics, concrete examples, testable rules and DoD,
out-of-scope, no tasks/estimates/technical file paths, honest
assumptions, selected-level completeness, language, filename/write
safety, and the handoff line. Each item has a pass condition.

### Builder-check decisions

These were settled after review; the builder does not need to revisit
them:

- `less` records assumptions and unknowns inline; no extra section.
- The level matrix is a completeness checklist. Document order follows
  "Section order and placement".
- New headings use the bilingual vocabulary above, in the same
  `Vietnamese (English)` pattern as the sample.
- UI/UX and Data & Integration stay epic-wide sections; per-feature
  `### F0x` grouping appears only when the epic has more than one
  feature.

### Repository registration

- `.skills.json`: add a `write-prd` entry with path
  `skills/write-prd` and a one-sentence description covering the three
  detail levels. Keep `version` at `1.2.0`.
- `README.md`: add a row to the Available Skills table and update the
  Repository Structure tree with the new skill's files.
- `CHANGELOG.md`: add an `### Added` bullet under `[Unreleased]`
  describing the skill, its templates, references, and file-writing
  behavior.
- No CI workflow changes; existing lint, frontmatter, manifest, and link
  checks cover the new files.

## Verification

- Run `markdownlint-cli2 "**/*.md"` and confirm no new failures.
- Run the CI-equivalent checks locally: every `.skills.json` path exists
  and has `SKILL.md`; frontmatter keys are present; `SKILL.md` links
  resolve; `.skills.json` lists every `skills/*/` directory.
- Confirm each template is a superset of the level below it by comparing
  heading lists in document order, not only as sets.
- Smoke-test the skill with a fresh agent: give it a raw feature idea,
  `detailed_mode=less`, and a bare filename. Confirm the agent asks for
  the filename before writing, creates `docs/prd/<slug>.md`, and the
  file contains every required `less` section, at least one concrete
  example per capability, no task breakdown, no hour estimates, and the
  handoff line.
- Smoke-test overwrite safety: run again with the same filename and
  confirm the agent asks before replacing the file.
- Cross-agent testing: run the fresh-agent smoke on the available
  harness and record that limitation. The contributor runs a second
  harness (for example Claude Code or Cursor) and ticks the
  `CONTRIBUTING.md` "at least 2 agents" item before the PR; this is
  outside the implementation plan.

## Calls left to implementation

- Exact prose and examples in the three reference documents.
- Whether `normal` and `fully` use tables or bullets for mapping and
  traceability sections; heading names and order stay fixed.
- The precise slug sanitization edge cases beyond the stated rule.
- Wording of the README tree comments and the changelog bullet.

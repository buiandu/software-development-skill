---
name: kanban-task-breakdown
description: Break down features into standardized Trello/Kanban tickets using Work Breakdown Structure (WBS) principles, 7-component card structure (Git Metadata, Technical Scope, Goal, Input, Output, Acceptance Criteria, Scope Control), and status workflow (Backlog, Ready, In Progress, Review, Done). Use when creating tasks, breaking down features, planning sprints, reviewing tickets, or defining Definition of Ready (DoR) and Definition of Done (DoD).
license: MIT
compatibility: Compatible with all agents adhering to the Agent Skills specification (Claude Code, Cursor, OpenCode, GitHub Copilot, Codex, etc.)
metadata:
  author: open-skills
  version: "1.1.0"
  category: project-management
parameters:
  - name: detailed_mode
    type: string
    enum: ["less", "normal", "fully"]
    default: "normal"
    description: Controls output verbosity for generated tickets. "less" = condensed template, "normal" = standard template, "fully" = comprehensive template with detailed examples, edge cases, risk assessment, monitoring, and rollback plans.
---

# Skill: Work Breakdown Structure (WBS) & Standard Trello/Kanban Ticket Creation

A comprehensive guide on Work Breakdown Structure (WBS) principles, standardized 7-component Trello/Kanban ticket formatting, and status workflow management for software development teams.

---

## Quick Reference

- **Feature (FXX):** End-to-end business value (takes days to weeks).
- **Task (XXX):** Independent technical unit (<= 5-8 hours / 1 day).
- **Title Format:** `[PX-FXX-XXX] - Actionable task title with verb` (Add `[UI]` prefix for UI tasks).
- **Card Structure:** 7 required components (Git Metadata, Technical Scope, Goal, Input, Output, Acceptance Criteria, Scope Control).
- **Workflow:** `Backlog/Hold` -> `Ready (DoR)` -> `In Progress` -> `Review/Testing` -> `Done (DoD)`.

Detailed reference files are available in `references/`:
- `references/breakdown-methods.md` - In-depth breakdown strategies (Layer-based, Vertical Slicing, Data/Config).
- `references/ticket-structure.md` - Complete 7-component structure guidelines and examples.
- `references/status-workflow.md` - Definition of Ready (DoR), Definition of Done (DoD), and column rules.

Copy-paste templates are available in `assets/` (select based on `detailed_mode` parameter):
- `assets/card-template-less.md` - Condensed template for quick task creation
- `assets/card-template-normal.md` - Standard template (default)
- `assets/card-template-fully.md` - Comprehensive template with detailed examples, edge cases, risk assessment, monitoring, and rollback plans

---

## 1. Work Breakdown Structure (WBS) Core Rules

### The 3 I's Rule (3D Rule)
1. **Independent:** Minimize dependencies so developers can work in parallel.
2. **Testable:** QA/Testers can verify completion immediately upon delivery.
3. **Sizable:** Must fit within 1 working day (<= 5-8 hours). Tasks > 8 hours **MUST** be split.

### Breakdown Approaches Overview
- **Layer-based:** DB Schema -> Service/Repo -> API Endpoint -> UI Component. (Best for platform/backend heavy tasks).
- **Vertical Slicing:** Happy Path -> Exception Handling -> Audit/Logging. (Best for Agile & early value delivery).
- **Data & Config:** Mock API $\rightarrow$ Real DB Integration $\rightarrow$ Dynamic Config.

*See `references/breakdown-methods.md` for detailed examples and criteria.*

---

## 2. Standard 7-Component Ticket Format

Every card MUST follow this title format:
```
[PX-FXX-XXX] - Actionable task title (contains an Action Verb)
[PX-FXX-XXX] - [UI] Actionable UI task title
```

### Required Card Sections

1. **Git Metadata:** Target branch (`feat/PX-FXX-XXX-short-name`), PR link target.
2. **Technical Scope:** Affected files, DB schema changes, algorithms used.
3. **Goal:** Business value / user context (Why are we coding this?).
4. **Input:** Pre-conditions, API specs, designs required before starting.
5. **Output:** Deliverables (API responses, migration files, UI behavior).
6. **Acceptance Criteria (AC):** Checkbox items (`- [ ]`) covering happy path, edge cases, and error states.
7. **Scope & Sprint Control:** Size estimate (`S` <= 2h, `M` 3-5h, `L` 6-8h) and explicit **Out of Scope** boundaries.

*Use the appropriate template from `assets/` based on `detailed_mode` when creating cards.*

---

## 3. Status Workflow & Governance

```
[Backlog / Hold]  --->  [Ready (DoR)]  --->  [In Progress]  --->  [Review / Testing]  --->  [Done (DoD)]
 (Missing Specs)        (7/7 Completed)      (Max 1-2/dev)          (PR + CI Green)        (Merged + QA Pass)
```

- **Definition of Ready (DoR):** All 7 components filled, AC clear, estimated <= 8h, zero blocking dependencies.
- **Definition of Done (DoD):** Merged to main/develop, QA pass all AC checkboxes, zero regression bugs.

---

## Execution Workflow for Agents

When activated to break down work or generate Kanban tickets:

1. **Read Parameters:** Check `detailed_mode` parameter (`less` | `normal` | `fully`, default: `normal`). Select corresponding template from `assets/`:
   - `less` → `card-template-less.md`
   - `normal` → `card-template-normal.md`
   - `fully` → `card-template-fully.md`

2. **Analyze Requirements:** Parse the input feature request. Select appropriate breakdown strategy (Layer-based, Vertical, Data/Config).

3. **Apply 3 I's Rule:** Ensure every task is independent, testable, and sized <= 8 hours.

4. **Generate Tickets:** Format each task strictly using the 7-component card structure and standard title formatting. Apply verbosity level from selected template:
   - `less`: Minimal descriptions, essential checkboxes only
   - `normal`: Standard descriptions with examples
   - `fully`: Comprehensive details including risk assessment, rollback plans, monitoring, security, accessibility, and performance criteria

5. **Validate DoR:** Check that all inputs, acceptance criteria, and technical scopes are completely specified before marking as `Ready`.

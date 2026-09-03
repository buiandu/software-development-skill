# Changelog

All notable changes to the `software-development-helper-skills` repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### Added
- New `design-thinking` skill: facilitates the 5-step Design Thinking process (Empathize, Define, Ideate, Prototype, Test) to guide users from a vague problem to a validated solution.
  - `SKILL.md` with core facilitation rules (one step at a time, beginner support, Clear Output + Impact per step) and the agent execution workflow.
  - `references/step-guides.md` with full per-step facilitation scripts (Steps 0-5).
  - `references/frameworks.md` with the HMW formula, SCAMPER ideation method, Feedback Matrix, and User Persona fields.
  - `assets/` deliverable templates: `user-persona-template.md`, `hmw-statement-template.md`, `feedback-matrix-template.md`.
- GitHub contribution setup: PR template, issue templates (bug, feature, skill improvement, new skill), CODEOWNERS, CONTRIBUTING.md, SECURITY.md
- GitHub Actions CI workflow (`.github/workflows/ci.yml`) with markdown linting, skill structure validation, link checking, and template testing
- Repository documentation updates: Contributing and Security sections in README.md

### Changed
- Bumped `.skills.json` package version to 1.2.0 and registered the `design-thinking` skill.
- Updated README.md Available Skills table and Repository Structure to include `design-thinking`.
- `kanban-task-breakdown` skill version bumped to 1.1.0
- Added `detailed_mode` parameter (`less` | `normal` | `fully`) to control template verbosity
- Split `assets/card-template.md` into three templates:
  - `card-template-less.md` - Condensed for quick tasks
  - `card-template-normal.md` - Standard (default)
  - `card-template-fully.md` - Comprehensive with risk assessment, rollback plans, monitoring, security, accessibility
- Updated Execution Workflow in SKILL.md to select template based on `detailed_mode`

---

## [1.0.0] - 2026-09-01

### Added
- Initial release of `kanban-task-breakdown` skill complying with the Agent Skills Specification (agentskills.io).
- Standard 7-component ticket structure (Git Metadata, Technical Scope, Goal, Input, Output, Acceptance Criteria, Scope & Sprint Control).
- Work Breakdown Structure (WBS) principles: 3 I's Rule (Independent, Testable, Sizable <= 8h).
- Three breakdown strategies in `references/breakdown-methods.md` (Layer-based, Vertical Slicing, Data & Config).
- Status workflow definitions in `references/status-workflow.md` (Backlog, Ready/DoR, In Progress, Review/Testing, Done/DoD).
- Ready-to-use markdown card template in `assets/card-template.md`.
- Full package manifest `.skills.json` enabling `npx skills add` installation across 70+ AI agents.

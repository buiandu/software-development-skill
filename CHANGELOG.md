# Changelog

All notable changes to the `software-development-helper-skills` repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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

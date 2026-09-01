# Status Workflow & Governance Rules

This document outlines the column lifecycle for tickets on the Kanban board, including Definition of Ready (DoR) and Definition of Done (DoD) standards.

---

## Board Column Workflow

```
+----------------+     +----------------+     +-----------------+     +------------------+     +----------------+
| Backlog / Hold | --> |  Ready (DoR)   | --> |   In Progress   | --> | Review / Testing | --> |   Done (DoD)   |
+----------------+     +----------------+     +-----------------+     +------------------+     +----------------+
```

---

## Column Specifications

### 1. Backlog / Hold
- **Description:** Ideas, raw feature requests, or tasks lacking complete specification.
- **Criteria for entry:** Feature identified, but technical scope, API specs, or design mockups are incomplete.
- **Rule:** **STRICTLY PROHIBITED** to move cards directly from Backlog to In Progress.

### 2. Ready (Definition of Ready - DoR)
- **Description:** Fully specified tasks ready for developer pick-up.
- **DoR Checklist:**
  - [ ] Title follows `[PX-FXX-XXX] - <Verb> <Description>` format.
  - [ ] All 7 card components are completely filled out.
  - [ ] Technical scope explicitly identifies affected files/tables.
  - [ ] Inputs are fully available (specs finalized, designs approved, blockers merged).
  - [ ] Acceptance criteria contain verifiable checkboxes for happy path and error states.
  - [ ] Size estimation is complete and fits within $\le 8$ hours.
  - [ ] Out-of-scope boundaries are defined.

### 3. In Progress
- **Description:** Active development by an assigned engineer.
- **Rules:**
  - WIP (Work In Progress) Limit: Maximum **1–2 tasks per developer** simultaneously.
  - Developer must create git branch matching `Git Metadata` component.

### 4. Review / Testing
- **Description:** Development complete, Pull Request submitted, awaiting code review or QA verification.
- **Criteria:**
  - Pull Request created and linked to the Trello card.
  - Automated CI/CD build pipeline is GREEN (all unit/integration tests pass).
  - Assigned code reviewer or QA tester notified.

### 5. Done (Definition of Done - DoD)
- **Description:** Task fully completed, verified, and integrated into main codebase.
- **DoD Checklist:**
  - [ ] Code reviewed and approved by at least 1 Senior Dev / Tech Lead.
  - [ ] Pull Request merged into target branch (`main` or `develop`).
  - [ ] QA / PO has verified and checked off ALL Acceptance Criteria checkboxes.
  - [ ] No regression bugs introduced to existing features.
  - [ ] Deployment to staging/test environment successful (if applicable).

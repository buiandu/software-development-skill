# Standard 7-Component Card Structure

Every Kanban card produced under this specification MUST contain all 7 components described below.

---

## Title Naming Convention

Format:
`[PX-FXX-XXX] - <Action Verb> <Technical Description>`

For UI Tasks:
`[PX-FXX-XXX] - [UI] <Action Verb> <Component/Screen Description>`

### Examples
- **Correct (Backend):** `[P2-F04-001] - Write API POST /agents/register to generate api_key for Node`
- **Correct (UI):** `[P2-F05-003] - [UI] Render Node list data table with pagination on dashboard`
- **Incorrect:** `[P2-F04-001] - Fix registration` *(Vague, no action verb)*

---

## Detailed Component Specifications

### 1. Git Metadata
- **Branch:** `feat/PX-FXX-XXX-short-kebab-description`
- **Rules:** Kebab-case, lowercase, ASCII characters only, no spaces.
- **Purpose:** Direct traceability between Trello card, git branch, and GitHub PR.

### 2. Technical Scope
- Define the exact files, database tables, services, or modules impacted.
- Explicitly list tables created/modified, columns added, or packages introduced.
- *Example:* Add `hourly_cost` column to `nodes` table; update `app/services/cost_service.py`.

### 3. Goal (Business Objective)
- Explain *why* the developer is writing this code.
- Connect technical execution to business value so devs can make informed implementation choices.
- *Example:* Allow Admins to configure hourly GPU rental rates for daily CPAM reporting.

### 4. Input (Pre-conditions / Prereqs)
- Technical or design requirements that MUST be ready before starting work.
- Include API specs, Figma designs, dependent PR merges, environment variables required.
- **Strict Rule:** If inputs are incomplete, card remains in `Backlog/Hold` and CANNOT move to `In Progress`.

### 5. Output (Deliverables)
- Concrete deliverables expected upon completion.
- Include API response status codes, sample JSON payloads, database migration files, or UI state behaviors.

### 6. Acceptance Criteria (AC)
- Checklist of verifiable criteria required for QA signoff.
- MUST use Markdown checkbox syntax (`- [ ]`).
- MUST cover:
  - Happy path verification
  - Edge case / Error state handling (400, 401, 403, 404, 500)
  - Business constraint rules

### 7. Scope & Sprint Control
- **Size Estimation:** `S` (<= 2h) | `M` (3-5h) | `L` (6-8h). Tasks > 8h must be split.
- **Out of Scope:** Explicit list of items NOT included in this card to prevent scope creep.

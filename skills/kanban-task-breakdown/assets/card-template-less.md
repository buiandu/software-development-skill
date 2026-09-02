### Title Format
`[P2-FXX-XXX] - <Action Verb> <Technical Description>`
*(Add `[UI]` prefix for UI tasks: `[P2-FXX-XXX] - [UI] <Action Verb> <Description>`)*

---

### 1. Git Metadata
- **Branch:** `feat/P2-FXX-XXX-short-kebab-description`
- **Target PR:** `main` (or `develop`)

### 2. Technical Scope
- **Files Affected:** `path/to/file1.py`, `path/to/file2.ts`
- **DB Schema:** Add `column_name` to `table_name` table
- **Services/Modules:** `App/Services/SampleService`

### 3. Goal (Business Value)
- Brief explanation of business impact.

### 4. Input (Pre-conditions)
- [ ] API Spec finalized
- [ ] Figma Design ready (UI tasks)
- [ ] Blocked by PR: `#123`

### 5. Output (Deliverables)
- API endpoint returns `201 Created` with JSON payload
- Database migration file created
- UI component renders required states

### 6. Acceptance Criteria (AC)
- [ ] **Happy Path:** Verify expected output with valid data
- [ ] **Validation Path:** Verify HTTP 400 with error details
- [ ] **Auth Path:** Verify HTTP 401/403 for invalid/missing token
- [ ] **Business Rule:** Verify specific business constraint

### 7. Scope & Sprint Control
- **Size Estimate:** `M` (3-5 hours) *(S ≤ 2h | M 3-5h | L 6-8h)*
- **Out of Scope:** Items NOT included in this task
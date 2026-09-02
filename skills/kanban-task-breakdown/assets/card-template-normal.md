### Title Format
`[P2-FXX-XXX] - <Action Verb> <Technical Description>`
*(Add `[UI]` prefix after ID for UI tasks: `[P2-FXX-XXX] - [UI] <Action Verb> <Description>`)*

---

### 1. Git Metadata
- **Branch:** `feat/P2-FXX-XXX-short-kebab-description`
- **Target PR:** `main` (or `develop`)

### 2. Technical Scope
- **Files Affected:** `path/to/file1.py`, `path/to/file2.ts`
- **DB Schema:** Add `column_name` to `table_name` table
- **Services/Modules:** `App/Services/SampleService`

### 3. Goal (Business Value)
- Provide brief explanation of why this code is being written and the end-user/business impact.

### 4. Input (Pre-conditions)
- [ ] API Spec finalized (Link or inline schema)
- [ ] Figma Design ready (Link for UI tasks)
- [ ] Blocked by PR: `#123` (Must be merged first)

### 5. Output (Deliverables)
- API endpoint returns `201 Created` with JSON payload `{ "id": "uuid", "status": "active" }`
- Database migration file `YYYYMMDDHHMMSS_add_column_to_table.sql` created
- UI component renders loading, success, and error states

### 6. Acceptance Criteria (AC)
- [ ] **Happy Path:** Verify expected output when valid data is provided
- [ ] **Validation Path:** Verify HTTP 400 response with error details when required fields are missing
- [ ] **Auth Path:** Verify HTTP 401/403 response when token is invalid or missing permission
- [ ] **Business Rule:** Verify specific business constraint (e.g., Token single-use enforcement)

### 7. Scope & Sprint Control
- **Size Estimate:** `M` (3-5 hours) *(S <= 2h | M 3-5h | L 6-8h)*
- **Out of Scope:** List any features or enhancements NOT included in this task

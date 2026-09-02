### Title Format
`[P2-FXX-XXX] - <Action Verb> <Technical Description>`
*(Add `[UI]` prefix for UI tasks: `[P2-FXX-XXX] - [UI] <Action Verb> <Component/Screen Description>`)*

**Naming Convention Rules:**
- Use imperative mood: "Write", "Create", "Implement", "Refactor", "Fix", "Add", "Remove"
- Be specific: "Write API POST /agents/register" not "Fix registration"
- Include component/screen name for UI tasks
- Reference the Feature ID (FXX) this task belongs to

---

### 1. Git Metadata
- **Branch:** `feat/P2-FXX-XXX-short-kebab-description`
  - Kebab-case, lowercase, ASCII only, no spaces
  - Example: `feat/P2-F04-001-write-api-agents-register`
- **Target PR:** `main` (or `develop`)
- **Branch Protection:** Requires PR review + CI green before merge
- **CI Checks:** All lint, typecheck, unit tests, integration tests must pass
- **Commit Convention:** Conventional Commits (`feat:`, `fix:`, `refactor:`, `chore:`)

---

### 2. Technical Scope
- **Files Affected:** 
  - `path/to/controller.ts` - New endpoint handler
  - `path/to/service.ts` - Business logic
  - `path/to/validator.ts` - Input validation schemas
  - `path/to/types.ts` - TypeScript interfaces/types
- **DB Schema Changes:**
  - Add `column_name` (type, nullable, default) to `table_name` table
  - Create index on `column_name` for query performance
  - Migration file: `YYYYMMDDHHMMSS_add_column_to_table.sql`
- **Services/Modules:** 
  - `App/Services/AuthService` - Token generation
  - `App/Repositories/AgentRepository` - Data access
- **External Dependencies:** 
  - New npm package: `package-name@version` (justify why)
  - Third-party API: `api.example.com/v1/endpoint`
- **Algorithms/Patterns:**
  - Rate limiting: Token bucket (100 req/min)
  - Caching: Redis TTL 5min for GET endpoints
  - Idempotency: Client-generated idempotency keys

---

### 3. Goal (Business Value)
**User Story:** As a <role>, I want to <action>, so that <benefit>.
**Business Context:** 
- Why this code is being written
- End-user impact: e.g., "Admins can configure hourly GPU rates for accurate CPAM billing"
- Metrics affected: e.g., "Reduces registration latency from 2s → 200ms"
- Stakeholders: Product, Engineering, QA, Security, DevOps
- Revenue/cost impact: e.g., "Enables $50k/mo new revenue stream"

---

### 4. Input (Pre-conditions / Prerequisites)
**Technical Requirements:**
- [ ] API Spec finalized (OpenAPI/Swagger link: `https://api.docs/spec.yaml`)
- [ ] Database migration reviewed by DBA
- [ ] Environment variables defined: `API_KEY_SECRET`, `REDIS_URL`
- [ ] Dependent PRs merged: `#123` (Auth middleware), `#124` (Rate limiter)

**Design Requirements (UI Tasks):**
- [ ] Figma design approved (link: `https://figma.com/file/...`)
- [ ] Design system components available: `Button`, `Table`, `Modal`
- [ ] Responsive breakpoints defined: mobile (375px), tablet (768px), desktop (1440px)
- [ ] Accessibility requirements: WCAG 2.1 AA, keyboard navigation, ARIA labels

**Blockers/Risks:**
- [ ] Third-party API credentials not yet provisioned
- [ ] Security review required for new encryption method
- [ ] Performance budget: P95 < 200ms for API response

---

### 5. Output (Deliverables)
**API Deliverables:**
- `POST /api/v1/agents/register` returns:
  - `201 Created` - `{ "id": "uuid", "api_key": "sk_...", "status": "active", "created_at": "ISO8601" }`
  - `400 Bad Request` - `{ "error": "validation_error", "details": [{ "field": "email", "message": "invalid format" }] }`
  - `401 Unauthorized` - `{ "error": "unauthorized", "message": "Invalid credentials" }`
  - `409 Conflict` - `{ "error": "conflict", "message": "Agent already registered" }`
  - `429 Too Many Requests` - `{ "error": "rate_limited", "retry_after": 60 }`
  - `500 Internal Server Error` - `{ "error": "internal_error", "request_id": "uuid" }`

**Database Deliverables:**
- Migration file: `20260115120000_add_api_key_to_agents.sql`
- Rollback migration: `20260115120000_add_api_key_to_agents.down.sql`
- Seed data script for local dev (optional)

**UI Deliverables:**
- Component: `AgentRegistrationForm.tsx` with states: `idle`, `loading`, `success`, `error`
- Storybook stories for all states
- Unit tests: ≥ 80% coverage for component logic
- E2E test: Cypress test for full registration flow

**Documentation:**
- API docs updated (auto-generated from OpenAPI)
- README updated with new environment variables
- CHANGELOG entry under `## [Unreleased]`

---

### 6. Acceptance Criteria (AC)
**Happy Path:**
- [ ] Valid registration request returns `201` with `api_key` and `id`
- [ ] Agent record created in database with correct fields
- [ ] API key is cryptographically secure (256-bit entropy)
- [ ] Response includes `Location` header with agent resource URL
- [ ] Idempotent request with same key returns existing agent (`200` or `409`)

**Validation Path:**
- [ ] Missing required fields (`email`, `name`) returns `400` with field-level errors
- [ ] Invalid email format returns `400` with specific error message
- [ ] Duplicate email returns `409 Conflict` (not `500`)
- [ ] Payload > 1MB returns `413 Payload Too Large`

**Authentication & Authorization:**
- [ ] Missing `Authorization` header returns `401`
- [ ] Invalid/expired JWT returns `401`
- [ ] Valid token without `agents:write` scope returns `403`
- [ ] Token with correct scope allows registration

**Business Rules:**
- [ ] Single agent per email enforced at DB level (unique constraint)
- [ ] API key format: `sk_live_` prefix for production, `sk_test_` for sandbox
- [ ] Agent status defaults to `pending_verification` until email confirmed
- [ ] Rate limit: 10 registrations/minute per IP

**Error Handling & Resilience:**
- [ ] Database connection failure returns `503` with retry-after header
- [ ] Third-party service timeout returns `504` with circuit breaker open
- [ ] All errors logged with correlation ID for tracing
- [ ] No sensitive data (API keys, tokens) in logs

**Performance:**
- [ ] P95 latency < 200ms under normal load
- [ ] P99 latency < 500ms under 10x load
- [ ] Connection pool exhaustion handled gracefully

**Security:**
- [ ] API key never logged (masked in all outputs)
- [ ] Rate limiting prevents enumeration attacks
- [ ] Input sanitization prevents injection
- [ ] CORS headers configured correctly

**Accessibility (UI Tasks):**
- [ ] Form labels associated with inputs
- [ ] Error messages announced to screen readers
- [ ] Focus management on form submit/error
- [ ] Color contrast ratio ≥ 4.5:1

---

### 7. Scope & Sprint Control
- **Size Estimate:** `M` (3-5 hours) *(S ≤ 2h | M 3-5h | L 6-8h)*
  - Breakdown: API endpoint (2h), Validation (1h), Tests (1h), Docs (0.5h), Review (0.5h)
- **Out of Scope:**
  - Email verification flow (separate task: `P2-F04-002`)
  - Admin dashboard for agent management (separate feature: `P2-F05`)
  - Bulk agent registration API
  - Agent deactivation/reactivation
  - Webhook notifications on registration
- **Risk Assessment:**
  - **High:** New crypto dependency for API keys - requires security review
  - **Medium:** Rate limiter integration - test thoroughly under load
  - **Low:** Database migration - backward compatible, tested in staging
- **Rollback Plan:**
  - Revert migration: `./migrate down 1`
  - Feature flag: `AGENT_REGISTRATION_ENABLED=false`
  - DNS rollback if deployed via blue-green
- **Monitoring:**
  - Metrics: `agent_registration_total`, `agent_registration_duration_seconds`, `agent_registration_errors_total`
  - Alerts: Error rate > 1%, P95 latency > 500ms, Registration rate drop > 50%
  - Dashboards: Grafana "Agent Registration" panel
# Work Breakdown Structure (WBS) Deep Dive

This document provides detailed guidelines and strategies for breaking down software features into manageable, testable, and independent technical tasks.

---

## Feature vs. Task Distinction

| Dimension | Feature (FXX) | Task (XXX) |
|-----------|---------------|------------|
| **Scope** | Business goal / User capability | Single technical execution unit |
| **Duration** | Few days to several weeks | $\le 1$ working day (5–8 hours max) |
| **Audience** | Product Manager, Stakeholders, Users | Developers, Tech Leads, QA Testers |
| **Example** | GPU Node Auto-Registration System | Write POST `/agents/register` API endpoint |

---

## The 3 I's Breakdown Principles (Rule of 3Đ)

### 1. Independent (Độc lập)
- Each task should be implementable with minimal dependency on parallel tasks in the same sprint.
- Enable multiple developers to work concurrently without code conflicts.
- *Technique:* Use interfaces, contract stubs, or mock data to decouple backend and frontend work.

### 2. Testable / Measurable (Đo lường được)
- QA/Testers can verify completion as soon as the task PR is merged.
- Do not wait for the entire feature to complete before performing test validation.
- Every task must produce measurable output (API return code, unit test pass, UI element rendered).

### 3. Sizable / Quantifiable (Định lượng được)
- Estimate time required accurately before pulling into a sprint.
- Size limits:
  - **S (Small):** $\le 2$ hours
  - **M (Medium):** 3–5 hours
  - **L (Large):** 6–8 hours
- **Mandatory Rule:** Any task estimated $> 8$ hours MUST be split into two or more smaller tasks.

---

## Detailed Breakdown Strategies

### Strategy A: Technical Layer-Based Breakdown
Best for platform infrastructure, backend-heavy systems, or major data refactoring.

```
+-------------------------------------------------------+
| Task 1: DB Schema + ORM Models + Migrations          |
+-------------------------------------------------------+
                           |
                           v
+-------------------------------------------------------+
| Task 2: Repository & Service Layer Business Logic     |
+-------------------------------------------------------+
                           |
                           v
+-------------------------------------------------------+
| Task 3: API Endpoint + Schema Validation + Auth       |
+-------------------------------------------------------+
                           |
                           v
+-------------------------------------------------------+
| Task 4: UI Component Integration & State Management   |
+-------------------------------------------------------+
```

### Strategy B: Use-Case / Vertical Slicing Breakdown
Best for Agile feature development, providing end-to-end functionality early.

1. **Task 1: Happy Path Flow**
   - Core functional path with valid inputs and expected successful execution.
   - Example: User enters valid email/password and successfully logs in.
2. **Task 2: Exception Handling & Resiliency**
   - Edge cases, error paths, retries, timeouts, rate limits, and fallback logic.
   - Example: Handle invalid credentials, expired tokens, network timeouts, 429 rate limits.
3. **Task 3: Logging, Audit Trail & Security**
   - Security checks, audit logging, analytics events, and monitoring integration.
   - Example: Log login attempts, IP addresses, failed authentication alerts.

### Strategy C: Data & Configuration Layering
Best for phased integration of third-party APIs or complex data pipelines.

1. **Task 1: Mocked Data Endpoint**
   - Build API routes returning static mock JSON data to unblock UI developers immediately.
2. **Task 2: Real Database / Service Integration**
   - Wire API routes to actual database tables, ORM models, and external APIs.
3. **Task 3: Admin Configuration & Control**
   - Build admin interface or dynamic config options to control behavior in production.

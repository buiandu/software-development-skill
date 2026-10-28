# PRD Structure Guide

Read this before filling a template. It explains what each section must
prove and the questions that expose weak answers. During drafting, use
the selected template; use this guide to fix a section that is vague.

## Epic Overview

### Epic Name

- **Purpose:** Name the outcome, not the project or the team.
- **Ask:** What changes for the user when this ships?
- **Good:** "Bulk refunds for failed orders".
- **Mistake:** A codename or an internal ticket title.

### Target Persona

- **Purpose:** Say who acts, in what context, and how often.
- **Ask:** Which role performs this task, on which surface, and how often?
- **Good:** "Operations admin reviewing 50-200 failed orders per shift".
- **Mistake:** "Users" or "everyone".

### Core Objective

- **Purpose:** State the current state, the desired state, and why now.
- **Ask:** What is expensive, slow, or impossible today, and what becomes true?
- **Good:** "Refunds currently take 20 manual minutes per order; target is under 2 minutes for a batch of 100."
- **Mistake:** A feature name restated as a goal.

### Success Metrics

- **Purpose:** Make success measurable and falsifiable.
- **Ask:** What baseline or target, over what timeframe, measured from which source?
- **Good:** "Median refund handling time drops from 20 to 2 minutes within 30 days, measured from the refund audit log."
- **Mistake:** "Improve efficiency" or a target with no timeframe or source.
- **Unknown values:** Write `TBD (owner: <role>)`; never invent a number.

### Out of Scope

- **Purpose:** Stop scope growth before development starts.
- **Ask:** What related work is explicitly excluded, and who is affected?
- **Good:** "Partial refunds and cross-currency refunds are excluded; Finance handles them manually."
- **Mistake:** A list of future phases with no boundary.

### Assumptions & Dependencies

- **Purpose:** Expose what must stay true for the PRD to work.
- **Ask:** What are we assuming about data, traffic, permissions, or another team?
- **Good:** "Assumes the payment provider keeps refund idempotency keys for 24 hours."
- **Mistake:** Treating an unverified assumption as a requirement.

### Open Questions

- **Purpose:** Record decisions that block or change implementation.
- **Ask:** What is unresolved, who owns it, and does it block work?
- **Good:** "Can support agents refund above 500? Owner: Finance. Blocking: yes."
- **Mistake:** Questions with no owner or no blocking status.

## Feature Sections

### Feature Objective

- **Purpose:** Tie one user-visible area to the epic objective.
- **Ask:** What can the user do after this feature that they cannot do now?
- **Good:** "An admin can select and refund up to 100 failed orders in one action."
- **Mistake:** A technical component described as a feature.

### Problem Statement

- **Purpose:** Explain who hurts, how, and what inaction costs.
- **Ask:** Who hits this problem, in which step, and what happens today?
- **Good:** "Admins open each failed order, copy its ID, and refund it one at a time; a 100-order incident takes most of a shift."
- **Mistake:** A solution disguised as a problem.

### Priority & Dependencies

- **Purpose:** Tell the reader what must ship and what can wait.
- **Ask:** Is this must-have, should-have, or could-have, and what does it depend on?
- **Good:** "Must-have; depends on the bulk-action permission from the identity team."
- **Mistake:** Every capability marked must-have.

### Key Capabilities

- **Purpose:** Describe observable behavior, not implementation.
- **Ask:** What can the user do, and what is one concrete example?
- **Good:** "C01 - Select failed orders by date range; example: an admin selects all failed orders from yesterday."
- **Mistake:** "Build the refund API" or "create the refund table".

### Business Rules

- **Purpose:** Pin the conditions that make behavior deterministic.
- **Ask:** What condition applies, in what precedence, with which limit, permission, and failure behavior?
- **Good:** "Refunds above 500 require a second approver; approval is checked before the provider call; a rejected approval leaves the order unchanged."
- **Mistake:** "Refunds should be safe" with no condition or precedence.

### Feature Out of Scope

- **Purpose:** Bound this feature separately from the epic.
- **Ask:** Which adjacent behavior does this feature deliberately not cover?
- **Good:** "Retrying a refund after a provider timeout is out of scope; the admin retries manually."
- **Mistake:** Repeating the epic out-of-scope list.

### Definition of Done

- **Purpose:** List artifacts or behavior that must exist before the feature is accepted.
- **Ask:** Can QA observe each item without asking the author?
- **Good:** "Bulk selection shows a count and blocks submission above 100 orders."
- **Mistake:** "Code is clean" or "UI looks good".

### Test / Measurable Criteria

- **Purpose:** Give QA input-to-outcome checks, including failure paths.
- **Ask:** For each condition, what observable result proves it?
- **Good:** "101 orders selected -> submit is disabled and an error explains the 100-order limit."
- **Mistake:** "Test the happy path" with no expected result.

## UI/UX

- **Purpose:** Locate the behavior and name its states.
- **Ask:** Where does it live, what does the user do, and what shows during loading, empty, error, success, disabled, and permission denial?
- **Good:** "Order list toolbar; loading shows a skeleton; empty shows guidance; permission denial hides the action and explains why."
- **Mistake:** Only the happy path, with no empty or error state.

At `normal` and `fully`, also specify responsive behavior and copy.
At `fully`, add accessibility and keyboard behavior, i18n, and design
references.

## Data & Integration

- **Purpose:** State what data and services the behavior needs.
- **Ask:** Which inputs, from where, validated how, and what happens when a dependency fails?
- **Good:** "Inputs: order IDs, refund reason, approver identity. Failure: provider timeout keeps the order pending and shows a retry message."
- **Mistake:** Naming a database table or endpoint as the requirement.

At `normal` and `fully`, add field mapping, integration contracts
(direction, payload, trigger), and failure behavior. At `fully`, add
retention, privacy, volume, latency, and observability.

## Decisions and Delivery

### Risks & Mitigations

- **Purpose:** Name what could make the feature fail and the hedge.
- **Ask:** What is the risk, how likely, how damaging, and what reduces it?
- **Good:** "Provider rate limits during incidents; medium likelihood; high impact; queue refunds and surface delayed status."
- **Mistake:** "Risks: unknown" with no mitigation.

### Rollout & Rollback

- **Purpose:** Control exposure and recovery.
- **Ask:** Flag or percentage, rollback trigger, and who watches it?
- **Good:** "10% of admins for one week; rollback if refund error rate exceeds 2%; owner: Payments on-call."
- **Mistake:** "Release to everyone" with no recovery path.

### Analytics Events

- **Purpose:** Make adoption and failure observable.
- **Ask:** Which event, triggered by what, with which properties, for which decision?
- **Good:** "`bulk_refund_submitted` with order_count and duration; measures adoption and batch size."
- **Mistake:** Events with no purpose or no trigger.

### Non-functional Requirements

- **Purpose:** Pin quality attributes that are easy to ignore.
- **Ask:** What measurable target applies to performance, security, privacy, accessibility, and availability?
- **Good:** "p95 batch submission under 2 seconds for 100 orders; WCAG 2.1 AA."
- **Mistake:** "Must be fast and secure".

### Traceability Matrix

- **Purpose:** Show that every capability maps to a metric, a DoD item, and a test.
- **Ask:** Which capability does this row cover, and what proves it?
- **Good:** "C01 -> handling time metric -> bulk selection DoD -> 100-order test."
- **Mistake:** A matrix with capabilities that no test covers.

### Sign-off

- **Purpose:** Record who accepted the scope.
- **Ask:** Which product, design, engineering, and QA roles approved, and when?
- **Good:** "Product approved 2026-10-28; QA pending."
- **Mistake:** Names with no role or no status.

### Handoff

- **Purpose:** Point to the next step without doing it.
- **Ask:** Who breaks this into tasks, and with which skill?
- **Good:** "Breakdown công việc: dùng skill `kanban-task-breakdown`."
- **Mistake:** A task list, estimate, or branch name inside the PRD.

## Testability Rules

- State an observable outcome, not an intention.
- Use an exact number, unit, and timeframe for targets.
- Name the measurement source or mark it `TBD (owner: <role>)`.
- Avoid subjective adjectives: "fast", "clean", "user-friendly".
- Include the failure behavior, not only the success path.
- Prefer `condition -> observable result` over prose.

## Common Failures

- Persona written as "users".
- Success metric with no baseline, timeframe, or source.
- Capability with no concrete example.
- Business rule with no precedence or failure behavior.
- DoD item that QA cannot check.
- Out of scope that never ends.
- UI states limited to the happy path.
- Data section naming implementation instead of needs.
- Level drift: a higher template missing a lower-level section.

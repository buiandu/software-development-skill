# Capability Decomposition Guide

Use this after the epic overview and before filling feature sections. It
decides the shape of the PRD; the templates only decide the wording.

## Boundary

| Level | Scope | Typical duration | Owner |
| ----- | ----- | ---------------- | ----- |
| Epic | One business outcome and the users who get it | Weeks | Product |
| Feature | One user-visible area inside the epic | Days to weeks | Product + design |
| Capability | One behavior plus its rules, expressed as a PRD bullet group | Hours to days to describe | Product |
| Task | One implementation unit, including code, schema, and tests | One day or less | `kanban-task-breakdown` |

Tasks belong to `kanban-task-breakdown`. A PRD that contains tasks has
crossed the boundary and will be rejected by the quality checklist.

## Sizing

- One to five features per epic.
- Two to five capabilities per feature.
- If a feature has more than five capabilities, split it by user journey
  or role.
- If a capability needs several paragraphs of implementation detail, it
  is a task in disguise; move the detail out and keep the behavior.

## Vertical slicing

A vertical slice is a thin path through the product that a user can
exercise end to end. Use one of these methods:

1. **User journey steps.** Walk the task from entry to completion and
   name each step that changes what the user can do. Example: select
   orders, choose a reason, approve, see the result.
2. **Roles and personas.** Split by who performs the action and what
   they are allowed to see or do. Example: support agent refunds one
   order; finance lead approves a batch above a threshold.
3. **User-visible states.** Split by what the user needs to understand
   at each state. Example: pending, partially completed, failed, and
   recovered batches are different capabilities when they demand
   different actions.

Do not slice by technical layer (database, service, API, UI). That
split produces work items, not user-visible behavior, and it hides the
rules that make the feature testable. Layer splitting is a task-level
technique owned by `kanban-task-breakdown`.

## Naming

Use verb + object + outcome, in the user's language:

- Good: "Apply a coupon at checkout".
- Good: "Retry a failed batch refund".
- Good: "Export a scheduled report as CSV".
- Bad: "Coupon service".
- Bad: "Refund API".
- Bad: "Reporting module".

The name must let QA imagine a test without reading the description.

## Worked examples

### Checkout epic

Features: discounts, split payment, failed-payment recovery.

- Discounts: apply a coupon; reject an expired coupon; show the
  recalculated total.
- Split payment: pay with two methods; show the remaining balance;
  block submission when the split does not cover the total.
- Failed-payment recovery: retry the failed leg; show which leg failed;
  keep the successful leg unchanged.

### Notifications epic

Features: template management, channel delivery, delivery recovery.

- Template management: create a template; preview variables; publish a
  version.
- Channel delivery: send by email or SMS; fall back to the second
  channel when the first fails.
- Delivery recovery: retry a failed delivery; show the final status;
  stop after the retry limit.

### Admin reporting epic

Features: report builder, scheduled export, access scoping.

- Report builder: add a filter; combine filters; preview the row count.
- Scheduled export: choose a cadence; receive the file; see a failed
  export status.
- Access scoping: restrict a report to a team; deny access to another
  team; explain the denial.

## Anti-patterns

| Task phrasing | Why it is not a capability | Rewrite or defer |
| ------------- | -------------------------- | ---------------- |
| Build the refund API endpoint | Names an implementation unit | "Admin submits a bulk refund"; endpoint is deferred to kanban |
| Create the refunds table | Names a schema change | "Admin sees refund history"; schema is deferred to kanban |
| Refactor the payment service | Internal restructuring with no user-visible outcome | Defer to kanban; it is not a PRD item |
| Add unit tests for the refund flow | Verification activity, not product behavior | Defer to kanban; test criteria live in the PRD |
| Add retry logic | Implementation detail unless the user sees it | "Admin sees and can retry a failed batch" if user-visible |
| Make the UI responsive | Quality attribute with no scope | Put it in UI/UX or NFR, not in a capability |

## Handoff

After the PRD is approved, the person breaking down work reads the
capabilities and uses `kanban-task-breakdown` to turn each capability
into independently testable tasks. The PRD does not estimate or order
those tasks.

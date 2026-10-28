# PRD Quality Checklist

Run this before showing the draft or writing a file. A failed item is
either fixed or recorded as an assumption or open question; it is never
silently ignored.

## Scope

- [ ] Selected level matches the request. Pass: explicit parameter, or
  the user's wording, maps to one level and that level's headings are
  used.
- [ ] No task breakdown, estimate, branch, pull request, or
  implementation file path appears. Pass: the content stays at behavior
  and rules.
- [ ] Feature count is one to five and capability count is two to five
  per feature. Pass: each count is inside the range, or a split is
  explained.
- [ ] Every capability is user-visible behavior, not a technical
  component. Pass: each name starts with a verb and a user can observe
  the result.

## Evidence

- [ ] Persona is specific. Pass: role, context, and frequency are named,
  not "users".
- [ ] Objective states current -> desired and why now. Pass: both states
  and a reason are present.
- [ ] Success metrics are measurable. Pass: baseline or target,
  timeframe, and measurement source are present, or
  `TBD (owner: <role>)`.
- [ ] Problem statement names who is affected and the cost of inaction.
  Pass: a role and a concrete consequence are present.
- [ ] No invented fact. Pass: every unverified value is marked as an
  assumption or `TBD`.

## Capability quality

- [ ] Every capability has a concrete example. Pass: each capability
  includes a specific scenario, not a restatement.
- [ ] Business rules are deterministic. Pass: condition, precedence,
  limit, permission, and failure behavior are covered where relevant.
- [ ] Edge cases are explicit at `normal` and `fully`. Pass: each
  capability names at least one unusual condition and its behavior.

## Acceptance

- [ ] Definition of Done is verifiable. Pass: QA can observe or check
  every item without asking the author.
- [ ] Test criteria use `condition -> observable result`. Pass: every
  test item states an input or condition and an expected result.
- [ ] Required test classes are covered. Pass: `less` covers happy path
  plus one error or edge; `normal` and `fully` cover happy, edge, error,
  and permission.
- [ ] Fully covers limit and recovery. Pass: at least one test item
  addresses a boundary and one addresses recovery.

## Surfaces

- [ ] UI placement, interactions, and required states are present.
  Pass: placement, core actions, and loading/empty/error are named.
- [ ] Higher-level UI states are present. Pass: `normal` and `fully`
  include success, disabled, permission denial, responsive behavior,
  and copy; `fully` also includes accessibility, keyboard, i18n, and
  design references.
- [ ] Data and integration needs are present. Pass: inputs and external
  services are named; `normal` and `fully` add mapping, contracts, and
  failure behavior; `fully` adds retention, privacy, volume, latency,
  and observability.
- [ ] Fully includes risks, rollout, analytics, NFR, traceability, and
  sign-off. Pass: all six sections have content.

## Completeness

- [ ] Out of scope is non-empty. Pass: at least one excluded item is
  listed, with rationale at `normal` and `fully`.
- [ ] Assumptions and open questions are honest. Pass: every unknown is
  listed; `less` records them inline and higher levels use their
  sections.
- [ ] Handoff line is present. Pass: the last line points to
  `kanban-task-breakdown`.

## Delivery

- [ ] Output language matches the user. Pass: Vietnamese by default;
  another language only when requested.
- [ ] Filename is requested before writing. Pass: no file is created
  until the user names it.
- [ ] Overwrite is confirmed. Pass: an existing target is not replaced
  until the user says yes.
- [ ] Written path is reported. Pass: the final response names the file
  and summarizes the PRD.

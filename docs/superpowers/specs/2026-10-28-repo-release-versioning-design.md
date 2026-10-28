# Repo release versioning via git tags

Short design. Replaces the earlier per-skill frontmatter version design
(`2026-10-28-skill-versioning-design.md`, to be deleted).

## Intent

One version for the whole repository. It lives in `.skills.json`, is
mirrored by an annotated git tag and a GitHub Release, so anyone can
trace a release to its commit and see what changed. Per-skill
`metadata.version` fields go away: a number in a mutable file cannot be
traced, and it duplicates the repo version.

## Goals

- One repo version, declared once in `.skills.json` and confirmed by a
  tag `vX.Y.Z` and a GitHub Release of the same name.
- A tag that disagrees with the manifest, the changelog, or `main` never
  produces a Release.
- Users can see which release they installed (GitHub Releases/tags) and
  pin an install with `/tree/<tag>/...`.
- The repo no longer carries or validates per-skill versions.

## Non-goals

- Per-skill versions or per-skill tags.
- Automatic version selection from commit messages (approach B).
- Enforcing Conventional Commits.
- Backfilling tags for the never-released 1.1.0/1.2.0 changelog entries.
- Enforcing that `[Unreleased]` is empty at tag time.

## Anti-goals

- A tag without a Release, or a Release with empty notes.
- `.skills.json`, `CHANGELOG.md`, and the tag three-way drift.
- A tag pointing at a commit that is not on `main`.

## Constraints

- `.skills.json` is at `1.2.0`; `CHANGELOG.md` has `[Unreleased]` and
  `[1.0.0]` only. `1.1.0` was never cut.
- The existing CI step "Validate SKILL.md frontmatter" requires a
  `version:` key; removing the field requires updating that step.
- Workflow-created Releases need `permissions: contents: write` and the
  `gh` CLI, both available on `ubuntu-latest`.
- `npx skills add` installs from the default branch; a tag only affects
  installs through an explicit `/tree/<tag>/...` URL.
- Markdownlint already fails on existing docs; do not add failures in
  files this change touches.
- The 1.2.0 release includes both the kanban `detailed_mode` change and
  the new `design-thinking` skill; the changelog must say so.

## Approaches

**A. Manual tag + verifying workflow (chosen).** You bump and write the
changelog in a PR, tag after merge; the workflow refuses to release
unless tag, manifest, changelog, and branch agree. You keep control of
the number; the tag supplies provenance.

**B. Release Please.** Bot derives the version, opens a release PR,
updates the changelog and tags on merge. Less manual, but the bot picks
the number, needs config for `.skills.json`, and depends on commit
message discipline.

**C. Manual tag, no workflow.** Documented only. No guard, so the
drift this change exists to prevent stays possible.

## Design

### Version source and format

- `.skills.json` → `"version": "X.Y.Z"`, three numeric components, no
  leading zeros, no `v` prefix.
- Tag: `vX.Y.Z` (annotated, so tagger and date are recorded), pushed on
  a commit that is already on `main`.
- Release title: `vX.Y.Z`.

### Removal of per-skill versions

- Delete `metadata.version` from both `SKILL.md` files.
- Remove the `version:` requirement from the CI frontmatter step.
- CI keeps checking the required `name`, `description`, `license`,
  `metadata` keys and `.skills.json` ↔ directory consistency.

### Release workflow

`.github/workflows/release.yml`, triggered by `push` on tags matching
`v*.*.*`, with `contents: write`, full history checkout, then:

1. Reject a tag name that is not exactly `vX.Y.Z`.
2. Require `.skills.json` `version` to equal the tag without `v`.
3. Fetch `main` and require the tagged commit to be an ancestor of it
   (`git merge-base --is-ancestor`).
4. Extract the `## [X.Y.Z]` section from `CHANGELOG.md` into a notes
   file; fail if the section is missing or empty.
5. Create the Release with those notes; if it already exists (workflow
   rerun), update its notes instead of failing.

### CI additions

- Validate `.skills.json` `version` is semver on every run.
- Keep the existing changelog job (`[Unreleased]` present).
- No release checks on PRs: a mismatch surfaces when the tag is pushed,
  before any Release exists.

### First release

- Move the current `[Unreleased]` content into
  `## [1.2.0] - 2026-10-28`, noting it bundles the never-cut 1.1.0
  changes, and leave an empty `[Unreleased]`.
- After merge, tag `v1.2.0` and let the workflow cut the first Release.
- Do not backfill `v1.0.0`/`v1.1.0` tags: commits already carry the
  history, and retroactive tags would imply releases that never
  existed.

### Documentation

- `CONTRIBUTING.md`: "Release and versioning" — bump `.skills.json`,
  write the changelog section, merge, push `vX.Y.Z`, workflow verifies
  and publishes.
- `README.md`: replace update guidance with how to check (Releases and
  tags) and how to pin (`/tree/vX.Y.Z/...`); drop per-skill version
  claims.

### Calls left to implementation

- Annotated tags (`git tag -a`) over lightweight ones.
- Idempotent rerun: update notes when the Release exists.
- Workflow named `release.yml`, job `release`.

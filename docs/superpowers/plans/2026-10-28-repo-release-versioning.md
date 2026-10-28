# Repo Release Versioning Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use
> superpowers:subagent-driven-development (recommended) or
> superpowers:executing-plans to implement this plan task-by-task.
> Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** One repo version in `.skills.json`, mirrored by an annotated
`vX.Y.Z` tag and a verified GitHub Release, with per-skill
`metadata.version` fields removed.

**Architecture:** Tag-triggered workflow calls two small bash scripts:
one verifies tag format, manifest match, ancestry on `main`, and extracts
Release notes from the CHANGELOG; the other creates or updates the
Release. CI stops requiring per-skill versions and validates the
manifest version instead.

**Tech Stack:** GitHub Actions, bash, `jq`, `git`, `gh` CLI,
markdownlint.

**Spec:** `docs/superpowers/specs/2026-10-28-repo-release-versioning-design.md`

## Global Constraints

- Manifest version format: `X.Y.Z` in `.skills.json`; no leading
  zeros; no `v` prefix.
- Tag format: `vX.Y.Z`, annotated, on a commit reachable from `main`.
- First and only cut release in this plan: `v1.2.0`, date 2026-10-28.
- Do not create `v1.0.0` or `v1.1.0` tags.
- No `metadata.version` in any `SKILL.md`; CI must not require it.
- Do not increase markdownlint errors in files this plan touches.
- `.agents/**` is out of scope.

## Review Focus

1. Tag pushed on a branch commit that is not on `main` -> workflow must
   refuse before publishing.
2. Tag names `v1.2`, `v01.2.0`, `release-1.2.0` -> refused with the
   format error, no Release.
3. `.skills.json` not bumped before tagging -> refused, message names
   the manifest.
4. CHANGELOG lacks the matching `## [X.Y.Z]` section or it is empty ->
   refused, never an empty Release.
5. Workflow rerun after the Release exists -> notes updated, no
   duplicate, no failure.

Each is pinned by a step in Tasks 2 and 3.

---

### Task 1: Consolidate CHANGELOG into `[1.2.0]`

**Files:**

- Modify: `CHANGELOG.md:9-29`
- Create: `docs/superpowers/specs/2026-10-28-repo-release-versioning-design.md`
  (already written; commit it here)

**Interfaces:**

- Produces: `CHANGELOG.md` with `## [Unreleased]` (empty) followed by
  `## [1.2.0] - 2026-10-28`, then the existing `## [1.0.0]` section.
  Task 2 extracts releases from this heading; no other task changes it.

- [ ] **Step 1: Commit the approved spec**

```bash
git add docs/superpowers/specs/2026-10-28-repo-release-versioning-design.md
git commit -m "docs(specs): add repo release versioning design"
```

- [ ] **Step 2: Rewrite the top of `CHANGELOG.md`**

Keep `## [Unreleased]` with no entries, separated by `---`, then
`## [1.2.0] - 2026-10-28`, one intro line saying it bundles the
never-cut 1.1.0 kanban changes and the new `design-thinking` skill,
then the existing `### Added` / `### Changed` content verbatim. Leave
the `## [1.0.0] - 2026-09-01` section untouched.

- [ ] **Step 3: Verify heading order**

Run: `grep -n '^## \[' CHANGELOG.md | head -4`
Expected: `[Unreleased]`, `[1.2.0]`, `[1.0.0]` in that order.

- [ ] **Step 4: Verify the existing CI changelog check still passes**

Run: `grep -q "## \[Unreleased\]" CHANGELOG.md && echo OK`
Expected: `OK`.

- [ ] **Step 5: Commit**

```bash
git add CHANGELOG.md
git commit -m "docs(changelog): cut 1.2.0 release section"
```

---

### Task 2: Release verification script

**Files:**

- Create: `.github/scripts/verify-release.sh`

**Interfaces:**

- `verify-release.sh <tag> <notes-file>`; optional env
  `RELEASE_BASE_REF` (default `main`). Exit 0 writes the Release notes
  to `<notes-file>` and prints nothing else. Exit 1 writes
  `::error::<message>` to stderr.
- Consumes: `.skills.json` `version`, `CHANGELOG.md` headings, git
  ancestry of `HEAD`.
- Produces: notes file consumed by Task 3's publishing script.

**Behavior spec (exact):**

1. Tag regex: `^v(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$`.
   Message: `Tag '<tag>' is not vMAJOR.MINOR.PATCH`.
2. Repo root via `git rev-parse --show-toplevel`. Manifest version via
   `jq -r '.version' "$root/.skills.json"`. If `${tag#v}` differs:
   `Tag <tag> does not match .skills.json version <version>`.
3. If `origin/$RELEASE_BASE_REF` is missing:
   `Base ref origin/<ref> not found`. If
   `git merge-base --is-ancestor HEAD "origin/$RELEASE_BASE_REF"`
   fails: `Tag commit <short-sha> is not on <ref>`.
4. Extract the changelog block that starts with `## [<version>]`,
   ending at the next line starting `## [` or a bare `---` line. Trim
   leading blank lines. If no non-blank line remains:
   `CHANGELOG.md has no entry for <version>`.
5. Write the block to `<notes-file>`.

- [ ] **Step 1: Confirm the missing script fails**

Run: `bash .github/scripts/verify-release.sh v1.2.0 /tmp/notes.md`
Expected: FAIL, `No such file or directory`.

- [ ] **Step 2: Implement `.github/scripts/verify-release.sh`**

Start with `#!/usr/bin/env bash` and `set -euo pipefail`, reject
wrong argument count with a usage error, then implement steps 1-5.

- [ ] **Step 3: Verify the positive path**

Run: `bash .github/scripts/verify-release.sh v1.2.0 /tmp/notes.md`
Expected: exit 0; `grep -q design-thinking /tmp/notes.md` passes.

- [ ] **Step 4: Verify tag-format rejection**

Run: `bash .github/scripts/verify-release.sh v1.2 /tmp/notes.md`
Expected: exit 1, `Tag 'v1.2' is not vMAJOR.MINOR.PATCH`.
Run: `bash .github/scripts/verify-release.sh v01.2.0 /tmp/notes.md`
Expected: the same format error.

- [ ] **Step 5: Verify manifest mismatch rejection**

Run: `bash .github/scripts/verify-release.sh v9.9.9 /tmp/notes.md`
Expected: exit 1, message names `.skills.json` version `1.2.0`.

- [ ] **Step 6: Verify missing changelog entry rejection**

```bash
tmp=$(mktemp -d) && git clone -q . "$tmp/r"
sed -i '/^## \[1.2.0\]/,/^---/d' "$tmp/r/CHANGELOG.md"
( cd "$tmp/r" && bash .github/scripts/verify-release.sh v1.2.0 "$tmp/n.md" )
echo "exit=$?"
```

Expected: exit 1, `CHANGELOG.md has no entry for 1.2.0`. Then
`rm -rf "$tmp"`.

- [ ] **Step 7: Verify ancestry rejection**

```bash
tmp=$(mktemp -d) && git clone -q . "$tmp/r"
( cd "$tmp/r" && git switch -qc side && git commit -q --allow-empty \
  -m side && bash .github/scripts/verify-release.sh v1.2.0 "$tmp/n.md" )
echo "exit=$?"
```

Expected: exit 1, `Tag commit ... is not on main`. Then
`rm -rf "$tmp"`.

- [ ] **Step 8: Commit**

```bash
git add .github/scripts/verify-release.sh
git commit -m "ci(release): verify tag, manifest, changelog, ancestry"
```

---

### Task 3: Publishing script and release workflow

**Files:**

- Create: `.github/scripts/publish-release.sh`
- Create: `.github/workflows/release.yml`

**Interfaces:**

- `publish-release.sh <tag> <notes-file>`: if
  `gh release view <tag>` succeeds, run
  `gh release edit <tag> --title <tag> --notes-file <notes-file>`;
  otherwise `gh release create <tag> --title <tag> --notes-file
  <notes-file>`.
- Consumes: Task 2's `verify-release.sh` and notes file.
- Produces: job `release` in workflow `Release`.

- [ ] **Step 1: Write the failing invocation check**

Run: `bash .github/scripts/publish-release.sh v1.2.0 /tmp/notes.md`
Expected: FAIL, `No such file or directory`.

- [ ] **Step 2: Implement `.github/scripts/publish-release.sh`**

`set -euo pipefail`, require two args, then the create/edit branch
above. Do not suppress `gh` stderr.

- [ ] **Step 3: Verify create and edit paths with a `gh` stub**

```bash
tmp=$(mktemp -d)
cat > "$tmp/gh" <<'STUB'
#!/usr/bin/env bash
echo "$*" >> "$GH_LOG"
exit "${GH_VIEW_EXIT:-1}"
STUB
chmod +x "$tmp/gh"
: > "$tmp/log"
GH_LOG="$tmp/log" GH_VIEW_EXIT=1 PATH="$tmp:$PATH" \
  bash .github/scripts/publish-release.sh v1.2.0 "$tmp/n.md"
GH_LOG="$tmp/log" GH_VIEW_EXIT=0 PATH="$tmp:$PATH" \
  bash .github/scripts/publish-release.sh v1.2.0 "$tmp/n.md"
cat "$tmp/log"
```

Expected: first line starts `release view v1.2.0`, second
`release create v1.2.0`, third `release view v1.2.0`, fourth
`release edit v1.2.0`. Then `rm -rf "$tmp"`.

- [ ] **Step 4: Write `.github/workflows/release.yml`**

Trigger `push` on tags `v*.*.*`; `permissions: contents: write`; job
`release` on `ubuntu-latest`: checkout with `fetch-depth: 0`, fetch
`+refs/heads/main:refs/remotes/origin/main`, run Task 2's script with
`RELEASE_BASE_REF: main` and
`${{ runner.temp }}/release-notes.md`, then run
`.github/scripts/publish-release.sh "$GITHUB_REF_NAME"
"$RUNNER_TEMP/release-notes.md"` with
`GH_TOKEN: ${{ github.token }}`.

- [ ] **Step 5: Verify the workflow parses**

```bash
python3 -c "import yaml; yaml.safe_load(open(
'.github/workflows/release.yml'))" && echo OK
```

Expected: `OK`.

- [ ] **Step 6: Verify no unsupported trigger slips through**

Run: `grep -A3 'tags:' .github/workflows/release.yml`
Expected: only `v*.*.*`.

- [ ] **Step 7: Commit**

```bash
git add .github/scripts/publish-release.sh .github/workflows/release.yml
git commit -m "ci(release): publish GitHub Release from verified tag"
```

---

### Task 4: Remove per-skill versions and update CI

**Files:**

- Modify: `skills/kanban-task-breakdown/SKILL.md:8`
- Modify: `skills/design-thinking/SKILL.md:8`
- Modify: `.github/workflows/ci.yml:64-70`

**Interfaces:**

- Produces: both skills' frontmatter without `version`; CI step
  "Validate SKILL.md frontmatter" requiring only `name`,
  `description`, `license`, `metadata`; new step
  "Validate .skills.json version".

- [ ] **Step 1: Remove the two version lines**

Delete the version line (indented two spaces, `version: "..."`)
from each `metadata:` block.

- [ ] **Step 2: Verify no per-skill version remains**

Run: `grep -rn 'version:' skills/*/SKILL.md`
Expected: no output.

- [ ] **Step 3: Drop the `version:` requirement from CI**

In `.github/workflows/ci.yml`, delete the `grep -q "version:"`
block and its error message; keep the other key checks.

- [ ] **Step 4: Add manifest version validation**

Add a step running:

```bash
version=$(jq -r '.version' .skills.json)
if ! printf '%s' "$version" | grep -Eq \
  '^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$'; then
  echo "::error::.skills.json version '$version' is not MAJOR.MINOR.PATCH"
  exit 1
fi
```

- [ ] **Step 5: Run the CI frontmatter snippet locally**

Run the loop from the updated step over
`jq -r '.skills[].path' .skills.json`.
Expected: both skills pass with no `version` error.

- [ ] **Step 6: Verify the manifest check rejects bad versions**

Run the snippet against the repo (expect pass). Then run:

```bash
printf '{"version":"1.2"}' > /tmp/m.json
jq -r '.version' /tmp/m.json | grep -Eq \
  '^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$' || echo rejected
```

Expected: `rejected`.

- [ ] **Step 7: Commit**

```bash
git add skills/kanban-task-breakdown/SKILL.md \
  skills/design-thinking/SKILL.md .github/workflows/ci.yml
git commit -m "refactor(skills): drop per-skill versions; validate manifest"
```

---

### Task 5: Documentation

**Files:**

- Modify: `CONTRIBUTING.md:56-63,93,126`
- Modify: `README.md:48-78`

**Interfaces:**

- Produces: `CONTRIBUTING.md` "Release and versioning" section and no
  remaining `metadata.version` bump guidance; `README.md` guidance on
  checking and pinning a release.

- [ ] **Step 1: Capture the markdownlint baseline**

Run: `npx -y markdownlint-cli2 README.md CONTRIBUTING.md 2>&1 | tail -3`
Record the issue count; the final count must not be higher.

- [ ] **Step 2: Update `CONTRIBUTING.md`**

Remove `version: "1.0.0"` from the frontmatter example and the
"Versioned | Bump `metadata.version`..." table row. Add "Release and
versioning": bump `.skills.json` (`X.Y.Z`, no leading zeros, no `v`),
add the `## [X.Y.Z] - YYYY-MM-DD` changelog section, merge, then
`git tag -a vX.Y.Z -m vX.Y.Z` and `git push origin vX.Y.Z`; the
workflow refuses mismatched tags and publishes the Release.

- [ ] **Step 3: Update `README.md`**

In the update section, state that releases are visible under GitHub
Releases/tags, and that a specific release can be installed with
`<owner>/<repo>/tree/vX.Y.Z/skills/<skill>`; remove any per-skill
version claim.

- [ ] **Step 4: Verify no stale version guidance remains**

Run: `grep -rn 'metadata.version' README.md CONTRIBUTING.md`
Expected: no output.

- [ ] **Step 5: Re-run markdownlint and compare**

Run: `npx -y markdownlint-cli2 README.md CONTRIBUTING.md 2>&1 | tail -3`
Expected: issue count no higher than Step 1.

- [ ] **Step 6: Commit**

```bash
git add README.md CONTRIBUTING.md
git commit -m "docs: document repo-level release and version checks"
```

---

### Task 6: Cut `v1.2.0`

**Files:** none.

**Interfaces:**

- Consumes: everything above, integrated on `main`.
- Produces: tag `v1.2.0`, GitHub Release `v1.2.0`.

**Requires explicit approval to push a tag.**

- [ ] **Step 1: Confirm `main` contains the merged work**

Run: `git switch main && git pull --ff-only && git log --oneline -3`
Expected: release workflow, scripts, and changelog commits present.

- [ ] **Step 2: Tag and push**

```bash
git tag -a v1.2.0 -m v1.2.0
git push origin v1.2.0
```

- [ ] **Step 3: Verify the workflow ran**

Run: `gh run list --workflow=release.yml -L 1`
Expected: one completed successful run for `v1.2.0`.

- [ ] **Step 4: Verify the Release content**

```bash
gh release view v1.2.0 --json tagName,body -q '.tagName'
gh release view v1.2.0 --json body -q .body | grep design-thinking
```

Expected: `v1.2.0`, then the design-thinking changelog line.

- [ ] **Step 5: Verify rerun safety (no duplicate)**

Run: `gh run rerun <run-id>` for the `v1.2.0` run, then
`gh release list -L 3`.
Expected: exactly one `v1.2.0` Release.

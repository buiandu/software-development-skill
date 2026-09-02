## Description

Brief summary of changes. Link related issue(s) if applicable.

**Related Issue:** Fixes #(issue number)

---

## Skill(s) Affected

- [ ] `kanban-task-breakdown`
- [ ] Other: _______________

---

## Type of Change

- [ ] **New Skill** - Adding a completely new skill to the repository
- [ ] **Skill Improvement** - Enhancing templates, references, or logic in existing skill
- [ ] **Bug Fix** - Fixing incorrect behavior, broken links, or validation issues
- [ ] **Documentation** - Updates to README, CHANGELOG, CONTRIBUTING, or inline docs
- [ ] **CI/Build** - Changes to GitHub Actions, linting, validation scripts
- [ ] **Chore** - Dependency updates, refactoring, version bumps

---

## Changes Made

<!-- List specific files changed and what was modified -->

| File | Change |
|------|--------|
| `skills/kanban-task-breakdown/SKILL.md` | |
| `skills/kanban-task-breakdown/assets/card-template-*.md` | |
| `skills/kanban-task-breakdown/references/*.md` | |
| `README.md` | |
| `CHANGELOG.md` | |
| `.skills.json` | |
| Other: | |

---

## Validation Checklist

### Skill Spec Compliance
- [ ] `SKILL.md` has valid frontmatter (name, description, license, compatibility, metadata)
- [ ] `SKILL.md` follows Agent Skills specification structure
- [ ] Skill version bumped in frontmatter (`metadata.version`)
- [ ] Parameter definitions (if any) are documented in frontmatter

### Template & Asset Quality
- [ ] All `assets/*.md` templates render correctly (no broken markdown)
- [ ] Template placeholders are clear and consistent (`PX-FXX-XXX`, `path/to/file`)
- [ ] References in `references/` are accurate and up to date
- [ ] No hardcoded project-specific values in templates

### Cross-File Consistency
- [ ] `README.md` skill table matches `.skills.json` and actual skill directories
- [ ] `CHANGELOG.md` updated with entry under `## [Unreleased]`
- [ ] `.skills.json` version matches skill's `metadata.version`
- [ ] Internal links (relative paths) work correctly

### Testing
- [ ] Tested template output manually with sample feature breakdown
- [ ] Markdown lint passes (`markdownlint-cli2` or similar)
- [ ] No dead links in modified files

---

## Screenshots / Output Examples

<!-- If templates or UI changed, paste sample output here -->

---

## Breaking Changes

<!-- Does this change break existing workflows? If yes, describe migration path -->

- [ ] No breaking changes
- [ ] Breaking changes (describe below)

---

## Additional Notes

<!-- Any context, decisions, or follow-up items for reviewers -->
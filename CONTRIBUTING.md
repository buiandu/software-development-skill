# Contributing to Software Development Helper Skills

Thank you for contributing! This repository follows the [Agent Skills Specification](https://agentskills.io) to provide cross-agent compatible skills for AI coding assistants.

---

## Quick Start

```bash
# 1. Fork and clone
git clone https://github.com/buiandu/software-development-skill.git
cd software-development-skill

# 2. Create a branch
git checkout -b feat/your-change-name

# 3. Make changes, test, commit
git commit -m "feat(skill-name): description"

# 4. Push and open PR
git push origin feat/your-change-name
```

---

## Ways to Contribute

### 1. Improve Existing Skills
- Fix bugs in templates or logic
- Enhance reference documentation
- Add new parameters or verbosity modes
- Improve agent prompt guidance in `SKILL.md`

### 2. Add New Skills
Follow the [New Skill Checklist](#new-skill-checklist) below.

### 3. Improve Repository Infrastructure
- CI/CD pipelines
- Validation scripts
- Documentation (README, CONTRIBUTING)
- Issue/PR templates

---

## Skill Development Guidelines

### Agent Skills Specification Compliance

Every skill **MUST** have:

1. **`SKILL.md`** with valid frontmatter:
   ```yaml
   ---
   name: kebab-case-skill-name
   description: One-sentence description for agent discovery
   license: MIT
   compatibility: Compatible with all agents adhering to the Agent Skills specification
   metadata:
     author: github-username
     version: "1.0.0"
     category: project-management|code-quality|testing|documentation|devops|other
   parameters:
     - name: param_name
       type: string
       enum: ["opt1", "opt2"]
       default: "opt1"
       description: Parameter description
   ---
   ```

2. **Directory Structure**:
   ```
   skills/your-skill-name/
   ├── SKILL.md              # Required: Core instructions + frontmatter
   ├── references/           # Optional: In-depth docs (loaded on demand)
   │   ├── concept-guide.md
   │   └── examples.md
   └── assets/               # Optional: Copy-paste resources
       └── template.md
   ```

3. **Execution Workflow Section** in `SKILL.md` explaining how agents should use the skill.

### Writing Effective Skills

| Principle | Guidance |
|-----------|----------|
| **Single Responsibility** | One skill = one coherent capability |
| **Parameter-Driven** | Use frontmatter `parameters` for options agents can control |
| **Template-Based** | Put reusable content in `assets/`, reference from `SKILL.md` |
| **Reference Separation** | Deep docs in `references/` (loaded on demand, not in context) |
| **Cross-Agent** | Avoid agent-specific syntax; use standard markdown |
| **Versioned** | Bump `metadata.version` on every change (semver) |

### Template Design

- Use consistent placeholders: `PX-FXX-XXX`, `path/to/file`, `ComponentName`
- Provide examples for every section
- Support multiple verbosity levels via `detailed_mode` parameter (see `kanban-task-breakdown`)
- Keep templates renderable as valid markdown

---

## New Skill Checklist

Before submitting a new skill PR:

- [ ] Directory created at `skills/kebab-case-skill-name/`
- [ ] `SKILL.md` with valid frontmatter and Execution Workflow section
- [ ] At least one template in `assets/`
- [ ] Reference docs in `references/` (if skill has complex concepts)
- [ ] Entry added to `.skills.json` (matching name, path, description)
- [ ] Row added to `README.md` skill table
- [ ] Entry added to `CHANGELOG.md` under `## [Unreleased]`
- [ ] Tested with at least 2 agents (Claude Code, Cursor, OpenCode, etc.)
- [ ] Markdown lint passes
- [ ] All internal links work

---

## Improving Existing Skills

### Template Updates
1. Modify `assets/*.md` files
2. Update corresponding `references/*.md` if structure changes
3. Bump `metadata.version` in `SKILL.md` frontmatter
4. Update `CHANGELOG.md`

### Adding Parameters
1. Add to `parameters` in `SKILL.md` frontmatter
2. Document in `SKILL.md` Execution Workflow
3. Update templates to use parameter (e.g., `detailed_mode` selection)
4. Bump version, update CHANGELOG

### Reference Documentation
- Keep `references/` files focused and linkable
- Cross-reference from `SKILL.md` Quick Reference section
- Update when templates change

---

## Commit Message Convention

We use [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

**Types:**
- `feat` - New skill or skill capability
- `fix` - Bug fix in skill/template
- `docs` - Documentation only (README, references, comments)
- `refactor` - Code/template restructuring without behavior change
- `chore` - CI, dependencies, version bumps
- `style` - Formatting, markdown lint fixes

**Scope:** Skill name (e.g., `kanban-task-breakdown`) or `repo` for cross-cutting changes.

**Examples:**
```
feat(kanban-task-breakdown): add detailed_mode parameter with three levels
fix(kanban-task-breakdown): correct branch name format in card-template-less.md
docs(repo): update README with new skill installation instructions
chore(repo): add GitHub Actions CI workflow
```

---

## Testing

### Manual Testing
```bash
# Test skill loads correctly
# 1. Copy skill to test project .agents/skills/
# 2. Invoke via agent: "Use kanban-task-breakdown to break down X"
# 3. Verify output matches expected template structure
```

### Automated Validation (CI)
The CI pipeline runs:
- `markdownlint` on all `.md` files
- Skill structure validation (required files, frontmatter schema)
- Internal link checking
- `.skills.json` ↔ directory structure consistency
- Template rendering smoke test

Run locally:
```bash
# Install markdownlint
npm install -g markdownlint-cli2

# Lint all markdown
markdownlint-cli2 "**/*.md"

# Validate skill structure (custom script if available)
# node scripts/validate-skills.js
```

---

## Release Process

**Maintainers only:**

1. Update version in `.skills.json` and affected skill `SKILL.md`
2. Finalize `CHANGELOG.md` for release
3. Create git tag: `git tag v1.1.0`
4. Push tag: `git push origin v1.1.0`
5. GitHub Release created automatically (if workflow configured)
6. Announce in relevant channels

---

## Code of Conduct

This project follows the [Contributor Covenant](https://www.contributor-covenant.org/version/2/1/code_of_conduct/). By participating, you agree to uphold this code.

---

## Questions?

- Open a [Discussion](https://github.com/buiandu/software-development-skill/discussions) for design questions
- Check existing [Issues](https://github.com/buiandu/software-development-skill/issues) before creating new ones
- Review [Agent Skills Spec](https://agentskills.io) for framework details
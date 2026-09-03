# Software Development Helper Skills

[![Agent Skills Specification](https://img.shields.io/badge/Agent_Skills-1.0-blue)](https://agentskills.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A collection of open [Agent Skills](https://agentskills.io) compliant capabilities for AI coding assistants (Claude Code, Cursor, OpenCode, GitHub Copilot, Codex, etc.) to assist with software engineering tasks, task breakdown, code review, and development workflows.

---

## Available Skills

| Skill | Description | Path |
|-------|-------------|------|
| **`kanban-task-breakdown`** | Break down features into standardized Trello/Kanban tickets using Work Breakdown Structure (WBS) principles, 7-component card structure, and status workflows. | `skills/kanban-task-breakdown` |
| **`design-thinking`** | Facilitate the 5-step Design Thinking process (Empathize, Define, Ideate, Prototype, Test) to guide users from a vague problem to a validated solution, using HMW, SCAMPER, and Feedback Matrix frameworks. | `skills/design-thinking` |

---

## Installation & Setup

Install using the open agent skills CLI (`npx skills`):

### Project-Level Installation (Recommended for Teams)

Installs to `.agents/skills/` (shared by universal agents) and creates symlinks for agent-specific directories:

```bash
# Install all skills in this repository to your current project
npx skills add <your-github-username>/software-development-helper-skills

# Install a specific skill only
npx skills add <your-github-username>/software-development-helper-skills --skill kanban-task-breakdown

# Target specific agents explicitly
npx skills add <your-github-username>/software-development-helper-skills -a claude-code -a cursor
```

### Global Installation (User-Level)

Installs to your home directory so skills are available across all local projects:

```bash
npx skills add <your-github-username>/software-development-helper-skills -g
```

---

## How to Update Installed Skills

When improvements or new skills are committed to this repository, update your local skills using these commands:

### 1. Updating Project Skills

Re-run `npx skills add` to pull the latest version from GitHub:

```bash
# Update all skills in the project
npx skills add <your-github-username>/software-development-helper-skills

# Update a single skill
npx skills add <your-github-username>/software-development-helper-skills --skill kanban-task-breakdown
```

> **Symlink Mode (Default):** Updating `.agents/skills/` instantly updates all connected agents (Claude Code, Cursor, OpenCode, etc.) without extra configuration.

### 2. Updating Global Skills

```bash
npx skills add <your-github-username>/software-development-helper-skills -g
```

### 3. Listing & Managing Installed Skills

```bash
# List all skills installed in current project
npx skills ls

# List global skills
npx skills ls -g

# Filter by agent
npx skills ls -a cursor

# Remove a skill
npx skills rm kanban-task-breakdown
```

---

## Team & CI/CD Workflows

### Option A: Commit `.agents/skills/` (Zero Setup for Teammates)
Commit the `.agents/skills/` directory to git. When team members clone the repo, universal agents (Cursor, OpenCode, Codex, GitHub Copilot) will discover and use the skills automatically.

### Option B: Reproducible Installs via Lockfile
Use `.skills.json` and `skills-lock.json` to lock skill versions across your team or CI/CD pipelines:

```bash
npx skills experimental_install
```

---

## Repository Structure

```
software-development-helper-skills/
├── .github/
│   ├── CODEOWNERS                    # Auto-assign reviewers
│   ├── ISSUE_TEMPLATE/               # Issue templates
│   │   ├── bug_report.md
│   │   ├── feature_request.md
│   │   ├── new_skill_proposal.md
│   │   └── skill_improvement.md
│   ├── pull_request_template.md      # PR template
│   └── workflows/
│       └── ci.yml                    # CI validation pipeline
├── skills/
│   ├── kanban-task-breakdown/        # Skill: Kanban Task Breakdown & WBS
│   │   ├── SKILL.md                  # Core instructions & spec-compliant frontmatter
│   │   ├── references/               # In-depth reference materials (loaded on demand)
│   │   │   ├── breakdown-methods.md  # WBS strategies (Layer-based, Vertical, Data/Config)
│   │   │   ├── ticket-structure.md   # Standard 7-component ticket guide
│   │   │   └── status-workflow.md    # Status lifecycle, DoR, DoD definitions
│   │   └── assets/                   # Copy-paste resources
│   │       ├── card-template-less.md     # Condensed template
│   │       ├── card-template-normal.md   # Standard template (default)
│   │       └── card-template-fully.md    # Comprehensive template
│   └── design-thinking/              # Skill: Design Thinking Facilitator (5-step process)
│       ├── SKILL.md                  # Core facilitation rules & execution workflow
│       ├── references/               # In-depth reference materials (loaded on demand)
│       │   ├── step-guides.md        # Full per-step facilitation scripts (Steps 0-5)
│       │   └── frameworks.md         # HMW formula, SCAMPER, Feedback Matrix, Persona fields
│       └── assets/                   # Copy-paste deliverable templates
│           ├── user-persona-template.md     # Step 1 output (Persona + Pain Points)
│           ├── hmw-statement-template.md    # Step 2 output (Core Problem Statement)
│           └── feedback-matrix-template.md  # Step 5 output (Feedback Matrix + Next Action)
├── .skills.json                      # Ecosystem package manifest
├── CHANGELOG.md                      # Release history and version tracking
├── CONTRIBUTING.md                   # Contribution guidelines
├── README.md                         # Repository documentation
├── SECURITY.md                       # Security policy
└── LICENSE                           # MIT License
```

---

## Features

- **Work Breakdown Structure (WBS):** Applies the 3 I's Rule (Independent, Testable, Sizable <= 8h) to split complex features into small, parallelizable technical tasks.
- **Standardized 7-Component Card Formatting:** Ensures every card includes Git Metadata, Technical Scope, Goal, Input, Output, Acceptance Criteria (AC), and Scope Control.
- **Status Lifecycle Governance:** Clearly defines rules for `Backlog/Hold`, `Ready (DoR)`, `In Progress`, `Review/Testing`, and `Done (DoD)`.
- **Cross-Agent Compatibility:** Works natively across Claude Code, Cursor, OpenCode, GitHub Copilot, Cline, Codex, and 70+ other agents.

---

## Usage Example

Prompt your AI coding assistant:

> "Break down the User Authentication feature into Trello tickets following the kanban-task-breakdown skill rules."

The agent will load `SKILL.md` and generate standard 7-component tickets like:

```markdown
### [P2-F01-001] - Write POST /auth/login API endpoint with JWT token generation

#### 1. Git Metadata
- Branch: feat/P2-F01-001-auth-login-api

#### 2. Technical Scope
- Affected files: app/controllers/auth_controller.py, app/services/jwt_service.py

...
```

---

## Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:

- Improving existing skills
- Adding new skills
- Reporting bugs and requesting features
- Commit message conventions
- Testing and validation

### Quick Links

- [Open a Bug Report](https://github.com/buiandu/software-development-skill/issues/new?template=bug_report.md)
- [Request a Feature](https://github.com/buiandu/software-development-skill/issues/new?template=feature_request.md)
- [Propose a Skill Improvement](https://github.com/buiandu/software-development-skill/issues/new?template=skill_improvement.md)
- [Propose a New Skill](https://github.com/buiandu/software-development-skill/issues/new?template=new_skill_proposal.md)

---

## Security

See [SECURITY.md](SECURITY.md) for vulnerability reporting and supported versions.

---

## License

[MIT](LICENSE)

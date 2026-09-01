# Agent Skill: Work Breakdown Structure (WBS) & Kanban Ticket Creation

[![Agent Skills Specification](https://img.shields.io/badge/Agent_Skills-1.0-blue)](https://agentskills.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

An open [Agent Skills](https://agentskills.io) compliant skill for AI coding assistants (Claude Code, Cursor, OpenCode, GitHub Copilot, Codex, etc.). It teaches agents how to break down software features into standardized, testable tasks and format 7-component Kanban/Trello tickets.

---

## Quick Installation

Install using the open agent skills CLI (`npx skills`):

```bash
# Install to project (universal location .agents/skills/)
npx skills add <your-github-username>/kanban-task-breakdown

# Install globally (available across all projects)
npx skills add <your-github-username>/kanban-task-breakdown -g

# Target specific agent
npx skills add <your-github-username>/kanban-task-breakdown -a claude-code -a cursor
```

---

## Directory Structure

```
kanban-task-breakdown/
├── skills/
│   └── kanban-task-breakdown/      # Skill root directory
│       ├── SKILL.md                # Core instructions & spec-compliant frontmatter
│       ├── references/             # In-depth reference materials (loaded on demand)
│       │   ├── breakdown-methods.md# WBS strategies (Layer-based, Vertical, Data/Config)
│       │   ├── ticket-structure.md # Standard 7-component ticket guide
│       │   └── status-workflow.md  # Status lifecycle, DoR, DoD definitions
│       └── assets/                 # Copy-paste resources
│           └── card-template.md    # Markdown ticket creation template
├── .skills.json                    # Ecosystem package manifest
├── README.md                       # Repository documentation
└── LICENSE                         # MIT License
```

---

## Features

- **Work Breakdown Structure (WBS):** Applies the 3 I's Rule (Independent, Testable, Sizable $\le 8$h) to split complex features into small, parallelizable technical tasks.
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

#### 1️⃣ Git Metadata
- Branch: feat/P2-F01-001-auth-login-api

#### 2️⃣ Technical Scope
- Affected files: app/controllers/auth_controller.py, app/services/jwt_service.py

...
```

---

## License

[MIT](LICENSE)

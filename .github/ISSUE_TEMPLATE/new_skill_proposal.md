---
name: New Skill Proposal
about: Propose a completely new agent skill for this repository
title: "[New Skill] <proposed-skill-name>: <one-line description>"
labels: new-skill, proposal
assignees: ''
---

## Proposed Skill Name

`kebab-case-skill-name` (e.g., `code-review-checklist`, `api-contract-testing`)

## Problem Statement

What software engineering task does this skill help with? Who is the target user?

## Target Agents

- [ ] Claude Code
- [ ] Cursor
- [ ] OpenCode
- [ ] GitHub Copilot
- [ ] Codex
- [ ] Other: _______________

## Proposed Skill Structure

### Core Capability

One-paragraph description of what the skill does when invoked.

### Parameters (if any)

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `param_name` | string/enum/boolean | `value` | Description |

### Template/Asset Files Needed

- [ ] `assets/template-name.md` - Copy-paste template
- [ ] `assets/config-example.yaml` - Configuration example
- [ ] Other: _______________

### Reference Documentation

- [ ] `references/concept-guide.md` - Core concepts
- [ ] `references/best-practices.md` - Best practices
- [ ] `references/examples.md` - Worked examples

## Draft SKILL.md Frontmatter

```yaml
---
name: proposed-skill-name
description: One-sentence description for agent discovery
license: MIT
compatibility: Compatible with all agents adhering to the Agent Skills specification
metadata:
  author: your-github-username
  version: "1.0.0"
  category: project-management|code-quality|testing|documentation|devops|other
parameters:
  - name: param_name
    type: string
    enum: ["option1", "option2"]
    default: "option1"
    description: Parameter description
---
```

## Example Agent Prompt

> "Use the proposed-skill-name skill to [action] with param_name: option2"

## Expected Output Format

Show sample output the skill should generate.

## Implementation Checklist

- [ ] Create skill directory: `skills/proposed-skill-name/`
- [ ] Write `SKILL.md` with frontmatter and instructions
- [ ] Create `assets/` templates
- [ ] Create `references/` documentation
- [ ] Add entry to `.skills.json`
- [ ] Update `README.md` skill table
- [ ] Add CHANGELOG entry
- [ ] Test with at least 2 different agents

## Related Work

- Existing skills this complements or replaces
- External tools/libraries it might integrate with
- Agent Skills spec sections it follows

## Additional Context

Any other information, mockups, or references.
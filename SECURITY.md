# Security Policy

## Supported Versions

We provide security updates for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 1.1.x   | :white_check_mark: |
| 1.0.x   | :x:                |

Only the latest minor version of the current major version receives security patches.

## Reporting a Vulnerability

**Please do NOT report security vulnerabilities via public GitHub issues.**

Instead, report them privately via:

1. **GitHub Security Advisories** (preferred):
   - Go to the [Security tab](https://github.com/buiandu/software-development-skill/security)
   - Click "Report a vulnerability"
   - Fill in the details

2. **Email**: security@buiandu.dev (if security tab unavailable)

### What to Include

- Description of the vulnerability
- Steps to reproduce
- Affected skill(s) and version(s)
- Potential impact
- Suggested fix (if any)

## Response Timeline

- **Acknowledgment**: Within 48 hours
- **Initial Assessment**: Within 7 days
- **Fix Timeline**: Depends on severity
  - Critical: < 30 days
  - High: < 60 days
  - Medium: < 90 days
  - Low: Next scheduled release

## Disclosure Policy

- We follow [Coordinated Vulnerability Disclosure](https://en.wikipedia.org/wiki/Coordinated_vulnerability_disclosure)
- Public disclosure only after fix is released
- Credit given to reporters (unless anonymity requested)

## Scope

This policy covers:
- Skills in this repository (`skills/`)
- Installation scripts and CI/CD workflows
- Documentation that could lead to misconfiguration

This policy does NOT cover:
- Agent applications that consume these skills (Claude Code, Cursor, etc.)
- User's own code generated using these skills
- Third-party dependencies of consuming projects

## Security Best Practices for Skill Authors

When contributing skills:

1. **No Secrets in Templates**: Never include API keys, tokens, or credentials in `assets/` or `references/`
2. **Validate External Inputs**: Skills that process user input should document validation requirements
3. **Least Privilege**: Document minimum permissions needed for generated code/templates
4. **Supply Chain**: Pin dependency versions in examples; avoid `latest` tags
5. **Injection Prevention**: Template placeholders should be clearly distinguishable from executable code

## Contact

For security questions: security@buiandu.dev
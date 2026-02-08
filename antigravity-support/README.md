# Get Shit Done (GSD) for Antigravity

**Autonomous Coding Methodology v1.0**

This package contains the complete GSD workflow system adapted for Google Antigravity. It enables structured, autonomous software development through planning, execution, and verification phases.

## Installation

1. **Copy** GSD runtime assets from this package to the root of your project:
   ```bash
   cp -r /path/to/antigravity-support/.agent /path/to/your/project/
   cp -r /path/to/antigravity-support/.codex /path/to/your/project/
   cp /path/to/antigravity-support/AGENTS.md /path/to/your/project/
   ```

2. **Initialize** the project:
   ```
   /new-project
   ```

For Codex CLI, use `$gsd-help` (or alias `/help`) after installation.

## Research-only Pack

This distribution also includes `get-research-done/` as a portable research workflow pack.

Install it into any target repo:

```bash
bash get-research-done/scripts/install.sh /path/to/target-repo
```

## Workflow Map

| Category | Command | Purpose |
|----------|---------|---------|
| **Core** | `/help` | Show all available commands |
| | `/progress` | Check status and get smart routing |
| **Planning** | `/plan {N}` | breakdown tasks for a phase |
| | `/new-milestone` | Start a new cycle of work |
| **Execution** | `/execute {N}` | Build the code (atomic commits) |
| | `/quick` | One-shot tasks (no research/verification) |
| **Verification** | `/verify {N}` | Prove it works (empirical evidence) |
| | `/audit-milestone` | Check quality before release |
| **Context** | `/add-todo` | Capture ideas without switching context |
| | `/check-todos` | Review and prioritize captured work |

## Key Concepts

- **Rule 1: Plan Before Build.** Workflows enforce creating plans before code.
- **Rule 2: State is Sacred.** `STATE.md` tracks every move.
- **Rule 3: Verify Empirically.** "Trust me bro" is not accepted.
- **Rule 4: Context Hygiene.** Reset regularly (`/clear` + `/resume`).

## Support

See `.agent/workflows/help.md` for detailed reference.

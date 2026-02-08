# GSD for Codex CLI

This repository supports Codex-native workflows via `AGENTS.md` + skills in `.codex/skills`.

## Core Methodology

1. Planning lock: do not implement product code until `.gsd/SPEC.md` is finalized.
2. State persistence: keep `.gsd/STATE.md` current after meaningful progress.
3. Empirical verification: verify with commands/screenshots, not assumptions.
4. Context hygiene: after repeated failed attempts, summarize and reset approach.

## Skill-first Rule

Use skills as the command runtime. Prefer skills over deprecated custom prompts.

- List skills: `/skills`
- Invoke directly: `$gsd-<workflow-name>`

## Command Alias Parity

If a user uses legacy AGY command phrasing, map it to the corresponding skill:

| User input alias | Skill |
|---|---|
| `/help` or `/gsd:help` | `$gsd-help` |
| `/new-project` or `/gsd:new-project` | `$gsd-new-project` |
| `/new-milestone` or `/gsd:new-milestone` | `$gsd-new-milestone` |
| `/plan N` or `/gsd:plan-phase N` | `$gsd-plan-phase` |
| `/execute N` or `/gsd:execute-phase N` | `$gsd-execute-phase` |
| `/verify N` or `/gsd:verify-work N` | `$gsd-verify-work` |
| `/map` or `/gsd:map-codebase` | `$gsd-map-codebase` |
| `/discuss-phase N` | `$gsd-discuss-phase` |
| `/research-phase N` | `$gsd-research-phase` |
| `/list-phase-assumptions N` | `$gsd-list-phase-assumptions` |
| `/plan-milestone-gaps` | `$gsd-plan-milestone-gaps` |
| `/progress` | `$gsd-progress` |
| `/pause` or `/gsd:pause-work` | `$gsd-pause-work` |
| `/resume` or `/gsd:resume-work` | `$gsd-resume-work` |
| `/add-phase` | `$gsd-add-phase` |
| `/insert-phase` | `$gsd-insert-phase` |
| `/remove-phase` | `$gsd-remove-phase` |
| `/debug` | `$gsd-debug` |
| `/add-todo` | `$gsd-add-todo` |
| `/check-todos` | `$gsd-check-todos` |
| `/settings` | `$gsd-settings` |
| `/set-profile` | `$gsd-set-profile` |
| `/update` | `$gsd-update` |
| `/sync-agy` | `$gsd-sync-agy` |
| `/quick` | `$gsd-quick` |
| `/audit-milestone` | `$gsd-audit-milestone` |
| `/join-discord` | `$gsd-join-discord` |

## Source of Truth

Skill wrappers in `.codex/skills` delegate to canonical command definitions in `commands/gsd/*.md`.
When behavior questions arise, follow command files first, then this file.

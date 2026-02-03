# Research: Phase 2 Sync Workflow

## Objective
Create `/sync-agy` to synchronize the root development environment with the `antigravity-support` distribution package.

## Requirements
1.  **Source Reliability**: Root is the source of truth.
2.  **Mapping Logic**:
    - `.agent/` → `antigravity-support/.agent/`
    - `.gsd/templates/` → `antigravity-support/.gsd/templates/` (Only templates, not project state)
    - `GSD-STYLE.md`, `CHANGELOG.md`, `LICENSE`, `VERSION` → `antigravity-support/`
    - `scripts/` (Root) → `antigravity-support/.scripts/` (with specific file filtering if needed)
3.  **Validation**:
    - Should run `validate-all` inside `antigravity-support` after sync to ensure integrity.

## Directory Mismatches
- Root has `scripts/` (containing validators + build-hooks).
- Antigravity-support has `.scripts/` (containing only validators).
- **Strategy**: Copy only `validate-*` scripts from `scripts/` to `.scripts/` to avoid polluting distribution with build hooks.

## User Request
"Sync recent /update with agy" -> This implies syncing the code that *just* updated. Since /update now syncs automatically, this new command is primarily for *manual* dev changes in root.

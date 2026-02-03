---
phase: 2
plan: 1
wave: 1
---

# Plan 2.1: Implement Sync Workflow

## Objective
Create `/sync-agy` workflow to publish root development changes to the `antigravity-support` distribution package.

## Tasks

<task type="auto">
  <name>Create Workflow File</name>
  <files>.agent/workflows/sync-agy.md</files>
  <action>
    Create `.agent/workflows/sync-agy.md` with:
    1.  **Backup**: Ensure safety first (though git handles this mostly).
    2.  **Sync Logic**:
        - `.agent/` → `antigravity-support/.agent/`
        - `.gsd/templates/` → `antigravity-support/.gsd/templates/`
        - `scripts/validate-*` → `antigravity-support/.scripts/`
        - Root docs (`README.md`, `GSD-STYLE.md`, `CHANGELOG.md`, `LICENSE`, `VERSION`) → `antigravity-support/`
    3.  **Sanitization Check**:
        - Grep for "Claude", "Anthropic", "Sonnet" in the `.agent/` and `.gsd/templates/` directories.
        - Fail if found (preventing "Claude-isms" from leaking to distribution).
    4.  **Validation**: Run `antigravity-support/.scripts/validate-all.sh` (or ps1) to verify distribution integrity.
    5.  **Confirm**: "Sync complete. Distribution ready."
  </action>
  <verify>test -f .agent/workflows/sync-agy.md</verify>
  <done>Workflow file exists</done>
</task>

<task type="auto">
  <name>Verify Sync</name>
  <files>antigravity-support/</files>
  <action>
    Run `/sync-agy` (manual trigger via `run_command` logic or simulation)
    Check that a test change in root propagates to support.
  </action>
  <verify>ls antigravity-support/CHANGELOG.md</verify>
  <done>Changes propagate</done>
</task>

## Success Criteria
- [ ] `/sync-agy` exists
- [ ] Root changes flow to `antigravity-support` correctly
- [ ] `scripts` -> `.scripts` mapping works

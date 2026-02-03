---
phase: 1
plan: 1
wave: 1
---

# Plan 1.1: Update Documentation

## Objective
Update project documentation to reflect the folder structure (`antigravity-support`) and the new Safe Update functionality.

## Context
- .gsd/SPEC.md
- README.md
- antigravity-support/README.md

## Tasks

<task type="auto">
  <name>Update Root README</name>
  <files>README.md</files>
  <action>
    1. Add "Developing GSD" section explaining the repo structure:
       - `antigravity-support/` is the template source.
       - Root is the active GSD instance for this repo's development.
    2. Add "Safety Features" subsection under "How It Works" or "Features":
       - Document the Interactive Update Workflow.
  </action>
  <verify>grep "Developing GSD" README.md</verify>
  <done>README clearly explains the dual-structure and update safety</done>
</task>

<task type="auto">
  <name>Verify Antigravity Support README</name>
  <files>antigravity-support/README.md</files>
  <action>
    Ensure `antigravity-support/README.md` correctly instructions users to copy the `.agent` directory.
    (This file is potentially already correct, but we will verify and minor tweak if needed).
  </action>
  <verify>grep "Copy the .agent" antigravity-support/README.md</verify>
  <done>User instructions are accurate</done>
</task>

## Success Criteria
- [ ] Root README explains `antigravity-support` purpose
- [ ] Root README documents the `/update` safety features
- [ ] `antigravity-support/README.md` is accurate for end-users

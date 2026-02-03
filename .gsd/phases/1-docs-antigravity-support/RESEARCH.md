# Research: Phase 1 (Docs & Setup)

## Objective
Update documentation to support `antigravity-support` structure and setup.

## Findings

### Files to Modify
1. **README.md**: 
   - Needs to mention `antigravity-support` in file structure.
   - Getting Started section needs adjustment? No, the Getting Started says "Clone GSD template... Copy .agent...". 
   - Wait, `README.md` instructions say:
     ```bash
     Copy-Item -Recurse gsd-template\.agent .\
     Copy-Item -Recurse gsd-template\.gemini .\
     Copy-Item -Recurse gsd-template\.gsd .\
     ```
     This is for *users* copying the template.
   - For **maintenance** of this repo (the Source), we need a "How to Develop" section explaining that `antigravity-support` is the source of truth for the Antigravity version.

2. **antigravity-support/README.md**:
   - Currently says: "Copy the `.agent` directory from this package to the root of your project".
   - This seems correct for the end-user package.

3. **antigravity-support/scripts/validate-all.sh**:
   - We might want to ensure this script checks for the new interactive update workflow existence? No, it validates structure.

4. **New Docs**:
   - We should document the *Interactive Update flow* we just built (`/update`) so users know it exists and how to use it safely.

## Plan Structure (Draft)
- **Task 1: Update Root README**: Add "Developing GSD" section explaining the repo structure (`antigravity-support` vs root).
- **Task 2: Update Antigravity Support README**: Clarify installation steps if needed.
- **Task 3: Document /update**: Add a section about the Safe Update workflow to `README.md`.

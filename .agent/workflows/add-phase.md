---
description: Add a new phase to the end of the roadmap
argument-hint: "<phase-name>"
---

# /add-phase Workflow

<objective>
Appends a new integer phase to the end of the current milestone in `.gsd/ROADMAP.md`.
Automatically calculates the next phase number.
</objective>

<process>

## Step 1: Validate Roadmap

```bash
test -f .gsd/ROADMAP.md || (echo "Error: No ROADMAP.md found" && exit 1)
```

## Step 2: Calculate Next Phase Number

**Find highest integer phase:**

```bash
# Extract phase headers, find max integer
# Note: Ignores decimal phases
grep "^### Phase [0-9]*:" .gsd/ROADMAP.md | sed 's/[^0-9]*//g' | sort -rn | head -1
```

If max is 5, next is 6.

## Step 3: Gather Phase Details

**If arguments provided:** Use as Description.
**If not:** Ask for Description.

**Generate Slug:**
Description "Add Auth System" → `add-auth-system`

## Step 4: Create Directory

```bash
mkdir -p .gsd/phases/{N}-{slug}
```

## Step 5: Update ROADMAP.md

Append to the **Current Milestone** section (before any "Future Milestone" or EOF).

**Entry Format:**

```markdown
### Phase {N}: {Description}
**Goal:** [To be planned]
**Status:** ⬜ Not Started
**Depends on:** Phase {N-1} ({Previous Phase Name})

**Plans:**
- [ ] TBD (run /plan {N})
```

## Step 6: Update STATE.md

1. Read `.gsd/STATE.md`
2. Update "Total Phases" count if present
3. Add to "Roadmap Evolution" section:
   `- Phase {N} added: {Description}`

## Step 7: Commit

```bash
git add .gsd/ROADMAP.md .gsd/STATE.md
git commit -m "docs(roadmap): add phase {N} - {Description}"
```

## Step 8: Confirm

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► PHASE ADDED ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Phase {N}: {Description}
Directory: .gsd/phases/{N}-{slug}/

▶ NEXT

/plan {N} — Create execution plans
```

</process>

<success_criteria>
- [ ] Correct next number calculated
- [ ] Directory created
- [ ] Roadmap appended correctly (preserving structure)
- [ ] State updated
- [ ] Git commit created
</success_criteria>

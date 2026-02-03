---
description: Remove a future phase and renumber subsequent phases
argument-hint: "<phase-number>"
---

# /remove-phase Workflow

<objective>
Remove an unstarted phase from the roadmap and renumber all subsequent phases to maintain a clean sequence.
Safe handling of directory renaming and file updates.
</objective>

<process>

## Step 1: Validate Phase

**Validate Phase Exists:**
Check if phase {N} exists in ROADMAP.md.

**Validate Phase is Future:**
Check STATE.md. Can only remove phases *after* the current phase.
Cannot remove executed phases (checked by looking for SUMMARY.md).

If valid, confirm:
```
⚠ CONFIRM REMOVAL
Phase {N}: {Name}
This will delete content and renumber subsequent phases.
Type "REMOVE" to confirm.
```

## Step 2: Remove Directory

```bash
# Delete target bucket
rm -rf .gsd/phases/{N}-*
```

## Step 3: Renumber Subsequent Directories

**Strategy:** Ascending shift (Phase N+1 becomes N, N+2 becomes N+1).

```bash
# Loop through phases and renumber if > N
for dir in .gsd/phases/[0-9][0-9]-*; do
  [ -e "$dir" ] || continue
  num=$(basename "$dir" | cut -d- -f1 | sed 's/^0*//')
  if [ "$num" -gt "{N}" ]; then
    new_num=$((num - 1))
    printf -v padded_num "%02d" $new_num
    slug=$(basename "$dir" | cut -d- -f2-)
    mv "$dir" ".gsd/phases/$padded_num-$slug"
  fi
done
```

## Step 4: Update ROADMAP.md

1. Remove the entire section for Phase {N}.
2. Decrement header numbers for all subsequent phases (`### Phase {M}:` → `### Phase {M-1}:`).
3. Update dependency references (`Depends on: Phase {M}` → `Phase {M-1}`).

## Step 5: Update STATE.md

Update total phase count if tracked in state.

## Step 6: Commit

```bash
git add .gsd/
git commit -m "chore(roadmap): remove phase {N} and renumber subsequent"
```

## Step 7: Confirm

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► PHASE REMOVED ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Removed: Phase {N}
Renumbered: Subsequent phases shifted down.

▶ NEXT

/progress — Verify new roadmap structure
```

</process>

<success_criteria>
- [ ] Safe removal (future phases only)
- [ ] Directory deleted
- [ ] Subsequent directories renumbered correctly
- [ ] Roadmap sections updated and renumbered
- [ ] Git commit created
</success_criteria>

---
description: Insert urgency phase between existing phases
argument-hint: "<after-phase> <description>"
---

# /insert-phase Workflow

<objective>
Insert a decimal phase (e.g., 4.1) for urgent work discovered mid-milestone.
Preserves integer phase numbering while accommodating unscheduled work.
</objective>

<process>

## Step 1: Parse Arguments

**Usage:** `/insert-phase <after> <description>`
Example: `/insert-phase 4 Fix Logic Bug`

- Target: Phase 4
- Description: "Fix Logic Bug"

## Step 2: Calculate Decimal Number

Find existing decimals for this phase to avoid collision.

```bash
# List phases starting with "4."
grep "^### Phase 4\." .gsd/ROADMAP.md
```

- If none: Next is `4.1`
- If exists `4.1`: Next is `4.2`

## Step 3: Create Directory

**Generate Slug:**
`04.1-fix-logic-bug`

```bash
mkdir -p .gsd/phases/{N.M}-{slug}
```

## Step 4: Insert into ROADMAP.md

**Locate Insertion Point:**
Insert immediately **after** the content of the Target Phase (and its existing decimals), but **before** the Next Integer Phase.

**Entry Format:**

```markdown
### Phase {N.M}: {Description} (INSERTED)
**Goal:** Urgent work (inserted)
**Status:** ⬜ Not Started
**Depends on:** Phase {Previous}

**Plans:**
- [ ] TBD (run /plan {N.M})
```

*(Note: The `(INSERTED)` marker helps identify unplanned work audit)*

## Step 5: Update STATE.md

Add to "Roadmap Evolution":
`- Phase {N.M} inserted: {Description} (Urgent)`

## Step 6: Commit

```bash
git add .gsd/ROADMAP.md .gsd/STATE.md
git commit -m "docs(roadmap): insert phase {N.M} - {Description}"
```

## Step 7: Confirm

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► PHASE INSERTED ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Inserted: Phase {N.M}: {Description}
Position: After Phase {N}

▶ NEXT

/plan {N.M} — Plan immediate fix
```

</process>

<success_criteria>
- [ ] Decimal calculated correctly
- [ ] Directory created with decimal prefix
- [ ] Roadmap inserted in correct position (not appended)
- [ ] (INSERTED) marker added
- [ ] Git commit created
</success_criteria>

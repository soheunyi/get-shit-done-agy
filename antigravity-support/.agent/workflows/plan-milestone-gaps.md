---
description: Create phases to close gaps found in milestone audit
---

# /plan-milestone-gaps Workflow

<objective>
Create all phases necessary to close gaps identified by `/audit-milestone`.

Groups gaps into logical phases, updates ROADMAP, and prepares for execution.
</objective>

<process>

## Step 1: Load Audit Results

Read most recent audit:
```bash
ls -t .gsd/v*-MILESTONE-AUDIT.md | head -1
```

Extract:
- Critical gaps (Must fix)
- Integration issues (Must fix)
- Tech debt (Optional - ask user)

---

## Step 2: Prioritize & Group Gaps

**Priority Logic:**
- **Must-have Requirement**: P0 (Immediate fix phase)
- **Broken Integration**: P0 (Immediate fix phase)
- **Tech Debt**: P1 (Discuss with user)

**Grouping Rules:**
1. **Co-locate by Component**: Group API fixes together, UI fixes together.
2. **Sequential Dependency**: Fix definition > Fix API > Fix UI > Verify Flow.
3. **Phase Sizing**: Aim for 3-5 tasks per fix phase.

*Example Grouping:*
> - Gap 1: User API missing field
> - Gap 2: Profile page crashes
> → **Phase 6: Fix User Profile Flow** (combines API + UI fix)

---

## Step 3: Propose Gap Closure Roadmap

Determine next phase number (e.g., if Milestone ended at Phase 5, start Phase 6).

Create plan:

```markdown
## Gap Closure Plan

**Phase {N}: {Name}**
- Fix: {Gap 1}
- Fix: {Gap 2}

**Phase {N+1}: {Name}**
- Fix: {Gap 3}

**Deferred:**
- {Tech debt item}
```

Ask user to confirm phases.

---

## Step 4: Update ROADMAP.md

Append new phases to current milestone in `.gsd/ROADMAP.md`:

```markdown
### Phase {N}: {Name}
**Goal:** Close audit gaps ({components})
**Status:** ⬜ Not Started
**Type:** Gap Closure
```

---

## Step 5: Create Directories

```bash
mkdir -p .gsd/phases/{N}-{slug}
```

---

## Step 6: Commit

```bash
git add .gsd/ROADMAP.md
git commit -m "docs(roadmap): add gap closure phases {N}-{M}"
```

---

## Step 7: Offer Next Steps

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► GAP CLOSURE DEFINED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Added phases {N}-{M} to roadmap.

▶ NEXT UP

/plan {N} — Plan first fix phase
```

</process>

<success_criteria>
- [ ] Gaps extracted from audit
- [ ] Grouping logic applied (not one phase per gap)
- [ ] User choice on tech debt included
- [ ] ROADMAP updated
- [ ] Execution readiness confirmed
</success_criteria>

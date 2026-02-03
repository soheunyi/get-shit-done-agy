---
description: List pending todos and select one to work on
argument-hint: "[area filter]"
---

# /check-todos Workflow

<objective>
List all pending todos, allow selection, load full context, and route to action.
</objective>

<process>

## Step 1: Check Existence

Count pending todos:
```bash
ls .gsd/todos/pending/*.md 2>/dev/null | wc -l
```

If 0, exit with "No pending todos".

---

## Step 2: List Todos

List summary of all pending todos:
- Parse `title`, `area`, `created` from frontmatter
- Filter by area if argument provided (e.g., `/check-todos api`)

Display:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► PENDING TODOS ({N})
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. [Title] (area, age)
2. [Title] (area, age)
...

Reply with number to view details.
```

---

## Step 3: Load Context

Read selected todo file. Display:
```
## [Title]

**Area:** [area]
**Created:** [date]

### Problem
[problem content]

### Solution
[solution content]
```

---

## Step 4: Offer Actions

Ask user how to proceed:

**Options:**
1. **"Work on it now"**
   - Move file to `.gsd/todos/done/`
   - Update STATE.md
   - Start work phase

2. **"Add to phase plan"**
   - Note for future planning
   - Keep in pending

3. **"Create a phase"**
   - Run `/add-phase` with this scope

4. **"Put it back"**
   - Return to list

---

## Step 5: Execute Action

**If "Work on it now":**
```bash
git mv .gsd/todos/pending/[file] .gsd/todos/done/
git commit -m "docs: start work on todo - [title]"
```

</process>

<success_criteria>
- [ ] Todos listed with metadata
- [ ] Context loaded for selection
- [ ] Action execution handled (git moves)
</success_criteria>

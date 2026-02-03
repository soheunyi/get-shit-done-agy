---
description: Capture idea or task as todo from current conversation
argument-hint: "[optional description]"
---

# /add-todo Workflow

<objective>
Capture an idea, task, or issue that surfaces during a GSD session as a structured todo for later work.

Enables "thought → capture → continue" flow without losing context.
</objective>

<process>

## Step 1: Ensure Directory Structure

Create todo directories if missing:
```bash
mkdir -p .gsd/todos/pending .gsd/todos/done
```

---

## Step 2: Extract Content

**If arguments provided:**
Use as the title/focus.

**If no arguments:**
Analyze recent conversation to extract:
- The specific problem/task discussed
- Relevant file paths mentioned
- Technical details

**Formulate:**
- `title`: Short descriptive title
- `problem`: Context/why this is needed
- `solution`: Hints or "TBD"
- `area`: Infer from context (api, ui, auth, database, docs, etc.)

---

## Step 3: Check Duplicates

Check for similar existing todos:
```bash
grep -l -i "[keywords]" .gsd/todos/pending/*.md
```

If duplicate found, ask user:
1. Skip
2. Replace
3. Add anyway

---

## Step 4: Create Todo File

Generate filename: `.gsd/todos/pending/[date]-[slug].md`

Write content:
```markdown
---
created: [timestamp]
title: [title]
area: [area]
files:
  - [file:lines involved]
---

## Problem
[Description of the issue or task]

## Solution
[Proposed approach or TBD]
```

---

## Step 5: Update State

Update `.gsd/STATE.md` accumulated context:
- Update "Pending Todos" count/list

---

## Step 6: Commit

```bash
git add .gsd/todos/pending/[filename]
git commit -m "docs: capture todo - [title]"
```

---

## Step 7: Confirm

Display:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► TODO ADDED ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[title]
Area: [area]
File: .gsd/todos/pending/[filename]

───────────────────────────────────────────────────────

Would you like to:
1. Continue work
2. Add another
3. /check-todos
```

</process>

<success_criteria>
- [ ] Todo captured as individual file
- [ ] Context (problem/solution) preserved
- [ ] Area inferred correctly
- [ ] Duplicates handled
- [ ] Committed to git
</success_criteria>

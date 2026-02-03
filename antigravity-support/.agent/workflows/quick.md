---
description: Execute a quick task with GSD guarantees but skip optional agents
---

# /quick Workflow

<objective>
Execute small, ad-hoc tasks with GSD guarantees (atomic commits, STATE.md tracking) while skipping optional agents (research, plan-checker, verifier).

Quick mode is the same system with a shorter path:
- Spawns **Planner Skill** to create focused plan
- Spawns **Executor Skill** to implement
- Updates STATE.md "Quick Tasks Completed" table (NOT ROADMAP.md)
</objective>

<process>

## Step 1: Pre-flight Validation

**Check Project:**
```bash
test -f .gsd/ROADMAP.md || (echo "Error: Run /new-project first" && exit 1)
```

**Resolve Models:**
Read `.gsd/config.json` to determine model profile (quality/balanced/budget).
*Default: balanced*

---

## Step 2: Get Task Description

**Ask User:** "What do you want to do?"
Store as `$DESCRIPTION`.

**Generate Slug:**
`add-auth-token` → `.gsd/quick/{NNN}-add-auth-token`

---

## Step 3: Setup Directory

**Calculate Next Number:**
Check `.gsd/quick/` for highest number. Increment.

**Create Directory:**
```bash
mkdir -p .gsd/quick/{NNN}-{slug}
```

---

## Step 4: Create Plan (Planner Skill)

**Invoke Planner Skill:**
1. Read `.agent/skills/planner/SKILL.md`
2. execute skill with context:
   - **Mode:** quick (no research, 1-3 tasks)
   - **Goal:** ${DESCRIPTION}
   - **Output:** `.gsd/quick/{NNN}-{slug}/{NNN}-PLAN.md`

*Constraint: Plan must be minimal and atomic.*

---

## Step 5: Execute Plan (Executor Skill)

**Invoke Executor Skill:**
1. Read `.agent/skills/executor/SKILL.md`
2. execute skill with context:
   - **Plan:** `.gsd/quick/{NNN}-{slug}/{NNN}-PLAN.md`
   - **Summary Output:** `.gsd/quick/{NNN}-{slug}/{NNN}-SUMMARY.md`

*Constraint: Commit each task verification.*

---

## Step 6: Update STATE.md

1. Check for "Quick Tasks Completed" table. Create if missing.
2. Append row:
   `| {NNN} | {DESCRIPTION} | {Date} | {Commit} | [Link](./quick/...) |`
3. Update "Last activity" timestamp.

---

## Step 7: Final Commit

```bash
git add .gsd/quick/{NNN}-*
git add .gsd/STATE.md
git commit -m "docs(quick-${NNN}): ${DESCRIPTION}"
```

## Step 8: Completion

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► QUICK TASK COMPLETE ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Task: ${DESCRIPTION}
Log: .gsd/quick/{NNN}-{slug}/{NNN}-SUMMARY.md

▶ NEXT

/quick — Do another task
/progress — Return to main roadmap
```

</process>

<success_criteria>
- [ ] Directory created with auto-increment number
- [ ] Plan created via Planner Skill
- [ ] Execution completed via Executor Skill
- [ ] STATE.md updated with table entry
- [ ] Git commit created
</success_criteria>

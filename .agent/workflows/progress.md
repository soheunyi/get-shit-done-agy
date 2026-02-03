---
description: Check project progress, show context, and route to next action
---

# /progress Workflow

<objective>
Check project progress, summarize recent work and what's ahead, then intelligently route to the next action - either executing an existing plan or creating the next one.

Provides situational awareness before continuing work.
</objective>

<process>

## Step 1: Verify Environment

**Verify project structure exists:**

```bash
test -d .gsd && echo "exists" || echo "missing"
```

If missing:
```
No GSD structure found.
Run /new-project to start a new project.
```
Exit.

**Check for active milestone:**
If `ROADMAP.md` is missing but `SPEC.md` exists, a milestone was completed. Go to **Route F** (Between Milestones).

---

## Step 2: Load Context

**Load full project context:**
- Read `.gsd/STATE.md` for living memory (position, decisions, issues)
- Read `.gsd/ROADMAP.md` for phase structure and objectives
- Read `.gsd/SPEC.md` for current state
- Read `.gsd/config.json` for settings

**Gather recent work:**
- Find 2-3 most recent `SUMMARY.md` files in `.gsd/phases/` or `.gsd/quick/`
- Extract key accomplishments

---

## Step 3: Analyze Position

**Parse current position:**
- From STATE.md: current phase, plan number, status
- count pending todos: `ls .gsd/todos/pending/*.md 2>/dev/null | wc -l`
- check active debug sessions: `ls .gsd/debug/*.md 2>/dev/null | grep -v resolved | wc -l`

**Calculate progress:**
- Total phases vs completed phases

---

## Step 4: Report Status

Present rich status report:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► PROGRESS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# [Project Name]

**Progress:** [████████░░] {completed}/{total} phases complete
**Profile:** {quality/balanced/budget}

## Recent Work
- [Phase X]: [accomplishment 1]
- [Phase Y]: [accomplishment 2]

## Current Position
Phase {N}: {phase-name}
Status: {status from STATE.md}

## Key Decisions
- {decision 1}
- {decision 2}

## Blockers/Concerns
- {blockers from STATE.md}

## Pending Items
- {N} todos pending — /check-todos
- {M} debug sessions — /debug

## What's Next
{Next objective from ROADMAP}
```

---

## Step 5: Intelligent Routing

**Count plans and summaries in current phase:**

```bash
ls -1 .gsd/phases/{N}/*-PLAN.md 2>/dev/null | wc -l
ls -1 .gsd/phases/{N}/*-SUMMARY.md 2>/dev/null | wc -l
ls -1 .gsd/phases/{N}/*-VERIFICATION.md 2>/dev/null | wc -l
```

**Route based on counts:**

| Condition | Meaning | Action |
|-----------|---------|--------|
| uat_with_gaps > 0 | Gaps found | Go to **Route E** |
| summaries < plans | Unexecuted plans | Go to **Route A** |
| verification exists | Phase verified | Go to **Step 6** |
| plans = 0 | Phase not planned | Go to **Route B** |

---

**Route A: Unexecuted plan exists**

Find first PLAN without SUMMARY.

```
▶ Next Up

**{phase}-{plan}: [Plan Name]**

/execute {phase} --plan {plan}
```

---

**Route B: Phase needs planning**

Check if `{phase}-CONTEXT.md` exists (from discussion).

If CONTEXT exists:
```
▶ Next Up

**Phase {N}: {Name}**
✓ Context gathered

/plan {N}
```

If NO context:
```
▶ Next Up

**Phase {N}: {Name}**

/discuss-phase {N} — Clarify scope (Recommended)
/plan {N} — Plan directly
```

---

**Route E: Verification gaps need fixes**

VERIFICATION.md has "FAIL" verdict.

```
⚠ Verification Gaps

/plan {N} --gaps
```

---

## Step 6: Milestone Check (Only if phase complete)

Check if more phases remain in milestone.

**Route C: More phases remain**

```
✓ Phase {N} Complete

▶ Next Up

**Phase {N+1}: {Name}**

/discuss-phase {N+1}
```

**Route D: Milestone complete**

```
🎉 Milestone Complete

All {N} phases finished!

▶ Next Up

/complete-milestone
```

---

**Route F: Between Milestones**

SPEC.md exists, ROADMAP.md missing.

```
✓ Milestone v{X.Y} Complete

▶ Next Up

/new-milestone
```

</process>

<success_criteria>
- [ ] Rich context provided
- [ ] Visual progress shown
- [ ] Smart routing logic applied
- [ ] User confirmed before action
</success_criteria>

# Phase 4 PLAN.md — Full Workflow Audit

## Objective
Expand all workflows to ≥80% of original depth, adapting Claude-specific patterns for Antigravity.

## Task Summary

| Priority | Workflows | Current Coverage |
|----------|-----------|------------------|
| Critical | 7 workflows | < 40% |
| Moderate | 3 workflows | 40-80% |
| Done | 8 workflows | ≥ 80% |

## Execution Order

### Wave 1: Most-Used Workflows
1. `/help.md` — Command reference (19% → 80%)
2. `/progress.md` — Project state display (24% → 80%)

### Wave 2: Todo Management
3. `/add-todo.md` — Capture todos (35% → 80%)
4. `/check-todos.md` — List todos (35% → 80%)

### Wave 3: Quality Workflows
5. `/audit-milestone.md` — Quality checks (38% → 80%)
6. `/plan-milestone-gaps.md` — Gap planning (39% → 80%)

### Wave 4: Phase Management
7. `/add-phase.md` — Add phases (46% → 80%)
8. `/insert-phase.md` — Insert phases (48% → 80%)
9. `/remove-phase.md` — Remove phases (39% → 80%)

### Wave 5: Polish
10. `/quick.md` — Already at 71%, minor expansion

## Adaptation Patterns

| Claude Pattern | Antigravity Equivalent |
|----------------|------------------------|
| `Task(subagent_type="gsd-planner")` | "Invoke the planner skill" |
| `AskUserQuestion` | "Ask user:" with options |
| `@.planning/` | `.gsd/` |
| Model profile references | Remove (Antigravity handles models) |

## Commit Strategy
- Commit after each wave
- Sync to `antigravity-support/` after each workflow

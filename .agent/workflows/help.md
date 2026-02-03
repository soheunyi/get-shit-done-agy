---
description: Show all available GSD commands and usage guide
---

# /help Workflow

<objective>
Display the complete GSD command reference.

Output ONLY the reference content below. Do NOT add:
- Project-specific analysis
- Git status or file context
- Next-step suggestions
</objective>

<reference>
# GSD Command Reference

**GSD** (Get Shit Done) creates hierarchical project plans optimized for agentic development.

## Quick Start

1. `/new-project` - Initialize project (includes research, requirements, roadmap)
2. `/plan 1` - Create detailed plan for first phase
3. `/execute 1` - Execute the phase

## Core Workflow

`/new-project` → `/plan` → `/execute` → repeat

### Project Initialization

**`/new-project`**
Initialize new project through unified flow.
- Deep questioning to understand what you're building
- Optional domain research (spawns 4 parallel researcher skills)
- Requirements definition with scoping
- Roadmap creation with phase breakdown
- Creates `.gsd/` artifacts (SPEC, ROADMAP, STATE, etc.)

**`/map`** (Codebase Mapper)
Map an existing codebase for brownfield projects.
- Analyzes codebase structure, patterns, and conventions
- Creates `.gsd/codebase/` with focused documentation
- Use before `/new-project` on existing codebases

### Phase Planning

**`/discuss-phase <number>`**
Clarify your vision for a phase before planning.
- Captures intent, scope decisions, and implementation approach
- Updates `.gsd/DECISIONS.md`
- Use when scope is unclear or trade-offs need discussion

**`/research-phase <number>`**
Comprehensive ecosystem research for niche/complex domains.
- Discovers standard stack, architecture patterns, pitfalls
- Creates `.gsd/research/` artifacts
- Use for specialized domains (3D, ML, crypto, etc.)

**`/plan <number>`**
Create detailed execution plan for a specific phase.
- Generates `.gsd/phases/N/PLAN.md`
- Breaks phase into concrete, actionable tasks
- Includes verification criteria and success measures

### Execution

**`/execute <phase-number>`**
Execute all plans in a phase.
- Groups plans by wave, executes waves sequentially
- Executes plans with atomic commits per task
- Verifies phase goal after completion
- Updates ROADMAP.md and STATE.md

### Quick Mode

**`/quick`**
Execute small, ad-hoc tasks with GSD guarantees.
- Spawns planner + executor (skips research/verification)
- Quick tasks live in `.gsd/quick/`
- Updates STATE.md tracking
- Use for isolated tasks known to be simple

### Roadmap Management

**`/add-phase <description>`**
Add new phase to end of current milestone.
- Appends to ROADMAP.md with next sequential number

**`/insert-phase <after> <description>`**
Insert urgent work between existing phases.
- Creates intermediate phase (e.g., 7.1 between 7 and 8)
- Maintains phase ordering

**`/remove-phase <number>`**
Remove a future phase.
- Deletes phase directory and renumbers subsequent phases
- Only works on future (unstarted) phases

### Milestone Management

**`/new-milestone <name>`**
Start a new milestone cycle.
- Deep questioning for next version goals
- Research and requirements scoping for new features
- Updates SPEC.md and creates new roadmap phases

**`/complete-milestone <version>`**
Archive completed milestone.
- Updates MILESTONES.md stats
- Archives artifacts to `.gsd/milestones/`
- Prepares workspace for next version

### Progress Tracking

**`/progress`**
Check project status and route to next action.
- Shows visual progress bar
- Summarizes recent work
- Lists key decisions and open issues
- Detects milestone completion

### Session Management

**`/resume`**
Resume work from previous session.
- Restores context from STATE.md
- Shows current position and recent progress

**`/pause`**
Create context handoff when pausing work.
- Updates STATE.md with in-progress context
- Saves session summary

### Debugging

**`/debug [issue]`**
Systematic debugging with persistent state.
- Scientific method: evidence → hypothesis → test
- Creates `.gsd/debug/[slug].md`
- Persists across context clears

### Todo Management

**`/add-todo [description]`**
Capture idea or task.
- Extracts context from conversation
- Creates structured todo file in `.gsd/todos/pending/`

**`/check-todos [area]`**
List and select pending todos.
- Filters by area
- Routes to appropriate action (work now, add to phase)

### Quality Assurance

**`/verify [phase]`**
Validate built features through conversational UAT.
- Extracts deliverables from summary
- Diagnoses failures and creates fix plans

**`/audit-milestone [version]`**
Audit milestone completion against intent.
- Checks verification status and requirements coverage
- Spawns integration checker
- Creates MILESTONE-AUDIT.md

**`/plan-milestone-gaps`**
Create phases to close gaps found by audit.
- Groups gaps into phases
- Prioritizes by requirement importance

### Configuration

**`/settings`**
Configure workflow toggles and preferences.
- Toggle research, plan-check, verifier
- Select mode (YOLO vs Interactive)

**`/set-profile <profile>`**
Quick switch execution profile.
- `quality`: Maximum thoroughness
- `balanced`: Good trade-off (default)
- `budget`: Fast, minimal cost

### Utilities

**`/help`**
Show this command reference.

**`/update`**
Update GSD to latest version.

## Files & Structure

```
.gsd/
├── SPEC.md               # Project vision & constraints
├── ROADMAP.md            # Phase breakdown
├── STATE.md              # Project memory & context
├── config.json           # Workflow settings
├── decisions.md          # Architecture Decision Records
├── research/             # Domain research artifacts
├── phases/               # Phase execution plans
│   └── 1/
│       ├── PLAN.md
│       └── SUMMARY.md
├── todos/                # Captured tasks
└── debug/                # Debug sessions
```

## Workflow Modes

**Interactive Mode**
- Confirms details
- Pauses for approval
- More guidance

**YOLO Mode**
- Auto-approves
- Faster execution
- Stops only for critical errors

*Configure via `/settings`*

## Core Rules

1. **Planning Lock**: No code until SPEC.md is FINALIZED
2. **State Persistence**: Update STATE.md after every task
3. **Context Hygiene**: 3 failures → state dump → fresh session
4. **Empirical Validation**: Proof required, no "it should work"

</reference>

---
description: Start a new milestone cycle — update SPEC.md and define new requirements
argument-hint: "[milestone name, e.g., 'v1.1 Notifications']"
---

# /new-milestone Workflow

<objective>
Start a new milestone through unified flow: questioning → research (optional) → requirements → roadmap.

This is the brownfield equivalent of /new-project. The project exists, SPEC.md has history. This command gathers "what's next", updates SPEC.md, then continues through the full requirements → roadmap cycle.

**Creates/Updates:**
- `.gsd/SPEC.md` — updated with new milestone goals
- `.gsd/research/` — domain research (optional, focuses on NEW features)
- `.gsd/REQUIREMENTS.md` — scoped requirements for this milestone
- `.gsd/ROADMAP.md` — phase structure (continues numbering)
- `.gsd/STATE.md` — reset for new milestone

**After this command:** Run `/plan [N]` to start execution.
</objective>

<process>

## Phase 1: Load Context

Read existing project state:
- SPEC.md (existing project, goals, constraints)
- STATE.md (pending todos, blockers, accumulated context)
- ROADMAP.md (what phases were completed)

Extract:
- What shipped in last milestone
- Validated requirements (what already exists)
- Accumulated decisions and learnings

---

## Phase 2: Gather Milestone Goals

**Show previous work:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► NEW MILESTONE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Previous Milestone: [v1.0]

**Shipped:**
- [Completed phase 1]
- [Completed phase 2]
- [Completed phase 3]

**Validated requirements:**
- [AUTH-01: Users can sign up]
- [AUTH-02: Users can log in]
```

**Open the conversation:**

Ask: "What do you want to build next?"

**Follow threads:**
- What problem this solves
- Who needs it
- What's already decided
- What's NOT in scope

---

## Phase 3: Determine Milestone Version

Suggest next version based on previous:
- Minor version (v1.0 → v1.1) for incremental features
- Major version (v1.0 → v2.0) for significant changes

```
Suggest milestone version: v1.1

A) Accept v1.1
B) Use different version — [specify]
```

---

## Phase 4: Update SPEC.md

Add new milestone section:

```markdown
## Current Milestone: v[X.Y] [Name]

**Goal:** [One sentence describing milestone focus]

**Target features:**
- [Feature 1]
- [Feature 2]
- [Feature 3]
```

Update "Last updated" footer.

**Commit SPEC.md:**

```bash
git add .gsd/SPEC.md
git commit -m "docs: start milestone v[X.Y] [Name]"
```

---

## Phase 5: Update STATE.md

```markdown
## Current Position

**Milestone**: v[X.Y] [Name]
**Phase**: Not started (defining requirements)
**Status**: Defining requirements
**Last activity**: [today] — Milestone v[X.Y] started
```

Keep Accumulated Context section (decisions, blockers) from previous milestone.

---

## Phase 6: Research Decision

```
📚 RESEARCH CHECK

Would you like to research the domain ecosystem for the new features?

A) Research first (Recommended) — Discover patterns, expected features for NEW capabilities
B) Skip research — I know what I need, go straight to requirements
```

**If "Research first":**

Display stage banner:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► RESEARCHING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Researching [new features] ecosystem...
```

Create research directory:
```bash
mkdir -p .gsd/research
```

**Conduct research in 4 dimensions (milestone-aware):**

Invoke the project-researcher skill for each dimension with milestone context:
- Focus ONLY on what's needed for the NEW features
- Don't re-research existing validated capabilities

Produce:
- `.gsd/research/STACK.md` — Stack additions needed for new features
- `.gsd/research/FEATURES.md` — Feature expectations for new capabilities
- `.gsd/research/ARCHITECTURE.md` — Integration with existing architecture
- `.gsd/research/PITFALLS.md` — Common mistakes when adding these features

After research, invoke the research-synthesizer skill to create:
- `.gsd/research/SUMMARY.md` — Executive summary with roadmap implications

Display research complete:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► RESEARCH COMPLETE ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Key Findings

**Stack additions:** [from SUMMARY.md]
**New feature table stakes:** [from SUMMARY.md]
**Watch Out For:** [from SUMMARY.md]

Files: `.gsd/research/`
```

**Commit research files:**

```bash
git add .gsd/research/
git commit -m "docs: research for milestone v[X.Y]

Focus: [new features]
Key findings:
- Stack: [one-liner]
- Integration: [one-liner]"
```

**If "Skip research":** Continue to Phase 7.

---

## Phase 7: Define Requirements

Display stage banner:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► DEFINING REQUIREMENTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Load context:**

Read SPEC.md and extract:
- Current milestone goals
- Validated requirements (what already exists - DON'T include these)

**If research exists:** Read research/FEATURES.md and extract feature categories.

**Present features by category:**

```
Here are the features for [new capabilities]:

## [Category 1]
**Table stakes:**
- Feature A
- Feature B

**Differentiators:**
- Feature C
- Feature D

**Research notes:** [any relevant notes]

---
```

**If no research:** Gather requirements through conversation:
- Ask: "What are the main things users need to be able to do with [new features]?"
- Probe for specifics
- Group into categories

**Scope each category:**

For each category:
```
[Category name]: Which features are in this milestone?

[ ] Feature 1 — [brief description]
[ ] Feature 2 — [brief description]
[ ] Feature 3 — [brief description]
[ ] None this milestone — Defer entire category
```

Track responses:
- Selected features → this milestone's requirements
- Unselected table stakes → future milestone
- Unselected differentiators → out of scope

**Generate REQUIREMENTS.md:**

Create/update `.gsd/REQUIREMENTS.md`:
- This milestone's requirements grouped by category (REQ-IDs)
- Continue numbering from existing requirements

**REQ-ID format:** `[CATEGORY]-[NUMBER]` (NOTIF-01, SHARE-02)

**Present for confirmation:**

```
## Milestone v[X.Y] Requirements

### [Category 1]
- [ ] **CAT1-01**: User can do X
- [ ] **CAT1-02**: User can do Y

### [Category 2]
- [ ] **CAT2-01**: User can do Z

---

Does this capture the milestone scope? (yes / adjust)
```

**Commit requirements:**

```bash
git add .gsd/REQUIREMENTS.md
git commit -m "docs: define milestone v[X.Y] requirements

[X] requirements across [N] categories"
```

---

## Phase 8: Create Roadmap

Display stage banner:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► CREATING ROADMAP
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Determine starting phase number:**

Read ROADMAP.md to find the last phase number from previous milestone.
New phases continue from there (e.g., if v1.0 ended at phase 5, v1.1 starts at phase 6).

**Invoke roadmapper skill with context:**
- Project: SPEC.md  
- Requirements: REQUIREMENTS.md (this milestone only)
- Research: research/SUMMARY.md (if exists)
- Starting phase number

**Roadmapper creates:**
1. Phases derived from THIS MILESTONE's requirements
2. Every requirement mapped to exactly one phase
3. 2-5 success criteria per phase
4. 100% coverage validation

**Update ROADMAP.md:**

Add new phases to existing roadmap:

```markdown
---

## Milestone v[X.Y]: [Name]

### Phase [N]: [Name]
**Status**: ⬜ Not Started
**Objective**: {what this delivers}
**Requirements**: CAT1-01, CAT1-02

**Success Criteria:**
1. [criterion]
2. [criterion]

### Phase [N+1]: [Name]
**Status**: ⬜ Not Started
**Objective**: {what this delivers}
**Requirements**: CAT2-01

...
```

**Present roadmap for approval:**

```
## Proposed Roadmap

**[N] phases** | **[X] requirements mapped** | All milestone requirements covered ✓

| # | Phase | Goal | Requirements |
|---|-------|------|--------------|
| [N] | [Name] | [Goal] | [REQ-IDs] |
| [N+1] | [Name] | [Goal] | [REQ-IDs] |
...

Does this roadmap structure work for you?
A) Approve — Commit and continue
B) Adjust phases — Tell me what to change
```

**If "Approve":** Continue to commit.
**If "Adjust":** Get user's notes, revise, re-present.

**Commit roadmap:**

```bash
git add .gsd/ROADMAP.md .gsd/STATE.md .gsd/REQUIREMENTS.md
git commit -m "docs: create milestone v[X.Y] roadmap ([N] phases)

All milestone requirements mapped to phases."
```

---

## Phase 9: Done

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► MILESTONE INITIALIZED ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

**Milestone v[X.Y]: [Name]**

| Artifact       | Location                    |
|----------------|-----------------------------| 
| Spec           | `.gsd/SPEC.md`              |
| Research       | `.gsd/research/`            |
| Requirements   | `.gsd/REQUIREMENTS.md`      |
| Roadmap        | `.gsd/ROADMAP.md`           |

**[N] phases** | **[X] requirements** | Ready to build ✓

───────────────────────────────────────────────────────

## ▶ Next Up

**Phase [N]: [Phase Name]** — [Goal from ROADMAP.md]

/discuss-phase [N] — Clarify scope and approach (recommended)
/plan [N] — Create Phase [N] execution plans

───────────────────────────────────────────────────────
```

</process>

<success_criteria>
- [ ] SPEC.md updated with Current Milestone section
- [ ] STATE.md reset for new milestone
- [ ] Research completed (if selected) — milestone-aware context
- [ ] Requirements gathered from research or conversation
- [ ] User scoped each category
- [ ] REQUIREMENTS.md created with REQ-IDs
- [ ] Roadmap created with phases continuing from previous milestone
- [ ] All commits made
- [ ] User knows next step is `/discuss-phase [N]` or `/plan [N]`
</success_criteria>

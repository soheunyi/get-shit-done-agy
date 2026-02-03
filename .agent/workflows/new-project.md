---
description: Initialize a new project with deep context gathering
---

# /new-project Workflow

<objective>
Initialize a new project through unified flow: questioning → research (optional) → requirements → roadmap.

This is the most leveraged moment in any project. Deep questioning here means better plans, better execution, better outcomes. One command takes you from idea to ready-for-planning.

**Creates:**
- `.gsd/SPEC.md` — project specification
- `.gsd/config.json` — workflow preferences
- `.gsd/REQUIREMENTS.md` — scoped requirements
- `.gsd/ROADMAP.md` — phase structure
- `.gsd/STATE.md` — project memory
- `.gsd/research/` — domain research (optional)

**After this command:** Run `/plan 1` to start execution.
</objective>

<process>

## Phase 1: Setup
**MANDATORY FIRST STEP — Execute these checks before ANY user interaction:**

1. **Abort if project exists:**

   **Bash:**
   ```bash
   if [ -f ".gsd/SPEC.md" ]; then
       echo "Error: Project already initialized. Use /progress" >&2
       exit 1
   fi
   ```

2. **Initialize git repo** (if not exists):

   ```bash
   if [ ! -d ".git" ]; then
       git init
       echo "Initialized new git repo"
   fi
   ```

3. **Detect existing code (brownfield detection):**

   ```bash
   code_files=$(find . -type f \( -name "*.ts" -o -name "*.js" -o -name "*.py" -o -name "*.go" -o -name "*.rs" \) \
       -not -path '*/node_modules/*' -not -path '*/.git/*' | head -20)
   
   has_package=$(test -f "package.json" -o -f "requirements.txt" -o -f "Cargo.toml" && echo true || echo false)
   has_architecture=$(test -f ".gsd/ARCHITECTURE.md" && echo true || echo false)
   ```

---

## Phase 2: Brownfield Offer
**If existing code detected and ARCHITECTURE.md doesn't exist:**

```
⚠️ EXISTING CODE DETECTED

Found {N} source files in this directory.

Options:
A) Map codebase first — Run /map to understand existing architecture (Recommended)
B) Skip mapping — Proceed with project initialization

Which do you prefer?
```

**If "Map codebase first":**
```
Run `/map` first, then return to `/new-project`
```
Exit command.

**If "Skip mapping":** Continue to Phase 3.
**If no existing code detected OR codebase already mapped:** Continue to Phase 3.

---

## Phase 3: Deep Questioning

Display banner:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► QUESTIONING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Open the conversation:**

Ask: "What do you want to build?"

Wait for response. This gives context for intelligent follow-ups.

**Follow the thread:**

Based on their answer, ask follow-up questions that dig deeper:
- What excited them about this idea
- What problem sparked this
- What they mean by vague terms
- What it would actually look like
- What's already decided

**Questioning techniques:**
- Challenge vagueness: "When you say 'fast', what does that mean specifically?"
- Make abstract concrete: "Give me an example of how a user would..."
- Surface assumptions: "You're assuming users will... Is that validated?"
- Find edges: "What's explicitly NOT in scope?"
- Reveal motivation: "Why does this matter now?"

**Context checklist (gather mentally, not as interrogation):**
- [ ] Vision — What does success look like?
- [ ] Users — Who is this for?
- [ ] Problem — What pain does it solve?
- [ ] Scope — What's in, what's out?
- [ ] Constraints — Technical, timeline, budget?
- [ ] Prior art — What exists already?

**Decision gate:**

When you could write a clear SPEC.md:
```
Ready to create SPEC.md?

A) Create SPEC.md — Let's move forward
B) Keep exploring — I want to share more
```

If "Keep exploring" — ask what they want to add, or identify gaps and probe naturally.

Loop until "Create SPEC.md" selected.

---

## Phase 4: Write SPEC.md

Create `.gsd/SPEC.md`:

```markdown
# SPEC.md — Project Specification

> **Status**: `FINALIZED`

## Vision
{Distilled from questioning — one paragraph max}

## Goals
1. {Primary goal}
2. {Secondary goal}
3. {Tertiary goal}

## Non-Goals (Out of Scope)
- {Explicitly excluded}
- {Not in this version}

## Users
{Who will use this and how}

## Constraints
- {Technical constraints}
- {Timeline constraints}
- {Other limitations}

## Success Criteria
- [ ] {Measurable outcome 1}
- [ ] {Measurable outcome 2}
```

**Commit SPEC.md:**

```bash
mkdir -p .gsd
git add .gsd/SPEC.md
git commit -m "docs: initialize project

[One-liner from SPEC.md Vision section]"
```

---

## Phase 5: Workflow Preferences

**Round 1 — Core workflow settings:**

```
How do you want GSD to work?

1. Mode
   A) YOLO (Recommended) — Auto-approve, just execute
   B) Interactive — Confirm at each step

2. Depth
   A) Quick — Ship fast (3-5 phases, 1-3 plans each)
   B) Standard — Balanced scope and speed (5-8 phases, 3-5 plans each)
   C) Comprehensive — Thorough coverage (8-12 phases, 5-10 plans each)

3. Git Tracking
   A) Yes (Recommended) — Planning docs tracked in version control
   B) No — Keep .gsd/ local-only (add to .gitignore)
```

**Round 2 — Workflow agents:**

```
Additional quality checks (add processing time but improve quality):

4. Research before planning each phase?
   A) Yes (Recommended) — Investigate domain, find patterns, surface gotchas
   B) No — Plan directly from requirements

5. Verify plans will achieve their goals?
   A) Yes (Recommended) — Catch gaps before execution starts
   B) No — Execute plans without verification

6. Verify work satisfies requirements after each phase?
   A) Yes (Recommended) — Confirm deliverables match phase goals
   B) No — Trust execution, skip verification
```

**Create `.gsd/config.json`:**

```json
{
  "mode": "yolo|interactive",
  "depth": "quick|standard|comprehensive",
  "commit_docs": true|false,
  "workflow": {
    "research": true|false,
    "plan_check": true|false,
    "verifier": true|false
  }
}
```

**If commit_docs = No:**
- Add `.gsd/` to `.gitignore`

**Commit config.json:**

```bash
git add .gsd/config.json
git commit -m "chore: add project config

Mode: [chosen mode]
Depth: [chosen depth]
Workflow agents: research=[on/off], plan_check=[on/off], verifier=[on/off]"
```

**Note:** Run `/settings` anytime to update these preferences.

---

## Phase 6: Research Decision

```
📚 RESEARCH CHECK

Would you like to research the domain ecosystem before defining requirements?

A) Research first (Recommended) — Discover standard stacks, expected features, architecture patterns
B) Skip research — I know this domain well, go straight to requirements
```

**If "Research first":**

Display stage banner:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► RESEARCHING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Researching [domain] ecosystem...
```

Create research directory:
```bash
mkdir -p .gsd/research
```

**Conduct research in 4 dimensions:**

Invoke the project-researcher skill for each dimension, producing:
- `.gsd/research/STACK.md` — Recommended technologies with versions and rationale
- `.gsd/research/FEATURES.md` — Feature landscape (table stakes, differentiators, anti-features)
- `.gsd/research/ARCHITECTURE.md` — System structure patterns
- `.gsd/research/PITFALLS.md` — Common mistakes with prevention strategies

After research, invoke the research-synthesizer skill to create:
- `.gsd/research/SUMMARY.md` — Executive summary with roadmap implications

Display research complete banner and key findings:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► RESEARCH COMPLETE ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Key Findings

**Stack:** [from SUMMARY.md]
**Table Stakes:** [from SUMMARY.md]
**Watch Out For:** [from SUMMARY.md]

Files: `.gsd/research/`
```

**Commit research files:**

```bash
git add .gsd/research/
git commit -m "docs: complete project research

Files:
- STACK.md
- FEATURES.md
- ARCHITECTURE.md
- PITFALLS.md
- SUMMARY.md

Key findings:
- Stack: [one-liner]
- Critical pitfall: [one-liner]"
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
- Core value (the ONE thing that must work)
- Stated constraints (budget, timeline, tech limitations)
- Any explicit scope boundaries

**If research exists:** Read research/FEATURES.md and extract feature categories.

**Present features by category:**

```
Here are the features for [domain]:

## Authentication
**Table stakes:**
- Sign up with email/password
- Email verification
- Password reset
- Session management

**Differentiators:**
- Magic link login
- OAuth (Google, GitHub)
- 2FA

**Research notes:** [any relevant notes]

---

## [Next Category]
...
```

**If no research:** Gather requirements through conversation instead:
- Ask: "What are the main things users need to be able to do?"
- For each capability mentioned:
  - Ask clarifying questions to make it specific
  - Probe for related capabilities
  - Group into categories

**Scope each category:**

For each category:
```
[Category name]: Which features are in v1?

[ ] Feature 1 — [brief description]
[ ] Feature 2 — [brief description]
[ ] Feature 3 — [brief description]
[ ] None for v1 — Defer entire category
```

Track responses:
- Selected features → v1 requirements
- Unselected table stakes → v2 (users expect these)
- Unselected differentiators → out of scope

**Identify gaps:**

```
Any requirements research missed? (Features specific to your vision)

A) No, research covered it — Proceed
B) Yes, let me add some — Capture additions
```

**Generate REQUIREMENTS.md:**

Create `.gsd/REQUIREMENTS.md`:

```markdown
# REQUIREMENTS.md

## v1 Requirements

### Authentication
- [ ] **AUTH-01**: User can create account with email/password
- [ ] **AUTH-02**: User can log in and stay logged in across sessions
- [ ] **AUTH-03**: User can log out from any page

### Content
- [ ] **CONT-01**: User can create posts with text
- [ ] **CONT-02**: User can edit their own posts

[... full list ...]

## v2 Requirements (Deferred)
- AUTH-04: OAuth (Google, GitHub)
- AUTH-05: 2FA

## Out of Scope
- [Feature] — [why excluded]

## Traceability
| REQ-ID | Phase | Status |
|--------|-------|--------|
| AUTH-01 | — | Pending |
```

**Requirement quality criteria:**

Good requirements are:
- **Specific and testable:** "User can reset password via email link" (not "Handle password reset")
- **User-centric:** "User can X" (not "System does Y")
- **Atomic:** One capability per requirement
- **Independent:** Minimal dependencies on other requirements

**REQ-ID format:** `[CATEGORY]-[NUMBER]` (AUTH-01, CONT-02)

**Present full requirements list:**

Show every requirement for user confirmation:
```
## v1 Requirements

### Authentication
- [ ] **AUTH-01**: User can create account with email/password
- [ ] **AUTH-02**: User can log in and stay logged in across sessions
...

Does this capture what you're building? (yes / adjust)
```

If "adjust": Return to scoping.

**Commit requirements:**

```bash
git add .gsd/REQUIREMENTS.md
git commit -m "docs: define v1 requirements

[X] requirements across [N] categories
[Y] requirements deferred to v2"
```

---

## Phase 8: Create Roadmap

Display stage banner:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► CREATING ROADMAP
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Invoke the roadmapper skill with context:
- Project: SPEC.md
- Requirements: REQUIREMENTS.md
- Research: research/SUMMARY.md (if exists)
- Config: config.json

**Roadmapper creates:**
1. Phases derived from requirements (don't impose structure)
2. Every v1 requirement mapped to exactly one phase
3. 2-5 success criteria per phase (observable user behaviors)
4. 100% coverage validation

Create `.gsd/ROADMAP.md`:

```markdown
# ROADMAP.md

> **Current Phase**: Not started
> **Milestone**: v1.0

## Must-Haves (from SPEC)
- [ ] {must-have 1}
- [ ] {must-have 2}

## Phases

### Phase 1: {Foundation}
**Status**: ⬜ Not Started
**Objective**: {what this delivers}
**Requirements**: AUTH-01, AUTH-02

**Success Criteria:**
1. User can create account with email/password
2. User can log in and session persists
3. User can log out from any page

### Phase 2: {Core Feature}
**Status**: ⬜ Not Started
**Objective**: {what this delivers}
**Requirements**: CONT-01, CONT-02

...
```

**Present roadmap for approval:**

```
## Proposed Roadmap

**[N] phases** | **[X] requirements mapped** | All v1 requirements covered ✓

| # | Phase | Goal | Requirements |
|---|-------|------|--------------|
| 1 | [Name] | [Goal] | [REQ-IDs] |
| 2 | [Name] | [Goal] | [REQ-IDs] |
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
git commit -m "docs: create roadmap ([N] phases)

All v1 requirements mapped to phases."
```

---

## Phase 9: Initialize Remaining Files

Create with templates:
- `.gsd/STATE.md` — Empty state
- `.gsd/DECISIONS.md` — Empty ADR log
- `.gsd/JOURNAL.md` — Empty journal
- `.gsd/TODO.md` — Empty todo list

Create directories:
- `.gsd/phases/`

---

## Phase 10: Done

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► PROJECT INITIALIZED ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

**[Project Name]**

| Artifact       | Location            |
|----------------|---------------------|
| Spec           | `.gsd/SPEC.md`      |
| Config         | `.gsd/config.json`  |
| Research       | `.gsd/research/`    |
| Requirements   | `.gsd/REQUIREMENTS.md` |
| Roadmap        | `.gsd/ROADMAP.md`   |

**[N] phases** | **[X] requirements** | Ready to build ✓

───────────────────────────────────────────────────────

## ▶ Next Up

**Phase 1: [Phase Name]** — [Goal from ROADMAP.md]

/discuss-phase 1 — Clarify scope and approach (recommended)
/plan 1 — Create Phase 1 execution plans

───────────────────────────────────────────────────────

💡 The questioning phase is the highest-leverage moment.
   Time invested here pays dividends throughout execution.

───────────────────────────────────────────────────────
```

</process>

<questioning_philosophy>
## Why Deep Questioning Matters

The original GSD emphasizes that `/new-project` is the most leveraged moment. 
Every minute spent understanding what to build saves hours of building the wrong thing.

**Signs questioning is done:**
- You could explain the project to a stranger
- You know what's NOT being built (scope edges)
- Success criteria are measurable
- You're excited to start planning

**Signs more questioning needed:**
- Vague terms remain unexplained
- You don't know who the user is
- Success is defined as "it works"
- Scope keeps expanding during discussion
</questioning_philosophy>

<success_criteria>
- [ ] .gsd/ directory created
- [ ] Git repo initialized
- [ ] Brownfield detection completed
- [ ] Deep questioning completed (threads followed, not rushed)
- [ ] SPEC.md captures full context → **committed**
- [ ] config.json has workflow mode, depth, preferences → **committed**
- [ ] Research completed (if selected) → **committed**
- [ ] Requirements gathered (from research or conversation)
- [ ] User scoped each category (v1/v2/out of scope)
- [ ] REQUIREMENTS.md created with REQ-IDs → **committed**
- [ ] Roadmap created with phases and requirement mappings
- [ ] User approved roadmap structure
- [ ] STATE.md initialized
- [ ] REQUIREMENTS.md traceability updated
- [ ] User knows next step is `/discuss-phase 1` or `/plan 1`
</success_criteria>

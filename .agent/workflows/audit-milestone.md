---
description: Audit milestone completion against original intent
argument-hint: "[version]"
---

# /audit-milestone Workflow

<objective>
Verify milestone achieved its definition of done. Check requirements coverage, cross-phase integration, and end-to-end flows.

Reads existing VERIFICATION.md files, aggregates tech debt, and spawns integration checker for cross-phase wiring.
</objective>

<context>
Values from:
- `.gsd/PROJECT.md` (Intent)
- `.gsd/REQUIREMENTS.md` (Scope)
- `.gsd/ROADMAP.md` (Plan)
- `.gsd/phases/*/*-VERIFICATION.md` (Results)
</context>

<process>

## Step 1: Resolve Configuration

Read model profile:
```bash
cat .gsd/config.json
```
Determine model for integration checker (high quality needed for audit).

## Step 2: Determine Scope

Identify phases in this milestone:
```bash
ls -d .gsd/phases/*/ | sort -V
```

Extract milestone Definition of Done from ROADMAP.md.

---

## Step 3: Phase Verification Audit

For each phase directory, read `VERIFICATION.md`.

**Extract:**
- Status: passed | gaps_found
- Critical gaps (blockers)
- Non-critical gaps (tech debt)
- Requirements coverage

If `VERIFICATION.md` missing, flag as critical blocker.

---

## Step 4: Cross-Phase Integration Check

**Invoking Integration Checker Skill:**

1. Read skill instructions:
```bash
cat .agent/skills/integration-checker/SKILL.md
```

2. Execute the skill instructions to:
   - Map phase exports and imports
   - detailed API route verification
   - Tracing end-to-end user flows across phases

**Collect Results:**
- Wiring gaps (Phase A exports X, Phase B expects Y)
- Broken flows
- Performance bottlenecks

---

## Step 5: Check Requirements Coverage

Match verified results against `REQUIREMENTS.md`.
- Satisfied: fully implemented and verified
- Partial: implemented but verify failed or has caveats
- Unsatisfied: missing or failed

---

## Step 6: Generate Audit Report

Create `.gsd/v{version}-MILESTONE-AUDIT.md`:

```markdown
# Milestone Audit: v{version}

**Details:**
- Date: {timestamp}
- Status: {passed | gaps_found | tech_debt}
- Score: {N}/{M} requirements

## Highlights
- {Major accomplishments}

## Gaps (Critical)
1. {Gap description} (Phase {X})
   - Impact: {why it blocks}

## Technical Debt (Deferred)
- [ ] {Item} (Phase {Y})

## Cross-Phase Issues
- {Integration gap detected by checker}

## Requirements Coverage
| Req ID | Status | Notes |
|--------|--------|-------|
| REQ-1  | ✅ | |
| REQ-2  | ❌ | Missing validation |
```

---

## Step 7: Present Results & Route

**If Passed:**
```
✓ Milestone v{version} Passed!
All requirements met. Integration verified.

▶ Next Up
/complete-milestone {version}
```

**If Gaps Found:**
```
⚠ Gaps Detected in v{version}
{count} critical gaps remain.

▶ Next Up
/plan-milestone-gaps — Plan fix phases
```

**If Tech Debt Only:**
```
⚡ Tech Debt Review
No blockers, but debt accumulated.

▶ Options
1. /complete-milestone {version} (Accept debt)
2. /plan-milestone-gaps (Fix now)
```

</process>

<success_criteria>
- [ ] Integration Checker skill utilized
- [ ] Full requirement coverage analysis
- [ ] Cross-phase issues identified
- [ ] Audit report created
- [ ] Smart routing based on result
</success_criteria>

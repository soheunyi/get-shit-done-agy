---
description: Configure GSD workflow toggles and preferences
---

# /settings Workflow

<objective>
Allow users to toggle workflow agents on/off and configure preferences via interactive settings.

Updates `.gsd/config.json` with workflow preferences.
</objective>

<process>

## 1. Validate Environment

```bash
test -f ".gsd/config.json"
```

**If not found:** Error - run `/new-project` first.

---

## 2. Read Current Config

```bash
cat .gsd/config.json
```

Parse current values (default to `true` if not present):
- `mode` — yolo or interactive
- `depth` — quick, standard, or comprehensive
- `workflow.research` — spawn researcher during plan
- `workflow.plan_check` — spawn plan checker during plan
- `workflow.verifier` — spawn verifier during execute
- `git.branching_strategy` — branching approach (default: `"none"`)

---

## 3. Present Settings

Present each setting with current value highlighted:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► SETTINGS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Current settings shown with [*]. Select to change.

1. Mode: How do you want to work?
   A) YOLO — Auto-approve, just execute
   B) Interactive — Confirm at each step

2. Depth: How thorough should planning be?
   A) Quick — Ship fast (3-5 phases, 1-3 plans each)
   B) Standard — Balanced scope and speed
   C) Comprehensive — Thorough coverage

3. Research: Spawn Plan Researcher? (researches domain before planning)
   A) Yes — Research phase goals before planning
   B) No — Skip research, plan directly

4. Plan Check: Spawn Plan Checker? (verifies plans before execution)
   A) Yes — Verify plans meet phase goals
   B) No — Skip plan verification

5. Verifier: Spawn Execution Verifier? (verifies phase completion)
   A) Yes — Verify must-haves after execution
   B) No — Skip post-execution verification

6. Git Branching: How to handle branches?
   A) None — Commit directly to current branch
   B) Per Phase — Create branch for each phase
   C) Per Milestone — Create branch for entire milestone
```

---

## 4. Update Config

Merge new settings into existing config.json:

```json
{
  "mode": "yolo|interactive",
  "depth": "quick|standard|comprehensive",
  "workflow": {
    "research": true|false,
    "plan_check": true|false,
    "verifier": true|false
  },
  "git": {
    "branching_strategy": "none|phase|milestone"
  }
}
```

Write updated config to `.gsd/config.json`.

---

## 5. Confirm Changes

Display:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► SETTINGS UPDATED ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

| Setting              | Value |
|----------------------|-------|
| Mode                 | {yolo/interactive} |
| Depth                | {quick/standard/comprehensive} |
| Plan Researcher      | {On/Off} |
| Plan Checker         | {On/Off} |
| Execution Verifier   | {On/Off} |
| Git Branching        | {None/Per Phase/Per Milestone} |

These settings apply to future /plan and /execute runs.

Quick overrides:
- /plan --research — force research
- /plan --skip-research — skip research
- /plan --skip-verify — skip plan check
```

</process>

<success_criteria>
- [ ] Current config read
- [ ] User presented with 6 settings
- [ ] Config updated with all sections
- [ ] Changes confirmed to user
</success_criteria>

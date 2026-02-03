---
description: Switch execution profile for GSD (quality/balanced/budget)
argument-hint: "<profile>"
---

# /set-profile Workflow

<objective>
Switch the execution profile used by GSD. This controls the tradeoff between thoroughness and speed.
</objective>

<profiles>
| Profile | Description |
|---------|-------------|
| **quality** | Maximum thoroughness — all research, all verification, comprehensive plans |
| **balanced** | Good quality/speed ratio — research enabled, verification enabled (default) |
| **budget** | Fast execution — skip research, minimal verification |
</profiles>

<process>

## 1. Validate Argument

```
if $ARGUMENTS.profile not in ["quality", "balanced", "budget"]:
  Error: Invalid profile "$ARGUMENTS.profile"
  Valid profiles: quality, balanced, budget
  STOP
```

---

## 2. Check for Project

```bash
test -f ".gsd/config.json"
```

If no `.gsd/` directory:
```
Error: No GSD project found.
Run /new-project first to initialize a project.
```

---

## 3. Update config.json

Read current config:
```bash
cat .gsd/config.json
```

Update or add profile-related settings based on selection:

**quality:**
```json
{
  "depth": "comprehensive",
  "workflow": {
    "research": true,
    "plan_check": true,
    "verifier": true
  }
}
```

**balanced:**
```json
{
  "depth": "standard",
  "workflow": {
    "research": true,
    "plan_check": true,
    "verifier": true
  }
}
```

**budget:**
```json
{
  "depth": "quick",
  "workflow": {
    "research": false,
    "plan_check": false,
    "verifier": false
  }
}
```

Write updated config to `.gsd/config.json`.

---

## 4. Confirm

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► PROFILE SET ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Profile: $ARGUMENTS.profile

Settings applied:
| Setting | Value |
|---------|-------|
| Depth | [depth] |
| Research | [On/Off] |
| Plan Check | [On/Off] |
| Verifier | [On/Off] |

Change individual settings with /settings.
```

</process>

<examples>

**Switch to budget mode:**
```
/set-profile budget

✓ Profile set to: budget

Settings applied:
| Setting | Value |
|---------|-------|
| Depth | quick |
| Research | Off |
| Plan Check | Off |
| Verifier | Off |
```

**Switch to quality mode:**
```
/set-profile quality

✓ Profile set to: quality

Settings applied:
| Setting | Value |
|---------|-------|
| Depth | comprehensive |
| Research | On |
| Plan Check | On |
| Verifier | On |
```

</examples>

<success_criteria>
- [ ] Argument validated
- [ ] Project exists validation
- [ ] Config updated with profile settings
- [ ] Confirmation shown to user
</success_criteria>

---
description: Update GSD to the latest version from GitHub
---

# /update Workflow

<objective>
Update GSD for Antigravity to the latest version from GitHub.
</objective>

<process>

## 1. Check Current Version

**PowerShell:**
```powershell
if (Test-Path "CHANGELOG.md") {
    $version = Select-String -Path "CHANGELOG.md" -Pattern "## \[(\d+\.\d+\.\d+)\]" | 
        Select-Object -First 1
    Write-Output "Current version: $($version.Matches.Groups[1].Value)"
}
```

**Bash:**
```bash
if [ -f "CHANGELOG.md" ]; then
    version=$(grep -oP '## \[\K[0-9]+\.[0-9]+\.[0-9]+' CHANGELOG.md | head -1)
    echo "Current version: $version"
fi
```

---

## 2. Fetch Latest from GitHub

```bash
# Clone latest to temp directory
git clone --depth 1 https://github.com/toonight/get-shit-done-for-antigravity.git .gsd-update-temp
```

---

## 3. Compare Versions

**PowerShell:**
```powershell
$remoteVersion = Select-String -Path ".gsd-update-temp/CHANGELOG.md" -Pattern "## \[(\d+\.\d+\.\d+)\]" | 
    Select-Object -First 1

Write-Output "Remote version: $($remoteVersion.Matches.Groups[1].Value)"
```

**Bash:**
```bash
remote_version=$(grep -oP '## \[\K[0-9]+\.[0-9]+\.[0-9]+' .gsd-update-temp/CHANGELOG.md | head -1)
echo "Remote version: $remote_version"
```

**If same version:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► ALREADY UP TO DATE ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Version: {version}

No updates available.

───────────────────────────────────────────────────────
```
Exit after cleanup.

---

## 4. Show Changes

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► UPDATE AVAILABLE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Current: {current-version}
Latest:  {remote-version}

Changes:
{Extract from CHANGELOG.md}

───────────────────────────────────────────────────────

Update now?
A) Yes — Apply updates
B) No — Cancel

───────────────────────────────────────────────────────
```

---

## 4. Validate & Preview Changes

**PowerShell:**
```powershell
# Validation
Write-Output "`nRunning validation on update package..."
if (Test-Path ".gsd-update-temp/scripts/validate-all.ps1") {
    & .gsd-update-temp/scripts/validate-all.ps1
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "VALIDATION FAILED in update package. Proceed with caution."
    }
}

# Diff Preview
Write-Output "`n--- FILE CHANGES (Diff against antigravity-support) ---"
git diff --no-index --stat antigravity-support .gsd-update-temp
```

**Bash:**
```bash
# Validation
echo -e "\nRunning validation on update package..."
if [ -f ".gsd-update-temp/scripts/validate-all.sh" ]; then
    chmod +x .gsd-update-temp/scripts/*.sh
    if ! .gsd-update-temp/scripts/validate-all.sh > /dev/null; then
       echo "⚠️  VALIDATION FAILED in update package. Proceed with caution."
    else
       echo "✅ Validation passed."
    fi
fi

# Diff Preview
echo -e "\n--- FILE CHANGES (Diff against antigravity-support) ---"
# Check for added/modified files
diff -rq --exclude=".git" antigravity-support .gsd-update-temp | grep -v "Only in antigravity-support"
```

---

## 5. Apply Updates

**If user confirms:**

**PowerShell:**
```powershell
# Backup current
Copy-Item -Recurse ".agent" ".agent.backup"
Copy-Item -Recurse ".gsd/templates" ".gsd/templates.backup"

# Update workflows and skills (preserve user's .gsd docs)
Copy-Item -Recurse -Force ".gsd-update-temp/.agent/*" ".agent/"

# Update templates only
Copy-Item -Recurse -Force ".gsd-update-temp/.gsd/templates/*" ".gsd/templates/"

# Update root files
Copy-Item -Force ".gsd-update-temp/GSD-STYLE.md" "./"
Copy-Item -Force ".gsd-update-temp/CHANGELOG.md" "./"

# Update antigravity-support (mirror)
Copy-Item -Recurse -Force ".gsd-update-temp/.agent/*" "antigravity-support/.agent/"
Copy-Item -Recurse -Force ".gsd-update-temp/.gsd/templates/*" "antigravity-support/.gsd/templates/"
Copy-Item -Force ".gsd-update-temp/GSD-STYLE.md" "antigravity-support/"
Copy-Item -Force ".gsd-update-temp/CHANGELOG.md" "antigravity-support/"
```

**Bash:**
```bash
# Backup current
cp -r .agent .agent.backup
cp -r .gsd/templates .gsd/templates.backup

# Update workflows and skills (preserve user's .gsd docs)
cp -r .gsd-update-temp/.agent/* .agent/

# Update templates only
cp -r .gsd-update-temp/.gsd/templates/* .gsd/templates/

# Update root files
cp .gsd-update-temp/GSD-STYLE.md ./
cp .gsd-update-temp/CHANGELOG.md ./

# Update antigravity-support (mirror)
cp -r .gsd-update-temp/.agent/* antigravity-support/.agent/
cp -r .gsd-update-temp/.gsd/templates/* antigravity-support/.gsd/templates/
cp .gsd-update-temp/GSD-STYLE.md antigravity-support/
cp .gsd-update-temp/CHANGELOG.md antigravity-support/
```

---

## 6. Cleanup

**PowerShell:**
```powershell
Remove-Item -Recurse -Force ".gsd-update-temp"
Remove-Item -Recurse -Force ".agent.backup"
Remove-Item -Recurse -Force ".gsd/templates.backup"
```

**Bash:**
```bash
rm -rf .gsd-update-temp
rm -rf .agent.backup
rm -rf .gsd/templates.backup
```

---

## 7. Confirm

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► UPDATED ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Updated to version {remote-version}

───────────────────────────────────────────────────────

/whats-new — See what changed

───────────────────────────────────────────────────────
```

</process>

<preserved_files>
These user files are NEVER overwritten:
- .gsd/SPEC.md
- .gsd/ROADMAP.md
- .gsd/STATE.md
- .gsd/ARCHITECTURE.md
- .gsd/STACK.md
- .gsd/DECISIONS.md
- .gsd/JOURNAL.md
- .gsd/TODO.md
- .gsd/phases/*
- .gemini/GEMINI.md
</preserved_files>

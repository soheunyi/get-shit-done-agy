---
description: Sync root development changes to antigravity-support distribution package
---

# /sync-agy Workflow

<objective>
Publish changes from the root development environment to the `antigravity-support` distribution package.
Ensures source-to-distribution consistency while sanitizing internal artifacts.
</objective>

<context>
Run this when you have made changes to:
- Workflows or Skills
- Templates
- Documentation or Structure

This ensures `antigravity-support` is ready for distribution/commit.
</context>

<process>

## 1. Safety & Sanitization Check

Ensure we aren't leaking specific internal patterns (like "Claude" references unless sanitized).

**PowerShell:**
```powershell
Write-Output "Running Sanitization Check..."
$forbidden = @("Claude", "Anthropic", "Sonnet")
$errors = 0

$files = Get-ChildItem -Recurse -Path .agent, .codex\skills, .gsd\templates -Include *.md, *.txt, *.json | Where-Object { $_.Name -ne "sync-agy.md" }
$files += Get-Item "AGENTS.md"
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    foreach ($term in $forbidden) {
        if ($content -match $term) {
            Write-Warning "SANITIZATION ERROR: Found '$term' in $($file.FullName)"
            $errors++
        }
    }
}

if ($errors -gt 0) {
    Write-Error "Found $errors sanitization errors. Fix them before syncing."
    exit 1
}
Write-Output "✅ Sanitization Clean"
```

**Bash:**
```bash
echo "Running Sanitization Check..."
forbidden=("Claude" "Anthropic" "Sonnet")
errors=0

# Find files in .agent, .codex/skills, AGENTS.md, and .gsd/templates (excluding hidden/binary if needed)
find .agent .codex/skills .gsd/templates AGENTS.md -type f \( -name "*.md" -o -name "*.txt" -o -name "*.json" \) ! -name "sync-agy.md" -print0 | while IFS= read -r -d '' file; do
    for term in "${forbidden[@]}"; do
        if grep -q "$term" "$file"; then
            echo "⚠️  SANITIZATION ERROR: Found '$term' in $file"
            ((errors++))
        fi
    done
done

# Note: Bash variable propagation from subshells can be tricky, checking exit code of grep approach
if grep -rE "Claude|Anthropic|Sonnet" .agent .codex/skills .gsd/templates AGENTS.md --exclude="sync-agy.md" > /dev/null; then
    echo "❌ Sanitization errors found. Aborting sync."
    grep -rE "Claude|Anthropic|Sonnet" .agent .codex/skills .gsd/templates AGENTS.md --exclude="sync-agy.md"
    exit 1
fi

echo "✅ Sanitization Clean"
```

---

## 2. Sync Directories

**PowerShell:**
```powershell
Write-Output "Syncing directories..."

# Sync .agent (Workflows & Skills)
Copy-Item -Recurse -Force ".agent" "antigravity-support/"

# Sync Codex artifacts
Copy-Item -Force "AGENTS.md" "antigravity-support/"
Copy-Item -Recurse -Force ".codex" "antigravity-support/"

# Sync Templates (Only templates, preserve consumer state)
if (-not (Test-Path "antigravity-support/.gsd")) { New-Item -ItemType Directory "antigravity-support/.gsd" }
Copy-Item -Recurse -Force ".gsd/templates" "antigravity-support/.gsd/"

# Sync Metadata
Copy-Item -Force "GSD-STYLE.md" "antigravity-support/"
Copy-Item -Force "CHANGELOG.md" "antigravity-support/"
Copy-Item -Force "LICENSE" "antigravity-support/"
Copy-Item -Force "VERSION" "antigravity-support/"

# Sync Scripts (Mapping .scripts/ -> .scripts/)
if (-not (Test-Path "antigravity-support/.scripts")) { New-Item -ItemType Directory "antigravity-support/.scripts" }
Copy-Item -Force ".scripts/validate-*" "antigravity-support/.scripts/"
```

**Bash:**
```bash
echo "Syncing directories..."

# Sync .agent
rm -rf antigravity-support/.agent
cp -r .agent antigravity-support/

# Sync Codex artifacts
rm -f antigravity-support/AGENTS.md
cp AGENTS.md antigravity-support/
rm -rf antigravity-support/.codex
cp -r .codex antigravity-support/

# Sync Templates
mkdir -p antigravity-support/.gsd
rm -rf antigravity-support/.gsd/templates
cp -r .gsd/templates antigravity-support/.gsd/

# Sync Metadata
cp GSD-STYLE.md antigravity-support/
cp CHANGELOG.md antigravity-support/
cp LICENSE antigravity-support/
cp VERSION antigravity-support/

# Sync Scripts (Mapping .scripts/ -> .scripts/)
# Only copy validators, skip build hooks
mkdir -p antigravity-support/.scripts
cp .scripts/validate-* antigravity-support/.scripts/
```

---

## 3. Verify Distribution Integrity

Run the validators *inside* the support package to ensure it works standalone.

**PowerShell:**
```powershell
Write-Output "Verifying distribution package..."
Push-Location "antigravity-support"
if (Test-Path ".scripts/validate-all.ps1") {
    & .scripts/validate-all.ps1
}
Pop-Location
```

**Bash:**
```bash
echo "Verifying distribution package..."
cd antigravity-support
if [ -f ".scripts/validate-all.sh" ]; then
    chmod +x .scripts/*.sh
    ./.scripts/validate-all.sh
fi
cd ..
```

---

## 4. Confirm

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 GSD ► SYNC COMPLETE ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Files synced:
- .agent/ (Workflows & Skills)
- AGENTS.md + .codex/skills/
- .gsd/templates/
- Metadata (CHANGELOG, VERSION, LICENSE)
- Validators (mapped to .scripts/)

Sanitization: Passed
Validation: Passed

Distribution package `antigravity-support` is ready commit.

───────────────────────────────────────────────────────
```

</process>

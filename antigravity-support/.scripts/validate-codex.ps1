# GSD Codex Validation Script
# Validates Codex AGENTS.md and skills structure

$ErrorCount = 0
$SkillsChecked = 0

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host " GSD ► VALIDATING CODEX" -ForegroundColor Cyan
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path "AGENTS.md")) {
    Write-Host "❌ AGENTS.md: Missing" -ForegroundColor Red
    $ErrorCount++
} else {
    $agents = Get-Content "AGENTS.md" -Raw
    if ($agents -notmatch "GSD for Codex CLI") {
        Write-Host "❌ AGENTS.md: Missing Codex header marker" -ForegroundColor Red
        $ErrorCount++
    } else {
        Write-Host "✅ AGENTS.md" -ForegroundColor Green
    }
}

if (-not (Test-Path ".codex/skills")) {
    Write-Host "❌ .codex/skills: Missing" -ForegroundColor Red
    $ErrorCount++
} else {
    $skills = Get-ChildItem ".codex/skills" -Directory
    foreach ($skill in $skills) {
        $SkillsChecked++
        $skillFile = Join-Path $skill.FullName "SKILL.md"
        $hasErrors = $false

        if (-not (Test-Path $skillFile)) {
            Write-Host "❌ $($skill.Name): Missing SKILL.md" -ForegroundColor Red
            $ErrorCount++
            continue
        }

        $content = Get-Content $skillFile -Raw

        if ($content -notmatch "^---") {
            Write-Host "❌ $($skill.Name): Missing frontmatter" -ForegroundColor Red
            $ErrorCount++
            $hasErrors = $true
        }

        if ($content -notmatch "name:") {
            Write-Host "❌ $($skill.Name): Missing name in frontmatter" -ForegroundColor Red
            $ErrorCount++
            $hasErrors = $true
        }

        if ($content -notmatch "description:") {
            Write-Host "❌ $($skill.Name): Missing description in frontmatter" -ForegroundColor Red
            $ErrorCount++
            $hasErrors = $true
        }

        if ($content -notmatch "@GSD_ROOT@|\.codex/|~/.codex/") {
            Write-Host "❌ $($skill.Name): Missing source-of-truth path placeholder" -ForegroundColor Red
            $ErrorCount++
            $hasErrors = $true
        }

        if (-not $hasErrors) {
            Write-Host "✅ $($skill.Name)" -ForegroundColor Green
        }
    }
}

Write-Host ""
Write-Host "───────────────────────────────────────────────────────" -ForegroundColor Gray
Write-Host ""
Write-Host "Codex skills checked: $SkillsChecked"
Write-Host "Errors: $ErrorCount" -ForegroundColor $(if ($ErrorCount -gt 0) { "Red" } else { "Green" })
Write-Host ""

if ($ErrorCount -eq 0) {
    Write-Host "✅ Codex artifacts valid!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "❌ Validation failed" -ForegroundColor Red
    exit 1
}

#!/bin/bash
# GSD Codex Validation Script
# Validates Codex AGENTS.md and skills structure

error_count=0
codex_skills_checked=0

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " GSD ► VALIDATING CODEX"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ ! -f "AGENTS.md" ]; then
    echo "❌ AGENTS.md: Missing"
    ((error_count++))
else
    if ! grep -q "GSD for Codex CLI" "AGENTS.md"; then
        echo "❌ AGENTS.md: Missing Codex header marker"
        ((error_count++))
    else
        echo "✅ AGENTS.md"
    fi
fi

if [ ! -d ".codex/skills" ]; then
    echo "❌ .codex/skills: Missing"
    ((error_count++))
else
    for skill_dir in .codex/skills/*/; do
        [ -d "$skill_dir" ] || continue
        ((codex_skills_checked++))
        skill_name=$(basename "$skill_dir")
        skill_file="$skill_dir/SKILL.md"
        has_errors=false

        if [ ! -f "$skill_file" ]; then
            echo "❌ $skill_name: Missing SKILL.md"
            ((error_count++))
            continue
        fi

        if ! head -1 "$skill_file" | grep -q "^---"; then
            echo "❌ $skill_name: Missing frontmatter"
            ((error_count++))
            has_errors=true
        fi

        if ! grep -q "name:" "$skill_file"; then
            echo "❌ $skill_name: Missing name in frontmatter"
            ((error_count++))
            has_errors=true
        fi

        if ! grep -q "description:" "$skill_file"; then
            echo "❌ $skill_name: Missing description in frontmatter"
            ((error_count++))
            has_errors=true
        fi

        if ! grep -q "@GSD_ROOT@\|\.codex/\|~/.codex/" "$skill_file"; then
            echo "❌ $skill_name: Missing source-of-truth path placeholder"
            ((error_count++))
            has_errors=true
        fi

        if [ "$has_errors" = false ]; then
            echo "✅ $skill_name"
        fi
    done
fi

echo ""
echo "───────────────────────────────────────────────────────"
echo ""
echo "Codex skills checked: $codex_skills_checked"
echo "Errors: $error_count"
echo ""

if [ $error_count -eq 0 ]; then
    echo "✅ Codex artifacts valid!"
    exit 0
else
    echo "❌ Validation failed"
    exit 1
fi

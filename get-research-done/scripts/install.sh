#!/bin/bash
set -euo pipefail

ROOT="${1:-.}"
mkdir -p "$ROOT/.agent/skills" "$ROOT/.codex/skills" "$ROOT/.gsd/templates"

cp -R get-research-done/.agents/skills/* "$ROOT/.agent/skills/"
cp -R get-research-done/.codex/skills/* "$ROOT/.codex/skills/"
cp get-research-done/templates/research-notes.md "$ROOT/.gsd/templates/research-notes.md"
cp get-research-done/templates/wandb-config.md "$ROOT/.gsd/templates/wandb-config.md"

echo "Installed get-research-done pack into $ROOT"
echo "Use Codex skills: $grd-research-hypothesis-designer, $grd-research-experiment-planner, $grd-research-evaluation-analyst"

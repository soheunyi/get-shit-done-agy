---
created: 2026-02-03T18:59:52Z
title: Implement interactive validation in /update workflow
area: workflow
files:
  - .agent/workflows/update.md
---

## Problem
Blindly copying updates from upstream runs the risk of polluting `antigravity-support` with invalid or incompatible code.

## Solution
Modify `/update` to fetch to temp, run validation scripts, show a diff, and require explicit user confirmation before applying changes.

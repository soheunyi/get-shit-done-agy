---
created: 2026-02-03T13:54:31
title: Update /update workflow to sync antigravity-support
area: workflow
files:
  - .agent/workflows/update.md
---

## Problem
The current `/update` workflow only updates the root `.agent` and `.gsd` directories, ignoring the `antigravity-support` directory. This causes the "source" of the Antigravity distribution to become stale when updates are applied.

## Solution
Modify `.agent/workflows/update.md` to also update `antigravity-support` when it runs, keeping both the root and the support package in sync.

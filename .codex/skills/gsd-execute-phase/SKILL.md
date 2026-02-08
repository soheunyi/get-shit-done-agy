---
name: "gsd-execute-phase"
description: "Execute all plans in a phase with wave-based parallelization"
---

# Codex GSD Skill: gsd-execute-phase

<when_to_use>
Use this skill when the user asks for `gsd:execute-phase`, `/execute`, or an equivalent natural-language request.
</when_to_use>

<source_of_truth>
Follow the canonical workflow instructions in `@GSD_ROOT@commands/gsd/execute-phase.md`. Treat that file as authoritative behavior.
</source_of_truth>

<execution_contract>
1. Parse user arguments exactly as provided after the command alias.
2. Execute the workflow process from `@GSD_ROOT@commands/gsd/execute-phase.md` end to end.
3. Preserve GSD methodology rules: planning lock, state persistence, empirical validation, and context hygiene.
4. If command alias differs from canonical name, preserve behavior and only adapt invocation format.
</execution_contract>

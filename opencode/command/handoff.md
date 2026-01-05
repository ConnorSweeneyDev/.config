---
description: Save session state for continuation in a new chat
agent: plan
---

Create a context handoff document for session continuation. The handoff should be comprehensive yet concise, adapting to
the specific work being done.

## Gather Context
1. Review the current todo list (if any)
2. Review the current phase of work and overall objectives
3. Check git state: !`git log --oneline -10` and !`git status --short`
4. Identify the type of work being done (feature dev, debugging, refactoring, exploration, etc.)

## Create Adaptive Handoff
Use the following structure, **adapting sections based on what's relevant**:

```
# Context Handoff

## Objective
[1-2 sentences: What are we trying to accomplish?]

## Current Status
[Brief summary: Where are we in the process? What phase/stage?]

## Work Done This Session
[Bullet list of completed items - be specific about outcomes, not just actions]

## Active State
[Include relevant subsections as needed:]

### Modified Files
- `path/to/file`: [Purpose/changes]

### Key Decisions & Rationale
- [Decision]: [Why this approach was chosen]

### Architecture/Design Notes
[Only if relevant - patterns, structure, important constraints]

### Dependencies & Integration Points
[Only if relevant - external APIs, services, other modules]

### Test Coverage
[Only if relevant - what's tested, what needs testing]

### Configuration Changes
[Only if relevant - env vars, config files, feature flags]

## Context for Next Agent

### Immediate Next Action
[The single most important next step]

### Subsequent Steps
- [Ordered list of following actions]

### Known Issues/Blockers
[Be specific about problems and any attempted solutions, or "None"]

### Important Notes
[Anything else the next agent needs to know - gotchas, constraints, user preferences]
```

## Guidelines
- **Be selective**: Only include sections with meaningful information
- **Be specific**: Use file paths with line numbers where relevant
- **Be concise**: Prefer bulleted facts over prose
- **Prioritize**: Lead with what matters most for continuation
- **Contextualize**: Explain *why* decisions were made, not just what was done

## Output
Output only the completed handoff document with no additional commentary, formatted for easy copy-paste.

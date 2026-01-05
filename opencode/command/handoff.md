---
description: Save session state for continuation in a new chat
agent: plan
---

Create a context handoff document for session continuation.

## Gather Context
1. Review the current todo list (if any).

2. Review the current phase of the plan/implementation that you are on.

3. Review current local git changes:
   !`git log --oneline -10`
   !`git status --short`

## Create Handoff
Use this format:
```
# Context Handoff

## Project
Brief description of what we're working on.

## Active Plan
Somewhat short summary of current status.

## Work Completed This Session
- Bullet list of completed items.

## Key Files
List of files and their changes / what the purpose was:
- `path/to/file`: What it does / what was changed

## Important Decisions
- Decision made and why.

## Blockers or Issues
- Any unresolved problems (or "None").

## Next Steps
- Immediate next action
- Following actions
```

## Output
You should output the completed handoff, and only the handoff, so that it is easily pasteable. Do not include any
additional commentary or explanation.

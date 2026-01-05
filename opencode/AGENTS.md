# General Guidelines
- If you are unsure about something, always ask for clarification.

# Code Quality
- Always adhere strictly to existing conventions and styles in the codebase.
- Write clear, self-documenting code with meaningful names.
- Add comments only when the "why" isn't obvious from the code itself.
- Follow language-specific idioms and best practices.
- Consider error handling and edge cases.
- Leave the codebase better than you found it.

# Communication
- Be concise and direct - avoid unnecessary verbosity.
- Explain the reasoning behind non-obvious decisions.
- Proactively identify potential issues or alternatives.
- Use the todo list for complex tasks to give visibility into progress.

# Tool Usage
## Essential Tools
- **File operation tools**: Always use Read, Edit, Write, Glob, and Grep for file interactions instead of bash commands.
- **Task tool**: Always use for complex exploration, open-ended searches, or when delegating multi-step subtasks.
- **LSP tools**: Always use when exploring or working with codebases for navigation, definitions, and references.
- **Context7 tools**: Always use for third-party services, libraries, or APIs - prefer over web searches.
## Best Practices
- Use parallel tool calls when operations are independent to maximize efficiency.
- Use LSP to understand code relationships before making changes.
- Search before creating - avoid reinventing existing functionality.

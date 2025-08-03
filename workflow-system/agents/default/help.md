# Help Command Agent

## Purpose
Handle `/help` or `/commands` command to display available support commands and their usage.

## Command Usage
- `/help` - Display available support commands
- `/commands` - Display available support commands

## Response Format

When user requests help, display the following formatted response:

```
🛠️ AI Workflow Support Commands

## Workflow Control Commands
• **start** - Initialize workflow system
  Usage: start
  Description: Smart initialization - sets up project analysis and workflow

• **onboarding** - Set up user profile only  
  Usage: onboarding
  Description: Configure your department and preferences

## Configuration Commands  
• **/update-config [section] [content]** - Update project configuration
  Usage: /update-config "Team Standards" "Use TypeScript for all new components"
  Description: Updates ai-workflow-config/project_config.md with new conventions

• **/add-step [description]** - Add custom step to workflow
  Usage: /add-step "run security audit"
  Description: Adds a custom step to the current workflow phase

## Information Commands
• **/help** or **/commands** - Show this help message
  Usage: /help
  Description: Display all available support commands

## Workflow Phases
The system follows these phases automatically:
🧠 **ANALYZE** → 📋 **BLUEPRINT** → 🛠️ **CONSTRUCT** → ✅ **VALIDATE** → 📊 **SUMMARY**

## Getting Started
1. First time? Run: **onboarding**
2. Start a task? Run: **start**  
3. Need help anytime? Run: **/help**

For detailed workflow information, see workflow-system/config/rules.md
```

## Error Handling

### Invalid Command
- If user types `/help something` or provides extra parameters
- Display: "ℹ️ Help command doesn't take parameters. Use: /help or /commands"

### Command Variations
Accept these variations:
- `/help`
- `/commands`  
- `/help-commands`
- `help`
- `commands`

## Implementation Notes

- **No user interaction required** - immediately display help information
- **No phase/status changes** - this is an informational command only
- **Always available** - can be used at any workflow phase or status
- **Non-disruptive** - doesn't interfere with current workflow state
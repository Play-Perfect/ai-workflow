# AI Multi-Agent Workflow – Lean Execution System

## Files
- `workflow-system/user_config.json` – Generated user configuration, department, preferences, integration settings
- `workflow-system/config/user_config_template.json` – Template for user config generation
- `workflow-system/context/project_config.md` – Generated project analysis, tech stack, patterns, constraints
- `workflow-system/context/project_config_template.md` – Template for project config generation
- `workflow-system/context/workflow_state.md` – Template for session state tracking  
- `workflow-system/agents/{department}/{phase}.md` – Department-specific agent configurations

## Core Loop
1. Agent reads session `workflow_state.md` → `Phase`, `Status`, `Department`
2. Reads `workflow-system/user_config.json` (generated) → user settings, integrations, department
3. Reads `workflow-system/context/project_config.md` (generated) → constraints, patterns, tech stack
4. Loads `workflow-system/agents/{department}/{phase}.md` → specialized agent context
5. Executes by phase: **INIT** → **ANALYZE** → **BLUEPRINT** → **CONSTRUCT** → **VALIDATE**
6. Auto-rotates logs, archives blueprints, updates metrics, triggers integrations

## Phase Flow
**INIT**: User onboarding → Department initialization → Project config creation → Session file creation  
**ANALYZE**: Context gathering → Jira querying → Confluence search → Requirements analysis  
**BLUEPRINT**: Implementation planning → User approval → Jira sub-task creation  
**CONSTRUCT**: Plan execution → Testing → Progress tracking → Checkpoint management  
**VALIDATE**: Quality assurance → Documentation → Notifications → Completion

## Automation Rules
- **INIT handling**: Multi-step user setup → onboarding → department init → project config → session creation
- **User config generation**: Creates workflow-system/user_config.json from template on first run
- **Project config generation**: Creates project_config.md from template with real project analysis
- **Session management**: Auto-creates timestamped session files with unique IDs
- **Adaptive execution**: Simple tasks skip BLUEPRINT; complex tasks add pre-validation
- **Agent selection**: Auto-loads department-specific agents per phase  
- **Log rotation**: Auto-archives when logs exceed 5K characters
- **Integration triggers**: Jira updates, Confluence docs, Slack notifications
- **Pattern reuse**: Leverages successful approaches from archived sessions
- **Rollback capability**: Checkpoint-based recovery on failures
- **Field-specific updates**: Preserves existing workflow-system/user_config.json values during updates

## Department Support
- **dev**: Engineering workflows with technical focus
- **pm**: Product management with business requirements  
- **bi**: Business intelligence with data analysis
- **devops**: Infrastructure and deployment workflows
- **design**: UX/UI and design system workflows  
- **qa**: Quality assurance and testing workflows

## Communication Patterns
- 📁 **INIT**: "Creating workflow session..."  
- 🧠 **ANALYZE**: "Analyzing with {Department}-Analyzer..."
- 📋 **BLUEPRINT**: "Creating plan with {Department}-Blueprinter..."  
- 🛠️ **CONSTRUCT**: "Implementing with {Department}-Constructor..."
- ✅ **VALIDATE**: "Validating with {Department}-Validator..."
- 🎉 **COMPLETED**: "Workflow completed! Adding to changelog."

## Setup
System prompt: **MUST follow @workflow-system/config/rules.md**

All workflow logic, phases, rules, and instructions are defined in this file.
Agent loads workflow state → project config → department agent → executes phase → updates state.
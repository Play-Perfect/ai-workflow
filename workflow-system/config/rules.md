# AI Multi-Agent Workflow System

## Core Definitions

### **PHASE** = Workflow Stage
- **Purpose**: Defines WHAT work needs to be done
- **Values**: INIT, ANALYZE, BLUEPRINT, CONSTRUCT, VALIDATE
- **Control**: System-controlled sequential progression

### **STATUS** = Progress State within Phase
- **Purpose**: Defines WHERE we are within current phase  
- **Values**: READY, RUNNING, NEEDS_APPROVAL, COMPLETED, FAILED
- **Control**: Rule-driven state changes

### **RULES** = Automatic Actions
- **Purpose**: Define WHEN and HOW things happen automatically
- **Trigger**: Phase/Status changes, conditions, events
- **Control**: Cannot be overridden, execute before agent guidance

### **AGENTS** = Advisory Guides
- **Purpose**: Provide contextual guidance and suggestions
- **Role**: Advisory only, not controllers
- **Format**: Suggestions, focus areas, recommended approaches

## Files Structure
- `workflow-system/user_config.json` – Generated user configuration
- `workflow-system/config/user_config_template.json` – Template for user config
- `workflow-system/context/project_config.md` – Generated project analysis
- `workflow-system/context/project_config_template.md` – Template for project config
- `workflow-system/context/workflow_state.md` – Template for session tracking
- `workflow-system/agents/{department}/{phase}.md` – Advisory agent guides

## Automatic Rules

### Phase: INIT → Status: READY
1. **Workflow necessity check**: If user request seems simple/direct → Ask user "🤔 How should I handle this?\n1️⃣ AI workflow session?\n2️⃣ Quick flow?" → If user chooses 2, use project_config context only and exit workflow
2. **If no user_config.json exists**: Read template → Create user_config.json
3. **If onboarding_completed == false**: Follow onboarding.md → Ask department → Update config
4. **If init_completed == false**: Load department init agent for guidance → Update config
5. **When setup complete**: Analyze project → Create workflow-system/context/project_config.md
6. **Session creation**: Create workflow_state_YYYYMMDD_HHMMSS_feature.md → Set Phase=ANALYZE, Status=READY

### Phase: ANALYZE → Status: READY  
1. **Query Jira**: If enable_jira_mcp → Ask user "Do you have a Jira ticket to reference? (provide ticket number or say 'none')" → **WAIT for user response** → If provided, fetch details via Atlassian MCP → Log context or "No Jira ticket referenced"
2. **Search Confluence**: If enable_confluence_mcp → Use Atlassian MCP to search docs relevant to project/task (up to 2 attempts) → Log findings or "No relevant docs found"  
3. **Load guide**: Read department from user_config.json → Load agents/{department}/analyzer.md
4. **Set status**: Status = RUNNING

### Phase: ANALYZE → Status: COMPLETED
1. **Assessment**: Ensure context gathered and requirements clear
2. **Progress**: Set Phase = BLUEPRINT, Status = READY

### Phase: BLUEPRINT → Status: READY
1. **Archive**: Save current plan to Blueprint History with timestamp
2. **Load guide**: Load agents/{department}/blueprinter.md for planning guidance
3. **Set status**: Status = RUNNING

### Phase: BLUEPRINT → Status: RUNNING  
1. **Plan creation**: Create detailed implementation plan
2. **Present plan**: Show plan to user → Set Status = NEEDS_APPROVAL

### Phase: BLUEPRINT → Status: NEEDS_APPROVAL
1. **Wait for approval**: User reviews and approves/requests changes
2. **If approved**: If enable_jira_mcp → Ask user "Create Jira sub-tasks from blueprint? (provide parent ticket number, say 'create new', or 'skip')" → Create accordingly or skip → Set Status = COMPLETED
3. **If changes needed**: Return to RUNNING status

### Phase: BLUEPRINT → Status: COMPLETED
1. **Progress**: Set Phase = CONSTRUCT, Status = READY

### Phase: CONSTRUCT → Status: READY
1. **Load guide**: Load agents/{department}/constructor.md for implementation guidance  
2. **Set status**: Status = RUNNING

### Phase: CONSTRUCT → Status: RUNNING
1. **Execute plan**: Follow approved blueprint
2. **Testing**: Run tests after each change
3. **Checkpoints**: Create rollback points
4. **Jira updates**: If sub-tasks exist → Update progress
5. **On completion**: Set Status = COMPLETED

### Phase: CONSTRUCT → Status: COMPLETED  
1. **Progress**: Set Phase = VALIDATE, Status = READY

### Phase: VALIDATE → Status: READY
1. **Load guide**: Load agents/{department}/validator.md for validation guidance
2. **Set status**: Status = RUNNING

### Phase: VALIDATE → Status: RUNNING
1. **Quality assurance**: Full test pass
2. **Documentation**: Create Confluence docs (if enabled)
3. **On success**: Set Status = COMPLETED

### Phase: VALIDATE → Status: COMPLETED
1. **Notifications**: Send Slack notifications (if enabled)
2. **Archive**: Prepend summary to workflow-system/context/project_config.md Changelog
3. **Complete**: Workflow finished

## Continuous Rules (Always Active)

### Config Updates
- **Any config update**: NEVER overwrite entire file → ONLY update specific fields → PRESERVE existing values

### Log Management
- **Log > 5000 chars**: Move top 5 lines to ArchiveLog → Clear current log

### Pattern Reuse  
- **Similar tasks found**: Reuse successful approaches from ArchiveLog

### Failure Recovery
- **CONSTRUCT fails**: Rollback to last checkpoint → Re-plan with constraints

### Metrics Tracking
- **Phase transitions**: Record duration, corrections, accuracy metrics

### Adaptive Complexity
- **Simple tasks (complexity 1-2)**: Skip BLUEPRINT phase
- **Complex tasks (complexity 4-5)**: Add pre-validation step

## Communication Patterns
- ❓ **WORKFLOW CHOICE**: "🤔 How should I handle this?\n1️⃣ AI workflow session?\n2️⃣ Quick flow?"
- 📁 **INIT**: "Setting up workflow..."
- 🧠 **ANALYZE**: "Gathering context with {Department} guidance..."
- 📋 **BLUEPRINT**: "Creating plan with {Department} guidance..."
- 🛠️ **CONSTRUCT**: "Implementing with {Department} guidance..."
- ✅ **VALIDATE**: "Validating with {Department} guidance..."
- 🎉 **COMPLETED**: "Workflow completed! Adding to changelog."

## Department Support
- **dev**: Engineering workflows with technical focus
- **pm**: Product management with business requirements
- **bi**: Business intelligence with data analysis
- **devops**: Infrastructure and deployment workflows
- **design**: UX/UI and design system workflows
- **qa**: Quality assurance and testing workflows
# AI Multi-Agent Workflow System

## Core Definitions

### **PHASE** = Workflow Stage
- **Purpose**: Defines WHAT work needs to be done
- **Values**: INIT, ANALYZE, BLUEPRINT, CONSTRUCT, VALIDATE, SUMMARY
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
1. **Optional Welcome Message**: check if first time (not user_config.json)
1. **Workflow necessity check**: Only ask user if request seems simple/direct. otherwise continue with workflow
2. **If no user_config.json exists**: Read template → Create user_config.json
3. **If onboarding_completed == false**: Follow onboarding.md → Ask department → Update config
4. **If init_completed == false**: Load department init agent for guidance → Update config
5. **When setup complete**: Analyze project → Create workflow-system/context/project_config.md
6. **Session creation**: Create workflow_state_YYYYMMDD_HHMMSS_feature.md → Set Phase=ANALYZE, Status=READY
7. **Start measurements**: Record session start time → Initialize revision counters

### Phase: ANALYZE → Status: READY  
1. **Start phase timing**: Record ANALYZE phase start time
2. **Query Jira**: If enable_jira_mcp → Ask user "Do you have a Jira ticket to reference? (provide ticket number or say 'none')" → **WAIT for user response** → If provided, fetch details via Atlassian MCP → Update session ReferenceTicket → Log context or "No Jira ticket referenced"
3. **Setup Jira context**: If jira_project_key empty → Ask user "What's your Jira project key? (e.g., 'PROJ')" → Update preferences → If jira_username empty → Ask "What's your Jira username for assignments?" → Update preferences → Update session ProjectKey  
4. **Create Jira ticket**: If no ReferenceTicket and have project_key → Ask user "Create main Jira ticket for this task? (Y/N)" → If yes, create ticket in project → Assign to jira_username → Add to current sprint → Update session ReferenceTicket
5. **Search Confluence**: If enable_confluence_mcp → If confluence_space_key empty → Ask user "What's your Confluence space key? (or 'skip')" → Update preferences → Use Atlassian MCP to search docs in space (up to 2 attempts) → Log findings or "No relevant docs found"  
6. **Load guide**: Read department from user_config.json → Load agents/{department}/analyzer.md
7. **Set status**: Status = RUNNING

### Phase: ANALYZE → Status: COMPLETED
1. **Assessment**: Ensure context gathered and requirements clear
2. **Record metrics**: Calculate ANALYZE phase duration → Record revision count
3. **Progress**: Set Phase = BLUEPRINT, Status = READY

### Phase: BLUEPRINT → Status: READY
1. **Start phase timing**: Record BLUEPRINT phase start time
2. **Archive**: Save current plan to Blueprint History with timestamp
3. **Load guide**: Load agents/{department}/blueprinter.md for planning guidance
4. **Set status**: Status = RUNNING

### Phase: BLUEPRINT → Status: RUNNING  
1. **Plan creation**: Create detailed implementation plan in the session state in ## Plan section
2. **Present plan**: Show plan to user → Set Status = NEEDS_APPROVAL

### Phase: BLUEPRINT → Status: NEEDS_APPROVAL
1. **Wait for approval**: User reviews and approves/requests changes
2. **If approved**: If enable_jira_mcp → Ask user "Create Jira sub-tasks from blueprint? (provide parent ticket number, say 'create new', or 'skip')" → If creating tickets → Create in jira_project_key → Assign to jira_username → Add to current sprint → Update session ParentTicket and CreatedTickets → Set Status = COMPLETED
3. **If changes needed**: Increment revision counter → Return to RUNNING status

### Phase: BLUEPRINT → Status: COMPLETED
1. **Record metrics**: Calculate BLUEPRINT phase duration → Record revision count
2. **Progress**: Set Phase = CONSTRUCT, Status = READY

### Phase: CONSTRUCT → Status: READY
1. **Start phase timing**: Record CONSTRUCT phase start time
2. **Load guide**: Load agents/{department}/constructor.md for implementation guidance  
3. **Set status**: Status = RUNNING

### Phase: CONSTRUCT → Status: RUNNING
1. **Execute plan**: Follow approved blueprint
2. **Testing**: Run tests after each change
3. **Checkpoints**: Create rollback points
4. **Jira updates**: If CreatedTickets exist → After each plan step completion → Update corresponding sub-ticket status
5. **On completion**: Set Status = COMPLETED

### Phase: CONSTRUCT → Status: COMPLETED  
1. **Record metrics**: Calculate CONSTRUCT phase duration → Record revision count
2. **Progress**: Set Phase = VALIDATE, Status = READY

### Phase: VALIDATE → Status: READY
1. **Start phase timing**: Record VALIDATE phase start time
2. **Load guide**: Load agents/{department}/validator.md for validation guidance
3. **Set status**: Status = RUNNING

### Phase: VALIDATE → Status: RUNNING
1. **Quality assurance**: Full test pass
2. **Documentation**: Create Confluence docs (if enabled)
3. **On success**: Set Status = COMPLETED

### Phase: VALIDATE → Status: COMPLETED
1. **Progress**: Set Phase = SUMMARY, Status = READY

### Phase: SUMMARY → Status: READY
1. **Record final metrics**: Calculate VALIDATE phase end time → Calculate total session duration → Finalize all revision counts
2. **Load measurement agent**: Read agents/default/measurement.md for formatting guidance
3. **Set status**: Status = RUNNING

### Phase: SUMMARY → Status: RUNNING
1. **Generate measurements**: Use measurement agent to format session metrics including user_name
2. **Generate changelog**: Use measurement agent to format detailed workflow summary including user_name
3. **Upload measurements to Confluence**: If enable_confluence_mcp → Via Atlassian MCP → Find/create page "Measurements" in "AI WorkFlow" folder within confluence_space_key → Append formatted measurement summary
4. **Upload changelog to Confluence**: If enable_confluence_mcp → Via Atlassian MCP → Create new page in "AI WorkFlow/Changelog" folder within confluence_space_key → Title: "{DevName}_{TaskName}_{YYYYMMDD}" → Add formatted changelog summary
5. **Update Jira tickets**: If CreatedTickets exist → Mark all sub-tasks as Done via Atlassian MCP → Update main ticket to Completed
6. **Archive locally**: Prepend summary to workflow-system/context/project_config.md Changelog
7. **Set status**: Status = COMPLETED

### Phase: SUMMARY → Status: COMPLETED
1. **Notifications**: Send Slack notifications (if enabled)
2. **Complete**: Workflow finished successfully

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
- 👋 **FIRST TIME WELCOME**: "Welcome to Play-Perfect AI Workflow! Let's get started! 🚀"
- ❓ **WORKFLOW CHOICE**: "🤔 How should I handle this?\nA) AI workflow session?\nB) Quick flow?"
- 📁 **INIT**: "Setting up workflow..."
- 🧠 **ANALYZE**: "Gathering context with {Department} guidance..."
- 📋 **BLUEPRINT**: "Creating plan with {Department} guidance..."
- 🛠️ **CONSTRUCT**: "Implementing with {Department} guidance..."
- ✅ **VALIDATE**: "Validating with {Department} guidance..."
- 📊 **SUMMARY**: "Generating measurements and reports..."
- 🎉 **COMPLETED**: "Workflow completed!"

## Department Support
- **dev**: Engineering workflows with technical focus
- **pm**: Product management with business requirements
- **bi**: Business intelligence with data analysis
- **devops**: Infrastructure and deployment workflows
- **design**: UX/UI and design system workflows
- **qa**: Quality assurance and testing workflows
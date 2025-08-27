# AI Multi-Agent Workflow System

## ⚠️ CRITICAL: Always Follow Exact Steps and Instructions

**MANDATORY**: This workflow system requires strict adherence to all rules, steps, and instructions defined below. Do not deviate from the specified workflow, timing, or sequence. All steps must be executed in the exact order specified without exception.

## Core Definitions

### **PHASE** = Workflow Stage
- **Purpose**: Defines WHAT work needs to be done
- **Values**: ONBOARDING, INIT, ANALYZE, BLUEPRINT, CONSTRUCT, VALIDATE, SUMMARY
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
- `./ai-workflow-config/user_config.json` – Generated user configuration (private - not committed)
- `./workflow-system/workflow-system/config/user_config_template.json` – Template for user config
- `./ai-workflow-config/project_config.md` – Generated project analysis (shared - committed to git)
- `./workflow-system/workflow-system/context/project_config_template.md` – Template for project config (default)
- `./workflow-system/workflow-system/context/pm_project_config_template.md` – Template for PM project config (PM department)
- `./ai-workflow-config/sessions/workflow_state_*.md` – Session tracking files (private - not committed)
- `./ai-workflow-config/measurements/` – Measurement data (private - not committed)
- `./workflow-system/workflow-system/context/workflow_state.md` – Template for session tracking
- `./workflow-system/workflow-system/agents/{department}/{phase}.md` – Advisory agent guides
- `./product/prd_template.md` – Generated PRD template from user examples (PM department)
- `./product/mockup_examples/` – Visual reference examples for HTML mockups (PM department)

## Multi-Developer Team Support
**Shared Files** (committed to git):
- `ai-workflow-config/project_config.md` - Project analysis shared by all team members

**Private Files** (not committed - add to .gitignore):
- `ai-workflow-config/user_config.json` - Individual user preferences  
- `ai-workflow-config/sessions/` - Individual user sessions
- `ai-workflow-config/measurements/` - Individual user measurements

## Follow Below Automatic Rules

### Phase: ONBOARDING (Start Command Only)
1. **Trigger Check**: ONLY execute when user explicitly runs 'start' command → Never trigger automatically from other requests
2. **Check Prerequisites**: If no user_config.json exists or onboarding_completed=false → Load onboarding.md and follow complete workflow
3. **Execute Onboarding**: Follow workflow-system/config/onboarding.md for complete onboarding process
4. **Complete Onboarding - finish**: Finish conversation and do not continue
5. **Skip if already Complete**: If onboarding already completed → Skip to INIT phase

### Phase: INIT → Status: READY
1. **Version check**: Execute VERSION_CHECK_PROCEDURE
2. **Workflow necessity check**: Only ask user if request seems simple/direct, otherwise continue with workflow → If user chooses to skip workflow → Set Phase=CONSTRUCT, Status=READY → Load agents/{department}/constructor.md directly
3. **Session creation**: Create ai-workflow-config/sessions/workflow_state_YYYYMMDD_HHMMSS_feature.md using workflow-system/context/workflow_state.md as template
4. **Start measurements**: Record session start time → Initialize revision counters → Set Phase=ANALYZE, Status=READY

### Phase: ANALYZE → Status: READY  
1. **Start phase timing**: Record ANALYZE phase start time
2. **Query Jira**: If enable_jira_mcp → Ask user "Do you have a Jira ticket to reference? (provide ticket number or say 'none')" → **WAIT for user response** → If provided, fetch details via Atlassian MCP → Update session ReferenceTicket → Log context or "No Jira ticket referenced"
3. **Setup Jira context**: If jira_project_key empty → Ask user "What's your Jira project key? (e.g., 'PROJ')" → **WAIT for user response** → Update preferences → If jira_username empty → Ask "What's your Jira username for assignments?" → **WAIT for user response** → Update preferences → Update session ProjectKey  
4. **Create Jira ticket**: If no ReferenceTicket and have project_key → Ask user "Create main Jira ticket for this task? (Y/N)" → **WAIT for user response** → If yes, create ticket in project → Assign to jira_username → Add to current sprint → Update session ReferenceTicket
5. **Search Confluence**: If enable_confluence_mcp → If confluence_space_key empty → Ask user "What's your Confluence space key? (or 'skip')" → **WAIT for user response** → Update preferences → Use Atlassian MCP to search docs in space (up to 2 attempts) → Log findings or "No relevant docs found"  
6. **Complete user interactions**: Ensure ALL user responses from steps 2-5 are collected and processed
7. **Load guide**: Read department from user_config.json → Load agents/{department}/analyzer.md → **ONLY AFTER all user interactions complete**
8. **Set status**: Status = RUNNING

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
1. **Plan creation**: Create detailed implementation plan in the session state in ## Plan section → Update session file with plan
2. **Present plan**: Show plan to user → Set Status = NEEDS_APPROVAL

### Phase: BLUEPRINT → Status: NEEDS_APPROVAL
1. **Wait for approval**: User reviews and approves/requests changes → **WAIT for user response**
- **If approved**: If enable_jira_mcp → Ask user "Create Jira sub-tasks from blueprint? (provide parent ticket number, say 'create new', or 'skip')" → **WAIT for user response** → If creating tickets → Create in jira_project_key → Assign to jira_username → Add to current sprint → Update session ParentTicket and CreatedTickets → Set Status = COMPLETED
- **If changes needed**: Increment revision counter → Return to RUNNING status

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
3. **Update documentation**: Check for project README files → Update relevant sections with new features/changes → Create README if none exists → Follow project documentation standards
4. **Upload measurements to Confluence**: If enable_confluence_mcp → Via Atlassian MCP → Find/create page "Measurements" in "AI WorkFlow" folder within confluence_space_key → Append formatted measurement summary
5. **Upload changelog to Confluence**: If enable_confluence_mcp → Via Atlassian MCP → Create new page in "AI WorkFlow/Changelog" folder within confluence_space_key → Title: "{DevName}_{TaskName}_{YYYYMMDD}" → Add formatted changelog summary
6. **Update Jira tickets**: If CreatedTickets exist → Mark all sub-tasks as Done via Atlassian MCP → Update main ticket to Completed
7. **Archive locally**: Prepend summary to ai-workflow-config/project_config.md Changelog
8. **Set status**: Status = COMPLETED

### Phase: SUMMARY → Status: COMPLETED
1. **Notifications**: Send Slack notifications (if enabled)
2. **Complete**: Workflow finished successfully

## Execution Order Rules (Critical)

### Sequential Step Execution
- **NEVER execute steps in parallel**: Each numbered step must complete entirely before the next step begins
- **User interaction blocking**: Any step with "Ask user" and "**WAIT for user response**" MUST complete before proceeding
- **Agent loading constraint**: Agents can ONLY be loaded AFTER all user interactions in that phase are complete
- **Status changes**: Status changes can ONLY occur after ALL steps in current status are complete

### Step Completion Requirements
- **Ask user**: Present question to user
- **WAIT for user response**: STOP all processing until user provides response
- **Process response**: Complete all response processing before next step
- **No parallel agent loading**: Agents cannot start providing guidance while user questions are pending

## Standard Procedures

### VERSION_CHECK_PROCEDURE
**MANDATORY STEPS - Execute in exact order:**
1. **Must Display to user**: "🔍 Checking for workflow system updates..."
2. **Get current version**: Run `git describe --tags --exact-match HEAD 2>/dev/null || echo "development"` in workflow-system directory → Show current version to user
3. **Fetch latest tags**: Run `git fetch --tags --quiet` in workflow-system directory
4. **Get latest version**: Run `git tag --sort=-version:refname | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' | head -1` in workflow-system directory → Show latest version to user
5. **Compare and notify**: If current version is "development" → Display "🔄 You're on development version. Latest release is {latest_version}. Update with: cd $(pwd | grep -o '.*workflow-system' | head -1) && git fetch --tags --force && git reset --hard latest && git checkout latest && ./workflow-system/setup.sh" → If current version != latest version → Display "🔄 New version {latest_version} available! Update with: cd $(pwd | grep -o '.*workflow-system' | head -1) && git fetch --tags --force && git reset --hard latest && git checkout latest && ./workflow-system/setup.sh" → Otherwise → Display "✅ You're using the latest version ({current_version})!"

## Session Start Rules (Always Check First)

### Setup Check (All Sessions Except 'start' Command)
1. **Check onboarding status**: Read user_config.json → If file missing or onboarding_completed=false → Display "⚠️ Workflow not initialized. Please run 'start' command first to set up your profile and project configuration." → Stop processing and wait for user to run start command
2. **Version check**: Execute VERSION_CHECK_PROCEDURE
3. **No automatic onboarding**: Never automatically start onboarding process - always require explicit 'start' command


## Continuous Rules (Always Active)

### Slash Command Handling
- **/update-config [section] [content]**: Update specific section in ai-workflow-config/project_config.md → Preserve existing format and other sections
- **/add-step [description]**: Load agents/default/add-step.md for guidance → Add custom step to current phase in workflow-system/config/rules.md → Use same format as existing steps
- **/help** or **/commands**: Load agents/default/help.md for guidance → Display available support commands and usage information
- **/help update**: Display update instructions → Show: "To update workflow system: cd $(pwd | grep -o '.*workflow-system' | head -1) && git fetch --tags --force && git reset --hard latest && git checkout latest && ./workflow-system/setup.sh"

### Config Updates
- **Any config update**: NEVER overwrite entire file → ONLY update specific fields → PRESERVE existing values

### Todo Management
- **If todo tool enabled for LLM**: Use todo tool to reflect workflow phases only → Create todos for each phase step → Update status as phases progress → Mark phases complete when finished

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
- 👤 **ONBOARDING**: "Setting up your user profile..."
- 📁 **INIT**: "Analyzing project and configuring workflow..."
- 🧠 **ANALYZE**: "Gathering context with {Department} guidance..."
- 📋 **BLUEPRINT**: "Creating plan with {Department} guidance..."
- 🛠️ **CONSTRUCT**: "Implementing with {Department} guidance..."
- ✅ **VALIDATE**: "Validating with {Department} guidance..."
- 📊 **SUMMARY**: "Generating measurements and reports..."
- 🎉 **COMPLETED**: "Workflow completed!"

## Slash Commands
- **start**: Smart initialization trigger → If no user_config.json or onboarding_completed==false → Set Phase=ONBOARDING, Status=READY → Otherwise → Display "Workflow already setup. Are you sure you want to re-start? (Y/N)" → **WAIT for user response** → If Yes → Set Phase=ONBOARDING, Status=READY → Complete initialization flow → If No → Display "Setup cancelled"
- **onboarding**: User profile setup only → Set Phase=ONBOARDING, Status=READY → Complete onboarding and stop → Display: "✅ Onboarding complete! Use 'start' to initialize project analysis."
- **/update-config [section] [content]**: Update ai-workflow-config/project_config.md with new conventions or standards
- **/add-step [description]**: Add custom step to current workflow phase
- **/help** or **/commands**: Display available support commands and their usage → Load agents/default/help.md for guidance
- **/help update**: Display update instructions with exact commands

## Department Support
- **dev**: Engineering workflows with technical focus
- **pm**: Product management with business requirements
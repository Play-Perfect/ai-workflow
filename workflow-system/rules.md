# AI Multi-Agent Workflow Rules

This file defines the core workflow phases and rules for the AI Multi-Agent Workflow System.

## Workflow Phases

### Phase 1: INIT (Setup)
**Purpose**: Initialize workflow session and user configuration

**Actions**:
1. **User Configuration Check**:
   - Read `user_config.json`
   - Check if `"onboarding_completed": true` 
   - If false → **Follow @workflow-system/onboarding.md** (user setup)
   - If true → check if `"init_completed": true`
   - If false → **Load and follow department init agent from `agents/{department}/init.md`**
   - If both complete → load user settings and proceed

2. **Session Creation**:
   - Display: "📁 Creating new workflow session for [feature-name]..."
   - Generate timestamp using current date/time
   - Create session filename: `sessions/workflow_state_YYYYMMDD_HHMMSS_feature-name.md`
   - Use Read function to get `context/workflow_state.md` template
   - Use Write function to create new session file with template content
   - Update session file State section with SessionId and SessionStartTime

3. **Phase Transition**:
   - Set Phase = ANALYZE, Status = READY in session file
   - Display: "📁 Session created: `workflow_state_YYYYMMDD_HHMMSS_feature-name.md`"

### Phase 2: ANALYZE (Understanding)
**Purpose**: Gather context and understand requirements using department-specific agents

**Actions**:
1. Load department-specific analyzer agent from `agents/{department}/analyzer.md`
2. Read `context/project_config.md` for project-specific requirements
3. Gather requirements and analyze existing patterns
4. Summarize findings in workflow session log
5. Set Phase = BLUEPRINT, Status = PLANNING

### Phase 3: BLUEPRINT (Planning)
**Purpose**: Create detailed implementation plan using department-specific agents

**Actions**:
1. Load department-specific blueprinter agent from `agents/{department}/blueprinter.md`
2. Decompose task into ordered steps with pseudocode
3. Include testing strategy (unit, integration, E2E tests)
4. Write detailed plan in session's ## Plan section
5. Set Status = NEEDS_PLAN_APPROVAL and request user confirmation
6. If user requests changes → Return to blueprinter → Present revised plan
7. After final approval → Create Jira sub-tasks if enabled in user_config.json
8. Wait for explicit user approval before proceeding

### Phase 4: CONSTRUCT (Implementation)
**Purpose**: Execute the approved plan using department-specific agents

**Actions**:
1. Load department-specific constructor agent from `agents/{department}/constructor.md`
2. Follow the approved ## Plan exactly
3. Implement tests BEFORE implementing features
4. After each atomic change:
   - Run test/lint commands from `context/project_config.md`
   - Log results in session ## Log
   - Update Jira sub-task progress if enabled in user_config.json
5. Produce correct, secure, performant code with no TODOs
6. Set Phase = VALIDATE on completion

### Phase 5: VALIDATE (Final Checks)
**Purpose**: Validate implementation and complete workflow using department-specific agents

**Actions**:
1. Load department-specific validator agent from `agents/{department}/validator.md`
2. Re-run full test suite and E2E checks
3. Validate all success criteria met
4. Create Confluence summaries if enabled in user_config.json
5. Send Slack notifications if enabled in user_config.json
6. Update Jira tickets with completion status if enabled in user_config.json
7. Log measurements to `measurements/` directory
8. Set Status = COMPLETED on success
9. Trigger post-processing rules

## Workflow Rules

### RULE_INIT_01: User Setup Check
**Trigger**: Phase == INIT  
**Action**:  
1. Read `user_config.json` template
2. Check `"onboarding_completed"` field:
   - If false → **Follow @workflow-system/onboarding.md exactly** (user setup)
   - If true → check `"init_completed"` field
3. If init not complete → **Load and follow department init agent from `agents/{department}/init.md`**
4. If both flags true → proceed to session creation

### RULE_AGENT_SELECTION_01: Department Agent Loading
**Trigger**: Any phase transition  
**Action**:
1. Read user department from `user_config.json`
2. Load appropriate agent config: `agents/{department}/{phase}.md`
3. Apply agent-specific instructions and context
4. Log agent selection in session

### RULE_LOG_ROTATE_01: Log Management
**Trigger**: length(session ## Log) > 5000 chars  
**Action**: 
1. Summarize top 5 findings from ## Log into ## ArchiveLog
2. Clear ## Log to prevent overflow

### RULE_SUMMARY_01: Workflow Completion
**Trigger**: Phase == VALIDATE && Status == COMPLETED  
**Action**:
1. Create one-sentence summary of completed work
2. Add summary to `context/project_config.md` ## Changelog
3. Save session metrics to `measurements/` directory

### RULE_MEASUREMENT_01: Performance Tracking
**Trigger**: Phase transitions and workflow completion  
**Action**:
1. Log phase duration, user corrections, accuracy metrics
2. Track plan approval attempts, revision cycles
3. Record implementation issues and validation results
4. Save to `measurements/` for ROI analysis

### RULE_JIRA_INTEGRATION_01: Jira Ticket Management
**Trigger**: Blueprint approval and construction progress
**Action**:
1. Check if `enable_jira_mcp: true` in user_config.json
2. On blueprint approval → Create Jira sub-tasks for implementation steps
3. During construction → Update sub-task progress after each change
4. On validation complete → Update main ticket status

### RULE_CONFLUENCE_INTEGRATION_01: Documentation Management
**Trigger**: Analyze phase and validate completion
**Action**:
1. Check if `enable_confluence_mcp: true` in user_config.json
2. During analyze → Search Confluence for related documentation
3. On validation → Create session summary and add to Confluence
4. Update shared "AI Workflow Analytics Dashboard" page

### RULE_SLACK_INTEGRATION_01: Team Notifications
**Trigger**: Workflow completion
**Action**:
1. Check if `enable_slack_mcp: true` in user_config.json
2. Send completion notification with session summary
3. Include time tracking and key metrics
4. Tag relevant team members based on department

## Agent System

### Department Structure
Each department has 4 specialized agents:
- **Analyzer**: Context gathering and requirement analysis
- **Blueprinter**: Planning and architecture design  
- **Constructor**: Implementation and testing
- **Validator**: Quality assurance and final validation

### Available Departments
- **dev**: Development/Engineering focused workflows
- **pm**: Product Management focused workflows
- **bi**: Business Intelligence focused workflows

### Agent Configuration
Each agent is defined in `agents/{department}/{phase}.md` with:
- Agent name, description, and color
- Role-specific instructions and methodology
- Phase-appropriate tools and analysis steps
- Department context and success criteria

## Session Management

### Session Files
- Location: `sessions/workflow_state_YYYYMMDD_HHMMSS_feature-name.md`
- Template: Copy from `context/workflow_state.md`
- Contains: State, Plan, Rules, Items, Log, ArchiveLog sections

### State Tracking
```
Phase: [INIT|ANALYZE|BLUEPRINT|CONSTRUCT|VALIDATE]
Status: [READY|RUNNING|PLANNING|NEEDS_PLAN_APPROVAL|IMPLEMENTING|COMPLETED]
CurrentItem: [task-description]
SessionId: [session-file-name]
SessionStartTime: [ISO-timestamp]
```

### Measurement Tracking
- Session duration and phase timings
- User interaction metrics (corrections, approvals)
- Quality metrics (issues found, tests passed)
- ROI calculations (time saved, efficiency gains)

## User Configuration Management

### Field-Specific Updates Rule
**CRITICAL**: When updating `user_config.json`, ALWAYS use field-specific edits:
- **NEVER** overwrite entire file
- **ONLY** update the specific fields that need to change
- **PRESERVE** all existing values in other fields
- Use Edit tool with precise old_string/new_string for individual fields

### Update Scenarios
- **Onboarding**: Update only `department`, `onboarding_completed`, `metadata.setup_date`, `metadata.last_updated`
- **Init completion**: Update only `init_completed`, `role`, `metadata.last_updated`
- **Settings changes**: Update only specific settings within `settings` object

## Communication Rules

### Phase Transitions
1. **📁 INIT**: "📁 Creating new workflow session for [feature-name]..."
2. **🧠 ANALYZE**: "🧠 Let me analyze the requirements using [Department]-Analyzer..."
3. **📋 BLUEPRINT**: "📋 Creating implementation plan with [Department]-Blueprinter..."
4. **🛠️ CONSTRUCT**: "🛠️ Here's my plan. Please review and confirm to proceed."
5. **✅ VALIDATE**: "✅ Implementation done. Running validation with [Department]-Validator..."
6. **🎉 COMPLETED**: "🎉 All changes completed! 📝 Adding summary to changelog."

### Guidelines
- Keep communication concise and phase-focused
- Always wait for user approval before CONSTRUCT phase
- Log important decisions and changes
- Maintain clear section boundaries in session files
- Follow department-specific patterns and conventions
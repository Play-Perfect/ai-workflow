# workflow_state.md
_Last updated: [Generated automatically]_

## State
Phase: INIT  
Status: READY  
CurrentItem: null  
Confidence: null  
Department: null  
CurrentAgent: null  
SessionId: [Generated UUID]  
SessionStartTime: [ISO timestamp]  
Context: []  

## Plan
<!-- AI populates during BLUEPRINT phase -->

### RULE EXECUTION PRIORITY
**CRITICAL**: ##Rules execute AUTOMATICALLY before, during, and after agent actions.
Agents are tools; Rules are the workflow backbone that ALWAYS runs.
All rules with matching triggers execute immediately regardless of current agent.

## Rules

### [PHASE: INIT]  
Check workflow-system/user_config.json (generated) → onboarding if needed → load department agent.
Create session file → set ANALYZE, RUNNING.

### [PHASE: ANALYZE]  
Load {department}-analyzer agent; read workflow-system/context/project_config.md (generated) & context.
Auto-query Jira tickets; search Confluence docs; set scope & complexity.

### [PHASE: BLUEPRINT]  
Load {department}-blueprinter agent; archive current plan.
Create detailed implementation plan → set NEEDS_PLAN_APPROVAL.
Assign confidence (1-10). If <7 → request clarification.

### [PHASE: CONSTRUCT]  
Load {department}-constructor agent; follow approved plan.
Run tests after each change; create checkpoints; update Jira sub-tasks.

### [PHASE: VALIDATE]  
Load {department}-validator agent; full test pass → COMPLETED.
Create Confluence docs; send Slack notifications; trigger completion rules.

### RULE_USER_CONFIG_CREATE_01: User Config Creation  
**Trigger**: First time workflow execution, no workflow-system/user_config.json exists  
**Action**:  
1. Read `workflow-system/config/user_config_template.json` TEMPLATE file
2. Create NEW `workflow-system/user_config.json` with template content
3. Proceed to RULE_INIT_01

### RULE_INIT_01: User Setup Check  
**Trigger**: Phase == INIT  
**Action**:  
1. Read `workflow-system/user_config.json` (generated)
2. Check `"onboarding_completed"` field:
   - If false → **Follow @workflow-system/config/onboarding.md** (user setup)
   - If true → check `"init_completed"` field
3. If init not complete → **Load and follow department init agent from `agents/{department}/init.md`**
4. If both flags true → proceed to RULE_PROJECT_CONFIG_CREATE_01

### RULE_PROJECT_CONFIG_CREATE_01: Project Config Creation  
**Trigger**: INIT complete, before session creation  
**Action**:  
1. Read `workflow-system/context/project_config.md` TEMPLATE file
2. Create NEW `project_config.md` in project root with template content
3. Analyze project and populate with real values (replace [TEMPLATE: ...] placeholders)
4. Update Goal, Tech Stack, Patterns, Constraints based on project analysis
5. Set Department from workflow-system/user_config.json (generated)
6. Configure Integration Points if enabled
7. **IMPORTANT**: All future phases read the GENERATED `project_config.md`, NOT the template

### RULE_SESSION_CREATE_01: Session Creation  
**Trigger**: Project config created, ready for session  
**Action**:  
1. Display: "📁 Creating new workflow session for [feature-name]..."
2. Generate timestamp using current date/time
3. Create session filename: `workflow-system/sessions/workflow_state_YYYYMMDD_HHMMSS_feature-name.md`
4. Read `workflow-system/context/workflow_state.md` template using Read function
5. Write new session file with template content using Write function
6. Update session file State section with SessionId and SessionStartTime
7. Set Phase = ANALYZE, Status = READY in session file
8. Display: "📁 Session created: `workflow_state_YYYYMMDD_HHMMSS_feature-name.md`"

### RULE_ONBOARDING_01: User Onboarding  
**Trigger**: onboarding_completed == false  
**Action**:  
1. Follow @workflow-system/config/onboarding.md exactly
2. Ask user department, role, preferences
3. Update workflow-system/user_config.json (generated) with field-specific edits
4. Set onboarding_completed = true
5. Proceed to init check

### RULE_DEPT_INIT_01: Department Initialization  
**Trigger**: onboarding_completed == true && init_completed == false  
**Action**:  
1. Load and follow workflow-system/agents/{department}/init.md
2. Department-specific setup and configuration
3. Update workflow-system/user_config.json (generated): init_completed = true
4. Proceed to session creation

### RULE_AGENT_SELECTION_01: Department Agent Loading  
**Trigger**: Any phase transition  
**Action**:  
1. Read user department from workflow-system/user_config.json (generated)
2. Load appropriate agent config: agents/{department}/{phase}.md
3. Apply agent-specific instructions and context
4. Agnet act as guide but rules are must. Do not skip rules.
4. Log agent selection in session

### RULE_ADAPTIVE_01  
Simple tasks (complexity 1-2) → skip BLUEPRINT.
Complex tasks (4-5) → add pre-validation step.

### RULE_PATTERN_01  
Check similar tasks → reuse successful approaches from ArchiveLog.

### RULE_ROLLBACK_01  
CONSTRUCT fails → rollback to checkpoint, re-plan with constraints.

### RULE_LOG_ROTATE_01  
Log > 5000 chars → top 5 lines to ArchiveLog, clear current log.

### RULE_SUMMARY_01  
VALIDATE && COMPLETED → prepend one-liner to workflow-system/context/project_config.md (generated) Changelog.

### RULE_MEASUREMENT_01  
Phase transitions → record duration, corrections, accuracy metrics.

### RULE_JIRA_SEARCH_01: Jira Ticket Integration  
**Trigger**: Phase == ANALYZE (start)  
**Action**:  
1. Check if enable_jira_mcp: true in workflow-system/user_config.json (generated)
2. If enabled → Ask user: "Enter Jira ticket number (or 'skip' to continue):"
3. If ticket provided → Fetch ticket details using fetch_pull_request tool
4. Log ticket info in session for context
5. If skip or disabled → Log "Jira integration skipped" and continue

### RULE_CONFLUENCE_SEARCH_01: Documentation Search  
**Trigger**: Phase == ANALYZE (start)  
**Action**:  
1. Check if enable_confluence_mcp: true in workflow-system/user_config.json (generated)  
2. If enabled → Search Confluence for relevant docs (1 attempt with task keywords)
3. Log findings or "No relevant docs found" in session
4. If disabled → Log "Confluence search disabled" and continue

### RULE_JIRA_SUBTASK_01: Jira Sub-task Creation
**Trigger**: Phase == BLUEPRINT (end, after user approval)
**Action**:
1. Check if enable_jira_mcp: true in workflow-system/user_config.json (generated)
2. If enabled → Ask user: "Create Jira tasks? Enter parent ticket (or 'create' for new main task, or 'skip'):"
3. If 'create' → Create main task for feature, then create sub-tasks from blueprint steps
4. If parent ticket → Create sub-tasks under provided parent ticket
5. If 'skip' or disabled → Log "Jira task creation skipped" and continue to CONSTRUCT

### Integration Rules
- RULE_CONFLUENCE_01: Validate → create completion summaries.  
- RULE_SLACK_01: Completion → send notifications with metrics.

### RULE_BLUEPRINT_ARCHIVE_01  
Before overwrite → save to Blueprint History with timestamp+ID.

### RULE_BLUEPRINT_REFERENCE_01  
User request → restore/show archived blueprint by ID.

### RULE_CONFIG_UPDATE_01: Field-Specific Updates  
**Trigger**: Any workflow-system/user_config.json (generated) update  
**Action**:  
1. **NEVER** overwrite entire file
2. **ONLY** update specific fields that need change
3. **PRESERVE** all existing values in other fields
4. Use precise old_string/new_string for individual fields
5. Examples: onboarding → update only department, onboarding_completed; init → update only init_completed, role

## Items
| id | description | status | complexity | confidence | department |

## Metrics
Tasks: 0/0, Success: 100%, Patterns: [], Department: null, AgentSwitches: 0

## Checkpoints
| time | phase | agent | confidence | safe | jira_status |

## Log
<!-- Real-time session log entries with timestamps -->

## Workflow History
<!-- Git commit SHA & messages, Jira ticket updates -->

## ArchiveLog
<!-- Rotated log summaries when Log > 5000 characters -->

## Blueprint History
<!-- Archived implementation plans with timestamp+ID -->

---
*This file tracks the state of a single workflow session and is copied to sessions/ directory when workflow starts*
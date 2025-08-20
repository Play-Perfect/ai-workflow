# AI Multi-Agent Workflow System

> ⚠️ **IMPORTANT**: This system is optimized for **Anthropic Claude models (Claude Sonnet Thinking 4 recommended)**. While it may work with other LLMs, best performance and feature compatibility are achieved with Claude models.

## 📑 Table of Contents
| Section | Description |
|---------|-------------|
| [✨ Key Features](#-key-features) | What this system can do |
| [🚀 Quick Installation](#-quick-installation) | Simple 2-command setup for everyone |
| [📝 Available Commands](#-available-commands) | Commands to control the workflow system |
| [🔄 6-Phase Execution](#-6-phase-execution-model) | How the workflow works |
| [🔗 Integrations](#-integration-points) | Jira, Confluence, Slack support |
| [📁 File Structure](#-file-structure) | How files are organized |
| [❓ FAQ](#-common-questions) | Common questions answered |

---

Transform your AI workflow into a smart, multi-team system supporting Engineering, Product Management, Business Intelligence, DevOps, Design, and QA departments through specialized agents and dynamic customization.

## ✨ Key Features

- **🤖 Phase-Based Agent System**: Specialized agents for each department (Dev, PM, BI, DevOps, Design, QA) across 6 workflow phases
- **🔄 6-Phase Execution Model**: INIT → ANALYZE → BLUEPRINT → CONSTRUCT → VALIDATE → SUMMARY
- **🤝 Cross-Department Collaboration**: Seamless agent handoffs and collaborative planning
- **🚀 Auto-Initialization**: Smart onboarding with git name detection and user profiling
- **🔗 MCP Full Integration**: Jira ticket management, Confluence documentation, Slack notifications
- **📊 Comprehensive Measurement System**: Session metrics, phase durations, revision tracking with Confluence reporting
- **📈 Real-time Progress Tracking**: Live Jira sub-task updates and session monitoring
- **📋 Structured Reporting**: Automated measurements and changelog generation

## 🚀 Quick Installation

### Step 1: Copy 2 Commands
Open your terminal/command prompt and navigate to your project folder, then copy and paste these 2 commands:

```bash
git clone --branch latest https://github.com/Play-Perfect/ai-workflow.git workflow-system
./workflow-system/workflow-system/setup.sh
```

### Step 2: Start Using
That's it!
Now just write in Claude/Cursor chat:
```
 start
```

## 📝 Available Commands

### Basic Commands
- **`start`** - One-time setup and initialization of the AI workflow system. Creates user profile, analyzes project, and sets up configuration. 
  ```
  start
  ```

### Configuration Commands  
- **`/update-config [section] [content]`** - Add general project instructions, coding standards, or context to your project configuration for better AI guidance.
  ```
  /update-config coding-standards "Use TypeScript strict mode and ESLint rules"
  /update-config architecture "Use src/components/ for React components, src/services/ for API calls, src/utils/ for helpers. Each component must have interface Props and default export."
  ```

- **`/add-step [description]`** - Add custom workflow steps to the current phase for specialized requirements or team processes.
  ```
  /add-step "Create Jira subtask via MCP for code review approval before merging to main branch"
  /add-step "Generate OpenAPI spec using 'swagger-jsdoc' and update docs/api.yml after endpoint changes"
  ```

- **`/help`** - Display available commands and usage information.

---

## 🔄 Updating Version

To get the latest features and improvements, update your workflow system:

```bash
# Navigate to your workflow system directory
cd workflow-system

# Fetch latest tags and reset to latest version
git fetch --tags --force
git reset --hard origin/latest

# Re-run setup to apply any new configurations
./workflow-system/setup.sh
```

### Auto-Initialization Process

When you run the `start` command, the system will automatically:
1. **User Onboarding**: Detect git username and ask about department preferences
2. **Project Analysis**: Scan your codebase and detect technology stack
3. **Configuration Setup**: Create personalized workflow configuration
4. **Ready to Use**: Execute 6-phase workflows immediately

## 🔄 6-Phase Execution Model

### 🔧 Phase 1: INIT
- Auto-initialization check: Verifies user configuration and project setup
- User onboarding: Git name detection, department selection, preference setting
- Project analysis: Codebase scanning, technology detection, context gathering
- Session creation: Initialize new workflow session with unique ID and measurement tracking

### 🔍 Phase 2: ANALYZE  
- Select appropriate Analyzer Agent based on user's department
- Auto-query Jira tickets for context (with MCP integration)
- Search Confluence documentation
- Gather department-specific requirements
- Track phase duration and revisions

### 📝 Phase 3: BLUEPRINT
- Select appropriate Blueprinter Agent based on user's department
- Create detailed implementation plan in session state
- Present plan for user approval
- **Revision Loop**: Handle user feedback and plan modifications (tracked)
- Generate Jira sub-tasks automatically (after final approval)

### 🔨 Phase 4: CONSTRUCT
- Select appropriate Constructor Agent based on user's department
- Execute the approved plan step by step
- Update corresponding Jira sub-tasks after each step completion
- Real-time progress tracking with checkpoint creation
- Handle rollback scenarios

### 🧪 Phase 5: VALIDATE
- Select appropriate Validator Agent based on user's department
- Comprehensive validation and testing
- Create technical documentation
- Quality assurance verification

### 📊 Phase 6: SUMMARY
- **Measurement Agent**: Load specialized measurement formatting guidance
- **Generate Reports**: Create standardized measurement and changelog summaries
- **Confluence Integration**: 
  - Append measurements to shared "AI WorkFlow/Measurements" page
  - Create individual changelog in "AI WorkFlow/Changelog" folder
- **Jira Completion**: Mark all tickets as Done/Completed
- **Local Archive**: Update project changelog
- **Notifications**: Send Slack completion summary

## 📊 Comprehensive Measurement System

### Measurement Data Collected
- **Session Metrics**: Total duration, start/end times, developer name
- **Phase Tracking**: Duration and revision count for each phase
- **Success Indicators**: Completion status, test results, rollback usage
- **Jira Integration**: Tickets created/updated, sub-task completion

### Confluence Reporting Structure
```
{confluence_space_key}/
└── AI WorkFlow/
    ├── Measurements (single page - all session summaries)
    └── Changelog/
        ├── {DevName}_{TaskName}_{YYYYMMDD}
        ├── {DevName}_{TaskName}_{YYYYMMDD}
        └── ...
```

### Measurement Benefits
- **Company Insights**: Track if AI workflow improves development efficiency
- **Process Optimization**: Identify which phases need improvement
- **Team Performance**: Department-specific success patterns
- **ROI Analysis**: Time savings and productivity improvements

## ⚙️ Unified Execution Rules

The workflow system uses automatic rules that execute before agent guidance:

### 🔄 Automatic Rule Execution

**INIT Phase → Status: READY**
- User config creation and onboarding with git name detection
- Department initialization and measurement setup
- Project analysis and configuration
- Session creation with measurement initialization

**ANALYZE Phase → Status: READY**
- Phase timing start
- **Jira ticket integration**: Auto-query tickets for context
- **Confluence search**: Find relevant documentation
- Load department-specific analyzer guide

**BLUEPRINT Phase → Status: RUNNING**
- Create detailed implementation plan in session state ## Plan section
- Present plan to user for approval
- **Revision tracking**: Increment counters when changes needed

**CONSTRUCT Phase → Status: RUNNING**
- Plan execution with testing and checkpoints
- **Jira sub-task updates**: Update corresponding tickets after each step
- Progress tracking with rollback capabilities

**VALIDATE Phase → Status: RUNNING**
- Quality assurance and comprehensive testing
- Technical documentation creation
- Validation completion

**SUMMARY Phase → Status: RUNNING**
- **Measurement generation**: Use measurement agent templates
- **Confluence uploads**: Separate steps for measurements and changelog
- **Jira completion**: Mark all tickets as Done
- **Final archiving**: Local and remote documentation

### 🤖 Continuous Automation Rules

**Metrics Tracking**: Record phase durations, revision counts, success rates
**Config Updates**: Preserve existing values during field-specific updates
**Log Management**: Auto-rotate when logs exceed 5K characters
**Pattern Reuse**: Leverage successful approaches from archived sessions
**Failure Recovery**: Rollback to checkpoints on construction failures

## 🧭 Advisory Agent System

**Agent Role**: Provide guidance and recommendations, not control workflow execution

**Specialized Agents**:
- **Department Agents**: Dev, PM, BI, DevOps, Design, QA agents for each phase
- **Measurement Agent**: Standardized reporting and Confluence formatting

**Agent Format**:
- **Purpose**: Help with phase-specific objectives
- **Approach**: Collaborative and advisory tone
- **Focus Areas**: Domain-specific best practices and considerations
- **Templates**: Standardized measurement and changelog formats

## 📁 File Structure

```
your-project/
├── CLAUDE.md                  # Main LLM instructions (symlinked)
├── ai-workflow-config/        # User configs (in project root, can be committed)
│   ├── user_config.json       # Generated user configuration
│   ├── project_config.md      # Generated project analysis
│   ├── sessions/              # Session tracking files
│   └── measurements/          # Measurement data
└── workflow-system/           # Cloned workflow system
    ├── context/               # Templates and context
    │   ├── workflow_state.md  # Session state template
    │   └── project_config_template.md
    ├── config/                # Core configuration files
    │   ├── rules.md           # Unified workflow rules
    │   ├── onboarding.md      # User onboarding process
    │   └── user_config_template.json
    ├── agents/                # Department-specific agents
    │   ├── dev/               # Development team agents
    │   ├── pm/                # Product management agents
    │   ├── bi/                # Business intelligence agents
    │   ├── devops/            # DevOps team agents
    │   ├── design/            # Design team agents
    │   ├── qa/                # QA team agents
    │   └── default/           # Default measurement agent
    │       └── measurement.md # Measurement formatting templates
    ├── llm_configs/           # LLM-specific configurations
    │   └── claude/
    │       └── CLAUDE.md      # Main LLM instructions
    └── setup.sh              # Setup script
```

## 🔗 Integration Points

- **Jira**: Automatic ticket querying, sub-task creation, step-by-step progress tracking
- **Confluence**: Documentation search, measurement aggregation, individual changelog creation
- **Slack**: Completion notifications with comprehensive session summaries
- **Git Integration**: Username detection for developer tracking
- **Custom MCPs**: Extensible through Model Context Protocol servers

## 🚀 Future Vision

This system serves as the foundation for company-wide AI automation, transforming from individual task automation to complete organizational operation optimization through intelligent agents that learn, predict, and optimize all business processes.

**Ultimate Goal**: An AI-powered organizational nervous system that sees everything, understands context, takes action, learns continuously, and empowers everyone to be more effective.

## ❓ Common Questions

### What does the setup script do?

The setup script automatically creates symlinks and configuration files so Claude/Cursor can find the workflow system:

- `CLAUDE.md` → `workflow-system/llm_configs/claude/CLAUDE.md` 
- `.cursor/rules/workflow.mdc` → `workflow-system/llm_configs/cursor/.cursor/rules/workflow.mdc` (if available)
- `.mcp.json` and `.cursor/mcp.json` MCP configurations
- Creates `ai-workflow-config/` directory for project-specific data

This keeps all workflow logic centralized while making it accessible to your AI assistants.

### How does measurement tracking work?

The system automatically tracks:
- **Session duration** and phase-specific timing
- **Revision counts** when plans need changes
- **Success metrics** including test results and completion status
- **Developer attribution** for team performance analysis

All measurements are formatted using the measurement agent and uploaded to Confluence for company-wide analysis.
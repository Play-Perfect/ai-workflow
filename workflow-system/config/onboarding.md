# User Onboarding Process

This file contains the detailed onboarding sequence for new users of the AI Multi-Agent Workflow System.

## When to Use This File

Execute this onboarding process when:
- `workflow-system/user_config.json` template exists but `"onboarding_completed": false`
- User requests to reset/reconfigure their workflow setup
- Start command is called and onboarding is needed

## Onboarding Sequence

### Step 0: Initial Setup (Start Command Only)
**LLM Actions**:
- Display first-time welcome: "👋 Welcome to Play-Perfect AI Workflow! Let's get started! 🚀"
- If no user_config.json exists → Read template → Create ai-workflow-config/user_config.json
- Set Phase=ONBOARDING, Status=READY

### Step 1: Username Collection
**LLM Actions**:
- Run: `git config --global user.name` to get git username
- Display: "👤 Detected Git user: [GitName]"
- Ask: "Is this correct? (Y/N) Or enter your preferred name:"
- Wait for user response

### Step 2: Department Selection
**LLM Actions**:
- Display: "👥 Select your primary department:"
  - "1. 💻 Development"
  - "2. 📊 Product Management" 
  - "3. 📈 Business Intelligence"
- Ask: "Enter your choice (1, 2, or 3):"
- do not procced until user response.

### Step 3: Await For Confirmation
**LLM Actions**
- Await for user response for selecting department.
- Must Wait for user response (1, 2, or 3). 
- Validate input (must be 1, 2, or 3)
- Store department choice as: "dev", "pm", or "bi"
- Display confirmation: "✅ Selected: [Department Name]"

### Step 4: Configuration Completion
**LLM Actions**:
- Display: "⚙️ Saving your workflow configuration..."
- Use Edit function to update ONLY specific fields in `workflow-system/user_config.json`:
  - Set `"user_name"` to confirmed user name from Step 1
  - Set `"department"` to selected department ("dev", "pm", or "bi") 
  - Set `"onboarding_completed": true`
  - Set `"metadata.setup_date"` to current date YYYY-MM-DD
  - Set `"metadata.last_updated"` to current date YYYY-MM-DD
  - **IMPORTANT**: Leave all other fields unchanged (role, settings, init_completed)

### Step 5: Completion
**LLM Actions**:
- Display: "✅ thats all i need from you! Your workflow is configured for [Department] workflows."
- Display: "NEXT: Lets setup your project now..."

### Step 6: Project Analysis
**LLM Actions**:
- Load department-specific init agent: `agents/{department}/init.md` (where {department} is from user_config.json)
- **AUTONOMOUS PROJECT ANALYSIS** (no user questions)
- Agent analyzes codebase and updates config
- Update config with init_completed=true
- **UNLOAD agent before proceeding**

### Step 7: Project Config Creation
**LLM Actions**:
- **ONLY AFTER agent unloaded**
- Create ai-workflow-config/project_config.md
- Set Phase=ONBOARDING, Status=COMPLETED

### Step 8: Final Completion
**LLM Actions**:
- If setup complete → Display completion message: "✅ All setup! Play-Perfect AI Workflow is ready for you. **Recommended: Start new conversation to start work**"
- **STOP workflow** (do not proceed to INIT phase)
- If triggered by 'start' command → Return control to main workflow (INIT phase session creation)

## Execution Notes

- **Sequential execution**: Each step must complete entirely before the next step begins
- **User interaction blocking**: Steps with "Ask user" and "Wait for user response" MUST complete before proceeding
- **Agent loading constraint**: Agents can ONLY be loaded AFTER all user interactions are complete
- **Status changes**: Status changes can ONLY occur after ALL steps in current phase are complete

## Validation Rules

- user_name must be non-empty string (from git or user input)
- Department must be exactly: "dev", "pm", or "bi"
- Settings must be boolean values (true/false)
- onboarding_completed must be true when complete
- metadata.setup_date must be current date in YYYY-MM-DD format

## Error Handling

If any step fails:
1. Display clear error message to user
2. Ask user to retry the failed step
3. Do not proceed until all steps complete successfully
4. If user cancels, do not create incomplete workflow-system/user_config.json
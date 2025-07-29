# User Onboarding Process

This file contains the detailed onboarding sequence for new users of the AI Multi-Agent Workflow System.

## When to Use This File

Execute this onboarding process when:
- `workflow-system/user_config.json` template exists but `"onboarding_completed": false`
- User requests to reset/reconfigure their workflow setup

## Onboarding Sequence

### Step 1: Department Selection
**LLM Actions**:
- Display: "🚀 Setting up AI workflow for your project..."
- Display: "👥 Select your primary department:"
  - "1. 💻 Development"
  - "2. 📊 Product Management" 
  - "3. 📈 Business Intelligence"
- Ask: "Enter your choice (1, 2, or 3):"
- do not procced until user response.

### Step 2: Await For Confirmation
**LLM Actions**
- Await for user response for selecting department.
- Must Wait for user response (1, 2, or 3). 
- Validate input (must be 1, 2, or 3)
- Store department choice as: "dev", "pm", or "bi"
- Display confirmation: "✅ Selected: [Department Name]"

### Step 2: Configuration Completion
**LLM Actions**:
- Display: "⚙️ Saving your workflow configuration..."
- Use Edit function to update ONLY specific fields in `workflow-system/user_config.json`:
  - Set `"department"` to selected department ("dev", "pm", or "bi") 
  - Set `"onboarding_completed": true`
  - Set `"metadata.setup_date"` to current date YYYY-MM-DD
  - Set `"metadata.last_updated"` to current date YYYY-MM-DD
  - **IMPORTANT**: Leave all other fields unchanged (role, settings, init_completed)

### Step 3: Completion
**LLM Actions**:
- Display: "✅ Onboarding complete! Your workflow is configured for [Department] workflows."
- Display: "🎯 Available agents:"
  - "🔍 [Department]-Analyzer (context gathering)"
  - "📋 [Department]-Blueprinter (planning)" 
  - "🔨 [Department]-Constructor (implementation)"
  - "✅ [Department]-Validator (quality assurance)"
- Display: "🚀 Ready to proceed with project initialization..."
- Return control to main workflow (INIT phase session creation)

## Validation Rules

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
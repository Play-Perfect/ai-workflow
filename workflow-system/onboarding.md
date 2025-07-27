# User Onboarding Process

This file contains the detailed onboarding sequence for new users of the AI Multi-Agent Workflow System.

## When to Use This File

Execute this onboarding process when:
- `user_config.json` template exists but `"onboarding_completed": false`
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
- Wait for user response (1, 2, or 3)
- Validate input (must be 1, 2, or 3)
- Store department choice as: "dev", "pm", or "bi"
- Display confirmation: "✅ Selected: [Department Name]"

### Step 2: Configuration Completion
**LLM Actions**:
- Display: "⚙️ Saving your workflow configuration..."
- Use Edit function to fill `user_config.json` template:
  - Set `"department"` to selected department ("dev", "pm", or "bi")
  - Set `"role"` to empty string (will be filled during project usage)
  - Set all `"settings"` to default values (false for MCPs, true for measurement)
  - Set `"onboarding_completed": true`
  - Set `"metadata.setup_date"` to current date YYYY-MM-DD
  - Set `"metadata.last_updated"` to current date YYYY-MM-DD

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
4. If user cancels, do not create incomplete user_config.json
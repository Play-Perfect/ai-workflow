# Add-Step Command Agent

## Purpose
Handle `/add-step [description]` command to identify phase, status, and step details, then ask for user approval.

## Command Usage
`/add-step [description]` - Add custom step to workflow phase

## Process Flow

### Step 1: Automatic Extraction
- Extract step description from `/add-step [description]` command
- **Automatically analyze** description keywords to determine phase
- **Automatically determine** target status (RUNNING)
- **Automatically create** step name from description

### Step 2: Automatic Phase Identification
**Agent automatically identifies** target phase based on description keywords:
- **ANALYZE**: Context gathering, requirements, research steps
- **BLUEPRINT**: Planning, design, approval steps  
- **CONSTRUCT**: Implementation, coding, building steps
- **VALIDATE**: Testing, quality assurance, verification steps
- **SUMMARY**: Documentation, reporting, measurement steps

**No user input required** - agent determines phase automatically

### Step 3: Present Proposal
Display to user:
```
📋 Add Step Proposal:
Phase: [IDENTIFIED_PHASE] → Status: RUNNING
Step: [NEXT_NUMBER]. **[Step Name]**: [description]

Add this step to workflow-system/config/rules.md? (Y/N)
```

### Step 4: Wait for Approval
- **If Y**: Proceed to add step to rules.md
- **If N**: Cancel operation
- **If invalid**: Ask again

## Phase Analysis Guidelines

### Keywords for Phase Identification
- **ANALYZE**: research, gather, analyze, investigate, understand, context, requirements
- **BLUEPRINT**: plan, design, create plan, architecture, outline, structure
- **CONSTRUCT**: implement, build, code, create, develop, execute, run
- **VALIDATE**: test, verify, check, validate, review, quality, ensure
- **SUMMARY**: document, report, measure, summarize, archive

## Usage Examples

```
User: "/add-step create security review checklist"
Agent: 
📋 Add Step Proposal:
Phase: VALIDATE → Status: RUNNING
Step: 4. **Create security review checklist**: create security review checklist

Add this step to workflow-system/config/rules.md? (Y/N)

User: "/add-step analyze database performance requirements"  
Agent:
📋 Add Step Proposal:
Phase: ANALYZE → Status: RUNNING
Step: 8. **Analyze database performance requirements**: analyze database performance requirements

Add this step to workflow-system/config/rules.md? (Y/N)

User: "/add-step design API endpoint structure"
Agent:
📋 Add Step Proposal:
Phase: BLUEPRINT → Status: RUNNING
Step: 3. **Design API endpoint structure**: design API endpoint structure

Add this step to workflow-system/config/rules.md? (Y/N)
```

## Error Handling

### Invalid Description
- Display: "❌ Please provide a step description: /add-step [description]"
- Show usage example

### Unclear Phase
- Display: "❌ Cannot determine appropriate phase for this step"
- Suggest clearer description with phase keywords
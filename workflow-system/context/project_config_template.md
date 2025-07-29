# project_config_template.md
_This is a template file. DO NOT modify directly._

## Goal  
[TEMPLATE: Project goal automatically determined during INIT phase]

## Tech Stack  
[TEMPLATE: Auto-detected during project analysis]

## Patterns  
[TEMPLATE: Code patterns and conventions discovered during analysis]

## Constraints  
[TEMPLATE: Performance and business constraints identified]

## Team & Workflow  
- Department: [TEMPLATE: User's department from user_config.json]
- Workflow: 5-phase execution (INIT → ANALYZE → BLUEPRINT → CONSTRUCT → VALIDATE)
- Agents: Department-specific agents for each phase
- Integrations: Jira, Confluence, Slack (if enabled)

## Quality Standards
- Testing: Comprehensive test strategy per department
- Documentation: Auto-generated during validation
- Measurements: ROI tracking and productivity metrics

## Integration Points
- Jira: [TEMPLATE: Project key and configuration if enabled]
- Confluence: [TEMPLATE: Space and documentation links if enabled]  
- Slack: [TEMPLATE: Channel and notification settings if enabled]

## Tokenization  
- 3.5 ch/token average, 8K context cap per phase
- Auto-summarize when workflow_state.md > 12K characters

## Changelog
[TEMPLATE: One-line summaries of completed workflows, auto-generated]

---
*TEMPLATE FILE: Init agent copies this to project root as `project_config.md` and populates during INIT phase*
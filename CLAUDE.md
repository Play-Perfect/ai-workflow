# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an AI Multi-Agent Workflow System designed to transform AI workflows into smart, multi-team systems supporting Engineering, Product Management, Business Intelligence, and other departments through specialized agents and dynamic customization.

## Architecture

### Core Workflow Architecture
The system follows a 5-phase execution model:
1. **INIT**: User setup, agent selection, and tool initialization
2. **ANALYZE**: Context gathering from Jira/Confluence with agent-specific analysis
3. **BLUEPRINT**: Agent-specific planning with user approval and sub-task creation
4. **CONSTRUCT**: Execution phase with real-time progress tracking
5. **VALIDATE**: Agent-specific validation with documentation and completion

### Phase-Based Agent System
Each department has dedicated agents for specific workflow phases:

**Development Department:**
- **Dev-Analyzer**: Technical context gathering, architecture analysis, dependency mapping
- **Dev-Blueprinter**: Technical planning, system design, testing strategy  
- **Dev-Constructor**: Code implementation, testing execution, deployment
- **Dev-Validator**: Code review, quality assurance, production readiness

**Product Management Department:**
- **PM-Analyzer**: Requirements gathering, stakeholder research, user needs analysis
- **PM-Blueprinter**: PRD creation, roadmap planning, feature specification
- **PM-Constructor**: Documentation creation, stakeholder coordination, user story writing
- **PM-Validator**: Requirements validation, stakeholder approval, acceptance criteria review

**Business Intelligence Department:**
- **BI-Analyzer**: Data source identification, metrics definition, business context gathering
- **BI-Blueprinter**: Analysis methodology, visualization planning, reporting strategy
- **BI-Constructor**: Data analysis execution, report creation, dashboard building
- **BI-Validator**: Data validation, insight accuracy, business impact assessment

**DevOps, Design, and QA Departments:** Each follow the same 4-phase agent pattern (Analyzer, Blueprinter, Constructor, Validator) with department-specific specializations.

### Key Directories
- `.ai_workflow/`: Contains workflow measurements and session data
- `.ai_workflow/measurements.md`: Local measurement file tracking session metrics

## Development Commands

This is currently a planning-stage project with no established build system. The repository contains primarily documentation and architectural plans.

## Integration Points

The system is designed to integrate with:
- **Jira**: Auto-query tickets, create sub-tasks, track progress
- **Confluence**: Search documentation, create session summaries  
- **Slack**: Send completion notifications with time tracking

## Measurement System

The project includes a comprehensive measurement system that tracks:
- Session duration and phase metrics
- User corrections and LLM accuracy issues
- Workflow completion status and business impact
- ROI calculations and productivity metrics

Data is stored locally in `.ai_workflow/measurements.md` and auto-updated to a shared Confluence dashboard.

## Custom MCP Development

The project recommends developing custom MCP servers for:
- Workflow Analytics MCP
- Department Coordination MCP  
- Knowledge Management MCP
- Resource Planning MCP

## Cross-Department Agent Collaboration

- **Agent Handoff System**: Seamless transitions between department agents with full context preservation
- **Cross-Phase Integration**: Agents can collaborate across phases (e.g., Dev-Blueprinter with PM-Analyzer)
- **Collaborative Planning**: Multiple department agents can participate in blueprint phase for complex features

## Workflow Execution Rules

**IMPORTANT**: Always follow the complete workflow rules defined in `workflow.mdc`. This file contains the exact phases, agent behaviors, and execution patterns that must be followed for every user interaction.

## Dynamic Workflow Building

Supports `/add-step` command for adding custom workflow steps during any phase, allowing organic evolution based on team needs. Each step is automatically assigned to the appropriate phase-based agent.

## Self-Initialization Process

When a user first interacts with the LLM in a project:
1. Check if `project_config.md` exists
2. If not, run self-initialization:
   - Ask onboarding questions (department, role, preferences)
   - Analyze the entire project structure
   - Fill `project_config.md` with project analysis and user preferences
3. Always execute requests following the phase-based workflow defined in `workflow.mdc`
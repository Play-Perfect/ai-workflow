# PM-Init Guide

**Role**: Comprehensive product context analysis and PRD framework establishment

## Your Mission

**Purpose**: Perform autonomous, thorough analysis of the entire project to create a complete product management contract including PRD template generation from user examples.

**Your approach**:
- Generate PRD template from user-provided examples for consistent product documentation
- Analyze everything systematically from a product management perspective
- Extract concrete business patterns and product frameworks from actual project
- Document findings as a comprehensive product knowledge base

## Required Analysis Tasks

### 1. PRD Template Generation
- Request 1-3 PRD examples from user to understand their preferred format
- Analyze structure, sections, and formatting patterns from examples
- Generate standardized PRD template at `./product/prd_template.md`
- Create template that captures user's decision framework, KPI approach, and documentation style

### 2. Visual Reference Collection
- Request 1-3 app screenshot examples for mockup consistency
- Create `./product/mockup_examples/` directory and store reference images
- Document visual patterns and design principles for HTML mockup generation

### 3. Complete Product Context Mapping
- Use Glob and LS tools to map project structure from product perspective
- **CRITICAL**: Only analyze project files in root directory and user application folders. Skip workflow-system directory entirely.
- **If insufficient product information found**: Request 1-3 product information files from user (existing PRDs, feature specs, business documents, or project overviews)
- Identify user-facing features, business logic, monetization touchpoints
- Document conversion flows, user journeys, and engagement patterns
- Map feature relationships and user experience dependencies

### 4. Business Model Analysis
- Scan configuration files for monetization patterns, A/B testing setup
- Identify revenue streams, pricing models, economy structure
- Extract KPI frameworks and success metrics from analytics integration
- Document decision-making processes and prioritization methods

### 5. Product Pattern Extraction
- Read source files to identify product conventions and user experience patterns
- Extract UI component patterns, conversion flow implementations
- Document feature rollout approaches, experimentation frameworks
- Capture user onboarding, engagement loops, and retention strategies

### 6. Stakeholder & Integration Review
- Find integration points with analytics, experimentation, business intelligence tools
- Identify communication channels (Jira, Confluence, Slack configurations)
- Document stakeholder workflows and approval processes
- Review project management and product delivery patterns

## Execution Process

**Execute these steps sequentially**:

1. **PRD Template Setup**: Request user examples and generate PRD template
2. **Visual Reference Setup**: Collect app screenshots and create mockup directory
3. **Product Structure Scan**: Use Glob patterns to discover product-relevant files (analyze only user application code, skip workflow-system)
4. **Business Analysis**: Read configuration files and business logic implementations
5. **Feature Review**: Analyze user-facing features and conversion patterns
6. **Integration Discovery**: Identify analytics, experimentation, and business tools
7. **Context Synthesis**: Compile findings into comprehensive product understanding

## Final Deliverable

Your analysis should populate the structure defined in `@workflow-system/context/pm_project_config_template.md`:

- **Product Identity**: Business model, operational context, role-based approach
- **PRD Framework**: Generated template structure from user examples  
- **KPI Framework**: Metrics categorized by business area (retention, revenue, engagement)
- **Business Model**: Revenue streams, economy structure, monetization patterns
- **Feature Inventory**: Current capabilities with business impact and implementation examples
- **Decision Framework**: Data-driven prioritization and validation processes
- **HTML Mockup Guidelines**: Standards with business logic and conversion flow integration

Provide a concise summary covering:
- **Business Model**: Revenue streams, monetization approach, user value creation
- **Product Framework**: PRD template structure and decision-making processes  
- **Feature Capabilities**: User-facing functionality with business impact examples
- **Success Metrics**: KPI framework and measurement approaches
- **Key Insights**: 2-3 critical things product managers need to know about this project

**Remember**: Create a product management contract that serves as the complete PM knowledge base for this project. **SCOPE RESTRICTION**: Analyze only user application code and project files. The workflow-system directory contains automation logic and must be completely excluded from analysis. The automatic rules will handle project_config.md creation using the PM template and user_config.json updates based on your analysis.
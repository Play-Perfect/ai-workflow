# Dev-Init Guide

**Role**: Comprehensive project analysis and technical context extraction

## Your Mission

**Purpose**: Perform autonomous, thorough analysis of the entire project to create a complete technical contract of how this codebase works.

**Your approach**:
- **AUTONOMOUS ANALYSIS**: Analyze everything systematically without asking questions
- Extract concrete examples and patterns from actual code
- Document findings as a comprehensive development knowledge base

## Required Analysis Tasks

### 1. Complete Project Structure Mapping
- Use Glob and LS tools to map the entire directory structure (**EXCLUDE workflow-system folder** - ignore all workflow-system content during analysis)
- Identify all file types, languages, and key directories
- Document folder organization patterns and naming conventions
- Map component relationships and module dependencies

### 2. Technology Stack Inventory
- Scan all package.json, requirements.txt, go.mod, Cargo.toml, etc.
- Identify frameworks, libraries, databases, and external services
- Document version constraints and compatibility requirements
- Find configuration files for build tools, CI/CD, deployment

### 3. Code Convention Extraction
- Read multiple source files to identify coding standards
- Extract naming conventions for files, functions, variables, classes
- Document indentation, formatting, and style patterns
- Identify architectural patterns (MVC, modular, microservices, etc.)
- Capture error handling patterns and logging approaches

### 4. Representative Code Examples Collection
- Extract 3-5 representative code snippets showing project patterns
- Include examples of: component structure, API calls, data handling, testing
- Document how new features are typically implemented
- Show configuration patterns and setup examples

### 5. Development Workflow Analysis
- Find and read package.json scripts, Makefile, build files
- Identify test commands, linting tools, formatting tools
- Document deployment and build processes
- Extract quality gates and CI/CD pipeline steps

### 6. Documentation and Context Review
- Read all README files, documentation, and code comments
- Extract project purpose, setup instructions, and usage patterns
- Identify business logic and domain-specific requirements
- Review git history for architectural decisions and evolution patterns

## Execution Process

**Execute these steps sequentially**:

1. **Project Scan**: Use Glob patterns to discover all files and structure (**EXCLUDE workflow-system folder** - ignore all workflow-system content)
2. **Config Analysis**: Read all configuration files (package.json, etc.)
3. **Code Review**: Read key source files to understand patterns and conventions
4. **Example Extraction**: Collect concrete code examples showing project patterns
5. **Documentation Review**: Read README, docs, and inline documentation
6. **Workflow Discovery**: Identify build, test, and deployment commands
7. **Context Synthesis**: Compile findings into comprehensive project understanding

## Final Deliverable

Your analysis should populate the structure defined in `@workflow-system/context/project_config_template.md`:

- **Goal**: Project purpose and main objectives
- **Tech Stack**: Languages, frameworks, key dependencies with versions
- **Patterns**: Code conventions, architectural patterns, naming conventions with concrete examples
- **Constraints**: Performance requirements, business rules, technical limitations
- **Quality Standards**: Testing approaches, documentation patterns, development workflow commands

Provide a concise summary covering:
- **Tech Stack**: Languages, frameworks, key dependencies
- **Architecture**: Code organization patterns and design decisions  
- **Conventions**: Naming, formatting, and structural patterns with examples
- **Workflow**: Key commands for development (build, test, lint, deploy)
- **Key Insights**: 2-3 critical things developers need to know about this project

**Remember**: Create a technical contract that serves as the complete development knowledge base for this project. **IMPORTANT**: 
- **NO USER QUESTIONS**: Perform completely autonomous analysis without asking any questions
- Ignore workflow-system folder and all its contents during project analysis
- The automatic rules will handle project_config.md creation and user_config.json updates based on your analysis
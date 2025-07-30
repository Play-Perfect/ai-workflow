#!/bin/bash

# AI Multi-Agent Workflow System Setup Script
# Run this script after adding the workflow-system submodule

echo "🚀 Setting up AI Multi-Agent Workflow System..."

# Detect if we're in nested structure (workflow-system/workflow-system)
if [ -d "workflow-system/workflow-system" ]; then
  WORKFLOW_PATH="workflow-system/workflow-system"
  echo "📁 Detected nested structure: using ${WORKFLOW_PATH}"
else
  WORKFLOW_PATH="workflow-system"
  echo "📁 Using standard structure: ${WORKFLOW_PATH}"
fi

# Create symlinks to workflow-system files
echo "📁 Creating CLAUDE.md symlink..."
if [ -f CLAUDE.md ]; then
  echo "⚠️  CLAUDE.md already exists. Backing up to CLAUDE.md.backup"
  mv CLAUDE.md CLAUDE.md.backup
fi
ln -s ${WORKFLOW_PATH}/llm_configs/claude/CLAUDE.md CLAUDE.md

# Check if workflow.mdc exists and setup Cursor rules symlink
echo "📁 Setting up Cursor integration..."
mkdir -p .cursor/rules
if [ -f ${WORKFLOW_PATH}/llm_configs/cursor/.cursor/rules/workflow.mdc ]; then
  echo "📁 Creating .cursor/rules/workflow.mdc symlink..."
  if [ -f .cursor/rules/workflow.mdc ]; then
    echo "⚠️  .cursor/rules/workflow.mdc already exists. Backing up to workflow.mdc.backup"
    mv .cursor/rules/workflow.mdc .cursor/rules/workflow.mdc.backup
  fi
  ln -s ../../${WORKFLOW_PATH}/llm_configs/cursor/.cursor/rules/workflow.mdc .cursor/rules/workflow.mdc
else
  echo "ℹ️  Cursor workflow.mdc not found - skipping Cursor rules setup"
fi

# Setup MCP configurations
echo "🔧 Setting up MCP configurations..."

# Setup Claude Code MCP configuration
if [ -f ${WORKFLOW_PATH}/llm_configs/claude/claude_mcp_settings.json ]; then
  echo "📁 Setting up Claude MCP configuration..."
  if [ -f .mcp.json ]; then
    echo "⚠️  .mcp.json exists. Please manually merge MCP config from ${WORKFLOW_PATH}/llm_configs/claude/claude_mcp_settings.json"
  else
    cp ${WORKFLOW_PATH}/llm_configs/claude/claude_mcp_settings.json .mcp.json
    echo "✅ Claude MCP configuration created"
  fi
else
  echo "ℹ️  Claude MCP settings not found - skipping Claude MCP setup"
fi

# Setup Cursor MCP configuration
if [ -f ${WORKFLOW_PATH}/llm_configs/cursor/cursor_mcp_settings.json ]; then
  echo "📁 Setting up Cursor MCP configuration..."
  mkdir -p .cursor
  if [ -f .cursor/mcp.json ]; then
    echo "⚠️  .cursor/mcp.json exists. Please manually merge MCP config from ${WORKFLOW_PATH}/llm_configs/cursor/cursor_mcp_settings.json"
  else
    cp ${WORKFLOW_PATH}/llm_configs/cursor/cursor_mcp_settings.json .cursor/mcp.json
    echo "✅ Cursor MCP configuration created"
  fi
else
  echo "ℹ️  Cursor MCP settings not found - skipping Cursor MCP setup"
fi


# Create workflow config directory in project root (at same level as workflow-system)
echo "📁 Creating workflow config directory in project root..."
echo "DEBUG: Current directory: $(pwd)"
echo "DEBUG: About to create ../../ai-workflow-config"
mkdir -p ../../ai-workflow-config || echo "ERROR: Failed to create ../../ai-workflow-config"
mkdir -p ../../ai-workflow-config/sessions || echo "ERROR: Failed to create sessions"
mkdir -p ../../ai-workflow-config/measurements || echo "ERROR: Failed to create measurements"
echo "DEBUG: Checking if folder exists: $(ls -la ../../ | grep ai-workflow-config || echo 'NOT FOUND')"
echo "✅ Workflow config directory created at project root level"

# Create necessary directories for workflow system (keep for backward compatibility)
echo "📁 Creating workflow directories..."
mkdir -p ${WORKFLOW_PATH}/sessions
mkdir -p ${WORKFLOW_PATH}/measurements
echo "✅ Workflow directories created"

# Set executable permissions on setup script
chmod +x ${WORKFLOW_PATH}/setup.sh

echo ""
echo "✅ Setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Restart Claude Code terminal to load MCP servers"
echo "2. Ask Cursor/Claude to help with any development task!"
echo "3. The AI workflow will automatically initialize on first use"
echo ""
echo "📍 Config locations:"
echo "   Main config: CLAUDE.md -> ${WORKFLOW_PATH}/llm_configs/claude/CLAUDE.md"
echo "   Claude MCP: .mcp.json (if created)"
echo "   Cursor MCP: .cursor/mcp.json (if created)"
echo "   Cursor rules: .cursor/rules/workflow.mdc (if created)"
echo ""
echo "📊 Workflow system ready!"
echo "   User configs: ai-workflow-config/ (in your project root)"
echo "   Sessions: ai-workflow-config/sessions/"
echo "   Measurements: ai-workflow-config/measurements/"
echo "   Rules: ${WORKFLOW_PATH}/config/rules.md"
#!/bin/bash

# AI Multi-Agent Workflow System Setup Script
# Run this script after adding the workflow-system submodule

echo "🚀 Setting up AI Multi-Agent Workflow System..."

# Create symlinks to workflow-system files
echo "📁 Creating CLAUDE.md symlink..."
if [ -f CLAUDE.md ]; then
  echo "⚠️  CLAUDE.md already exists. Backing up to CLAUDE.md.backup"
  mv CLAUDE.md CLAUDE.md.backup
fi
ln -s workflow-system/llm_configs/claude/CLAUDE.md CLAUDE.md

# Setup Cursor rules symlink
echo "📁 Creating .cursor/rules/workflow.mdc symlink..."
mkdir -p .cursor/rules
if [ -f .cursor/rules/workflow.mdc ]; then
  echo "⚠️  .cursor/rules/workflow.mdc already exists. Backing up to workflow.mdc.backup"
  mv .cursor/rules/workflow.mdc .cursor/rules/workflow.mdc.backup
fi
ln -s ../../workflow-system/llm_configs/cursor/.cursor/rules/workflow.mdc .cursor/rules/workflow.mdc

# Setup MCP configurations
echo "🔧 Setting up MCP configurations..."

# Setup Project MCP configuration (for Claude Code)
echo "📁 Setting up Claude MCP configuration..."
if [ -f .mcp.json ]; then
  echo "⚠️  .mcp.json exists. Please manually merge MCP config from workflow-system/llm_configs/cursor/cursor_mcp_settings.json"
else
  cp workflow-system/llm_configs/cursor/cursor_mcp_settings.json .mcp.json
  echo "✅ Project MCP configuration created"
fi

# Setup Cursor MCP configuration
echo "📁 Setting up Cursor MCP configuration..."
mkdir -p .cursor
if [ -f .cursor/mcp.json ]; then
  echo "⚠️  .cursor/mcp.json exists. Please manually merge MCP config from workflow-system/llm_configs/cursor/cursor_mcp_settings.json"
else
  cp workflow-system/llm_configs/cursor/cursor_mcp_settings.json .cursor/mcp.json
  echo "✅ Cursor MCP configuration created"
fi


echo ""
echo "✅ Setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Restart Claude Code terminal to load MCP servers"
echo "2. Ask Cursor/Claude to help with any development task!"
echo ""
echo "📍 Config locations:"
echo "   Claude Code MCP: .mcp.json"
echo "   Cursor MCP: .cursor/mcp.json"
echo "   Cursor rules: .cursor/rules/workflow.mdc"
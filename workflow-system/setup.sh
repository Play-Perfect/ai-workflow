#!/bin/bash

# AI Multi-Agent Workflow System Setup Script
# Run this script after adding the workflow-system submodule

echo "🚀 Setting up AI Multi-Agent Workflow System..."

# Create .cursor directory if it doesn't exist
mkdir -p .cursor/rules

# Create symlinks to workflow-system files
echo "📁 Creating CLAUDE.md symlink..."
if [ -f CLAUDE.md ]; then
  echo "⚠️  CLAUDE.md already exists. Backing up to CLAUDE.md.backup"
  mv CLAUDE.md CLAUDE.md.backup
fi
ln -s workflow-system/CLAUDE.md CLAUDE.md

echo "📁 Creating .cursor/rules/workflow.mdc symlink..."
if [ -f .cursor/rules/workflow.mdc ]; then
  echo "⚠️  .cursor/rules/workflow.mdc already exists. Backing up to workflow.mdc.backup"
  mv .cursor/rules/workflow.mdc .cursor/rules/workflow.mdc.backup
fi
ln -s ../../workflow-system/.cursor/rules/workflow.mdc .cursor/rules/workflow.mdc

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Restart Claude Code or Cursor to pick up the new configuration"
echo "2. The AI workflow system is now ready to use"
echo ""
echo "To get started, just ask Claude to help with any development task!"
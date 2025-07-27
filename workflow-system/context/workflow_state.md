# Workflow State

## State
- **Session ID**: [Generated UUID]
- **Phase**: INIT | ANALYZE | BLUEPRINT | CONSTRUCT | VALIDATE
- **Status**: STARTED | IN_PROGRESS | NEEDS_APPROVAL | COMPLETED | FAILED
- **Department**: dev | pm | bi | devops | design | qa
- **Current Agent**: [Agent name from current phase]
- **Started**: [ISO timestamp]
- **Last Updated**: [ISO timestamp]

## Plan
[Detailed implementation plan created during BLUEPRINT phase]

## Rules
[Any custom rules or constraints for this workflow session]

## Items
### Current Tasks
- [ ] [Task description]
- [x] [Completed task]

### Blockers
- [Any current blockers or dependencies]

### Next Steps  
- [Upcoming tasks or actions]

## Log
[Real-time session log entries with timestamps]

## ArchiveLog
[Archived log entries when ## Log exceeds 5000 characters]

---
*This file tracks the state of a single workflow session and is copied to sessions/ directory when workflow starts*
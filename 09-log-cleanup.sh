#!/bin/bash
# Lesson: find with -mtime, and a dry-run pattern (preview before deleting).
# Usage: ./09-log-cleanup.sh /var/log/myapp 7          (preview only)
#        ./09-log-cleanup.sh /var/log/myapp 7 --delete  (actually delete)

LOG_DIR="$1"
DAYS="${2:-7}"
MODE="$3"

if [ -z "$LOG_DIR" ]; then
    echo "Usage: $0 <log-dir> [days] [--delete]"
    exit 1
fi

echo "Log files older than $DAYS days in $LOG_DIR:"
find "$LOG_DIR" -name "*.log" -mtime +"$DAYS" -print

if [ "$MODE" = "--delete" ]; then
    find "$LOG_DIR" -name "*.log" -mtime +"$DAYS" -delete
    echo "Deleted."
else
    echo "(Preview only. Add --delete to remove them.)"
fi

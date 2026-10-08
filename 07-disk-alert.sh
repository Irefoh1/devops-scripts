#!/bin/bash
# Lesson: parsing command output and thresholds. Run it with cron on a server.
# Usage: ./07-disk-alert.sh [threshold-percent]

THRESHOLD="${1:-80}"

# df gives usage; awk grabs the % for the root filesystem; tr removes the % sign
USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$USAGE" -ge "$THRESHOLD" ]; then
    echo "WARNING: disk usage is ${USAGE}% (limit ${THRESHOLD}%)"
    exit 1
else
    echo "OK: disk usage is ${USAGE}%"
fi

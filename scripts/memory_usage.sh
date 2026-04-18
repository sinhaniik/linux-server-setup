#!/bin/bash
# /usr/local/bin/health-check.sh
set -e

# Check disk space (fail if > 90% used)
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
if [ "$DISK_USAGE" -gt 90 ]; then
    echo "Disk usage critical: ${DISK_USAGE}%"
    exit 1
fi

echo "Disk usage is ok: ${DISK_USAGE}%"

exit 0

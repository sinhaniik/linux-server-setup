#!/bin/bash
# /usr/local/bin/health-check.sh
set -e

# Check if critical service is running
if ! systemctl is-active --quiet nginx; then
    echo "Service nginx is not running"
    exit 1
fi

echo "my service is running i.e nginx"

exit 0

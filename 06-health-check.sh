#!/bin/bash
# Lesson: curl, HTTP status codes, and loops.
# Usage: ./06-health-check.sh https://example.com https://google.com

if [ $# -eq 0 ]; then
    echo "Usage: $0 <url> [url...]"
    exit 1
fi

for URL in "$@"; do
    # -s silent, -o discard body, -w print only the status code
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 "$URL")

    if [ "$STATUS" -ge 200 ] && [ "$STATUS" -lt 400 ]; then
        echo "UP    ($STATUS)  $URL"
    else
        echo "DOWN  ($STATUS)  $URL"
    fi
done

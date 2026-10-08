#!/bin/bash
# Lesson: a basic deployment script with safe error handling.
# Usage: ./08-simple-deploy.sh /path/to/app service-name

# -e stop on error, -u error on unset variables, -o pipefail catch errors in pipes
set -euo pipefail

APP_DIR="${1:?Usage: $0 <app-dir> <service-name>}"
SERVICE="${2:?Usage: $0 <app-dir> <service-name>}"

log() { echo "[$(date +%H:%M:%S)] $1"; }

log "Pulling latest code..."
cd "$APP_DIR"
git pull origin main

log "Installing dependencies..."
if [ -f package.json ]; then
    npm install --production
fi

log "Restarting $SERVICE..."
sudo systemctl restart "$SERVICE"

sleep 3
if systemctl is-active --quiet "$SERVICE"; then
    log "Deploy successful."
else
    log "Service failed to start! Check: journalctl -u $SERVICE"
    exit 1
fi

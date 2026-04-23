#!/bin/bash
set -e

echo "Starting OpenClaw Gateway on Railway..."

# Check if config exists
if [ -f "/app/config/openclaw.json" ]; then
    echo "Using config from /app/config/openclaw.json"
    export OPENCLAW_CONFIG="/app/config/openclaw.json"
fi

# Run OpenClaw gateway
exec openclaw gateway

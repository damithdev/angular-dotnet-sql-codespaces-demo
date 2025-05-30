#!/bin/bash
echo "🚀 Starting Poststart Script"
echo "🚀 Starting SQLPad with environment variables from .env..."

# Export env vars
set -a
source /workspaces/angular-dotnet-sql-codespaces-demo/.devcontainer/sqlpad/env-config
set +a


# Move to folder where local sqlpad was installed
cd /workspaces/tools/sqlpad

# Run local SQLPad
./node_modules/.bin/sqlpad > /workspaces/sqlpad-data/sqlpad.log 2>&1 &

echo "✅ post-start.sh completed successfully!"

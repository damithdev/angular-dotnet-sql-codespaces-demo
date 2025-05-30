#!/bin/bash
echo "🚀 Post-start setup starting..."

# Step 1: Backend setup
cd /workspaces/angular-dotnet-sql-codespaces-demo/backend/api
echo "🔧 Restoring .NET backend..."
dotnet restore
dotnet dev-certs https

# Step 2: Frontend setup
cd /workspaces/angular-dotnet-sql-codespaces-demo/frontend
echo "📦 Installing Angular dependencies..."
npm install
echo "✅ post-start.sh completed successfully!"

#!/bin/bash
echo "🚀 Post-create setup starting..."

# Step 1: Backend setup
cd /workspaces/angular-dotnet-sql-codespaces-demo/backend/api
echo "🔧 Restoring .NET backend..."
dotnet restore
dotnet dev-certs https

# Step 2: Frontend setup
cd /workspaces/angular-dotnet-sql-codespaces-demo/frontend
echo "📦 Installing Angular dependencies..."
npm install

# Step 3: SQLPad Setup
cd /workspaces/angular-dotnet-sql-codespaces-demo

echo "📦 Installing SQLPad locally..."
mkdir -p /workspaces/tools/sqlpad
cd /workspaces/tools/sqlpad
npm init -y
npm install sqlpad

echo "📁 Creating SQLPad data directory..."
mkdir -p /workspaces/sqlpad-data
mkdir -p /workspaces/sqlpad-seed

# Create connections.json from secrets
cat <<EOF > /workspaces/sqlpad-seed/connections.json
[
  {
    "name": "Azure SQL Server",
    "driver": "sqlserver",
    "multiStatementTransactionEnabled": true,
    "idleTimeoutSeconds": 300,
    "connection": {
      "server": "${AZ_SQL_SERVER}",
      "port": 1433,
      "database": "${AZ_SQL_DATABASE}",
      "user": "${AZ_SQL_USERNAME}",
      "password": "${AZ_SQL_PASSWORD}",
      "options": {
        "encrypt": true
      }
    }
  }
]
EOF

echo "✅ post-create.sh completed successfully!"

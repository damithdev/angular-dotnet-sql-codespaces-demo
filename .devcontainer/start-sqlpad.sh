#!/bin/bash
set -e
SQLPAD_DIR="/workspaces/tools/sqlpad"
SQLPAD_LOG="/workspaces/sqlpad-data/sqlpad.log"

cd "$SQLPAD_DIR"
cd server

# Kill any existing SQLPad process
echo "🛑 Stopping existing SQLPad if running..."
pkill -f "node server.js" || echo "No existing SQLPad process found."

# Run SQLPad in background
echo "🚀 Launching SQLPad..."
nohup node server.js --config ./config.dev.env > "$SQLPAD_LOG" 2>&1 &

echo "🔐 Setting up SQLPad connection from GitHub secrets..."

# Wait until SQLPad is reachable
until curl -s http://localhost:3000 > /dev/null; do
  echo "⏳ Waiting for SQLPad..."
  sleep 2
done

# 🌐 Set defaults
CONNECTION_NAME="${CONNECTION_NAME:-Azure SQL DB}"
CONNECTION_DRIVER="${CONNECTION_DRIVER:-sqlserver}"
CONNECTION_SERVER="${AZ_SQL_SERVER:?Environment variable AZ_SQL_SERVER is required}"
CONNECTION_PORT="${CONNECTION_PORT:-1433}"
CONNECTION_DATABASE="${AZ_SQL_DATABASE:?Environment variable AZ_SQL_DATABASE is required}"
CONNECTION_USERNAME="${AZ_SQL_USERNAME:?Environment variable AZ_SQL_USERNAME is required}"
CONNECTION_PASSWORD="${AZ_SQL_PASSWORD:?Environment variable AZ_SQL_PASSWORD is required}"

# 🧠 Re-auth using basic auth (works in your version)
BASIC_AUTH="$SQLPAD_ADMIN_EMAIL:$SQLPAD_ADMIN_PASSWORD"

# 🔍 Check if connection already exists
EXISTING_ID=$(curl -s -u "$BASIC_AUTH" http://localhost:3000/api/connections \
  | jq -r ".[] | select(.name==\"$CONNECTION_NAME\") | .id")

if [[ -n "$EXISTING_ID" ]]; then
  echo "⚠️  Connection '$CONNECTION_NAME' already exists. Deleting (ID: $EXISTING_ID)..."
  curl -s -X DELETE http://localhost:3000/api/connections/$EXISTING_ID \
    -u "$BASIC_AUTH" > /dev/null
  echo "🗑️  Old connection removed."
fi

# 🔨 Create new connection

JSON_PAYLOAD=$(jq -n \
  --arg name "$CONNECTION_NAME" \
  --arg driver "$CONNECTION_DRIVER" \
  --arg host "$CONNECTION_SERVER" \
  --arg port "$CONNECTION_PORT" \
  --arg database "$CONNECTION_DATABASE" \
  --arg username "$CONNECTION_USERNAME" \
  --arg password "$CONNECTION_PASSWORD" \
  --argjson encrypt true \
  --argjson trust true \
  '{
    name: $name,
    driver: $driver,
    host: $host,
    port: $port,
    database: $database,
    username: $username,
    password: $password,
    sqlserverEncrypt: $encrypt,
    trustServerCertificate: $trust
  }'
)


RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X POST http://localhost:3000/api/connections \
  -u "$SQLPAD_ADMIN_EMAIL:$SQLPAD_ADMIN_PASSWORD" \
  -H "Content-Type: application/json" \
  -d "$JSON_PAYLOAD")

if [[ "$RESPONSE" == "200" || "$RESPONSE" == "201" ]]; then
  echo "✅ Connection '$CONNECTION_NAME' successfully created."
else
  echo "❌ Failed to create connection. HTTP status: $RESPONSE"
  exit 1
fi

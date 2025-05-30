#!/bin/bash
set -e

echo "🛠️ Starting SQLPad setup..."

SQLPAD_DIR="/workspaces/tools/sqlpad"
SQLPAD_TAG="v7.5.3"

# Create persistent data directory
rm -rf /workspaces/sqlpad-data
mkdir -p /workspaces/sqlpad-data

# Clone the SQLPad repo at tag v7.5.3
if [ ! -d "$SQLPAD_DIR" ]; then
  echo "📦 Cloning SQLPad repo at tag $SQLPAD_TAG..."
  git clone --depth 1 --branch "$SQLPAD_TAG" https://github.com/sqlpad/sqlpad.git "$SQLPAD_DIR"
else
  echo "✅ SQLPad repo already exists. Resetting to $SQLPAD_TAG..."
  cd "$SQLPAD_DIR"
  git fetch --tags
  git checkout "$SQLPAD_TAG"
fi

cd "$SQLPAD_DIR"

# Build front-end and install dependencies
echo "📦 Installing root dependencies..."
yarn

echo "🎨 Building front-end..."
cd client
yarn
yarn build

echo "📦 Installing server dependencies..."
cd ../server
yarn

echo "📁 Copying build to server/public..."
mkdir -p public
cp -r ../client/build/* public

# Create config file
cat > config.dev.env <<EOF
SQLPAD_ADMIN=${SQLPAD_ADMIN_EMAIL}
SQLPAD_ADMIN_PASSWORD=${SQLPAD_ADMIN_PASSWORD}
SQLPAD_PORT=3000
SQLPAD_DB_PATH=/workspaces/sqlpad-data/db
EOF

#!/bin/sh
set -e

if [ ! -f "package.json" ]; then
  echo "NestJS project not found. Creating a new one..."
  nest new tmp-project --language "TypeScript" --package-manager "npm" --skip-git --skip-install
  mv tmp-project/* .
  mv tmp-project/.[!.]* .
  rm -rf tmp-project
fi

echo "Installing dependencies..."
npm install

echo "Starting NestJS server..."
exec npm run start:dev

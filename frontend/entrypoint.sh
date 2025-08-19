#!/bin/sh
set -e

if [ ! -f "package.json" ]; then
  echo "Vite project not found. Creating a new one..."
  # 임시 디렉토리에 프로젝트를 생성하여 "directory not empty" 프롬프트를 회피합니다.
  npm create vite@latest tmp-project -- --template react
  # 생성된 파일들을 현재 디렉토리로 이동합니다.
  mv tmp-project/* .
  mv tmp-project/.[!.]* .
  rm -rf tmp-project
fi

echo "Installing dependencies..."
npm install

echo "Starting Vite server..."
exec npm run dev -- --host
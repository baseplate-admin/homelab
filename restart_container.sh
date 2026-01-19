#!/usr/bin/env bash
set -e

STACKS=(
  "traefik" # Traefik (must start first)
  "tailscale"      
  # "adguard" # is known to break the entire system
  "deluge"
  "chithi"
)

BASE_DIR="$(pwd)"

echo "🚀 Starting docker stacks from: $BASE_DIR"

for stack in "${STACKS[@]}"; do
  DIR="$BASE_DIR/$stack"

  echo
  echo "➡️  Starting: $stack"

  if [ ! -d "$DIR" ]; then
    echo "❌ Directory not found: $DIR"
    exit 1
  fi

  cd "$DIR"
  docker compose down
  docker compose up -d
done

echo
echo "✅ All stacks started successfully"

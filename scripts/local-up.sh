#!/bin/bash
set -e

# 1. Always locate the absolute path of the script directory,
# regardless of where the user runs it from
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR/.."

echo "[1/4] Building local container images..."
# Navigate to project root to build images from the correct context
cd "$PROJECT_ROOT"

# Build your frontend image (adjust path/tags as needed for your setup)
docker build -t stock-frontend:latest -f src/frontend/Dockerfile src/frontend

echo "[2/4] Initializing and provisioning Kind cluster via Terraform..."
# Navigate safely to the infra/root folder relative to the script location
cd "$PROJECT_ROOT/infra/root"

terraform init
terraform apply -auto-approve

echo "[3/4] Loading images into Kind cluster..."
# Load the built image into the Kind cluster
kind load docker-image stock-frontend:latest --name stock-local-cluster

echo "[4/4] Deployment sequence completed successfully!"

#!/usr/bin/env bash
set -euo pipefail

host="${1:-http://100.76.113.128:11434}"

export OLLAMA_HOST="$host"
echo "OLLAMA_HOST set to $OLLAMA_HOST"
echo "Verify with: ./scripts/check_ollama.sh"
echo "Switch back with: source ./scripts/use_local.sh"

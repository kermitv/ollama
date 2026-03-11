#!/usr/bin/env bash
set -euo pipefail

base="${OLLAMA_HOST:-http://localhost:11434}"

if ! command -v curl >/dev/null 2>&1; then
  echo "curl is required" >&2
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is required" >&2
  exit 1
fi

echo "Checking Ollama host: $base"

if ! response="$(curl -fsS "$base/api/tags")"; then
  echo "Unable to reach Ollama at $base" >&2
  exit 1
fi

echo "Server reachable."
echo ""
echo "Installed models:"
printf '%s\n' "$response" | jq -r '.models[]?.name'

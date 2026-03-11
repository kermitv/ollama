#!/usr/bin/env bash
set -euo pipefail

# Optional remote override: source .env.win only when explicitly requested
if [ "${OLLAMA_USE_ENV_WIN:-0}" = "1" ] && [ -f ".env.win" ]; then
  # shellcheck disable=SC1091
  source .env.win
fi

base="${OLLAMA_HOST:-http://localhost:11434}"

model="${1:-}"
prompt_file="${2:-}"

if [ -z "$model" ] || [ -z "$prompt_file" ]; then
  echo "Usage: ./scripts/run.sh <model> <prompt_file>" >&2
  exit 1
fi

if [ ! -f "$prompt_file" ]; then
  echo "Prompt file not found: $prompt_file" >&2
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is required" >&2
  exit 1
fi

timestamp=$(date +%Y%m%d-%H%M%S)
prompt_name=$(basename "$prompt_file" .txt)
outfile="runs/${timestamp}.${model//:/_}.${prompt_name}.txt"
prompt_contents=$(cat "$prompt_file")

response_json=$(
  curl -sS -H "Content-Type: application/json" \
    -d "$(jq -nc --arg m "$model" --arg p "$prompt_contents" \
      '{model:$m, stream:false, options:{temperature:0, num_predict:300}, prompt:$p}')" \
    "$base/api/generate"
)

mkdir -p runs

{
  echo "Model: $model"
  echo "Host: $base"
  echo "Prompt: $prompt_file"
  echo "Timestamp: $timestamp"
  echo "------------------------------------"
  cat "$prompt_file"
  echo ""
  echo "============ OUTPUT ================"
  printf '%s\n' "$response_json" | jq -r '.response // .message.content // .error // empty'
} > "$outfile"

echo "Saved to $outfile"

#!/usr/bin/env bash
set -euo pipefail

prompt_file="${1:-}"
models_arg="${2:-}"

if [ -z "$prompt_file" ]; then
  echo "Usage: ./scripts/run_matrix.sh <prompt_file> [model1,model2,...]" >&2
  exit 1
fi

if [ ! -f "$prompt_file" ]; then
  echo "Prompt file not found: $prompt_file" >&2
  exit 1
fi

if [ -n "$models_arg" ]; then
  IFS=',' read -r -a models <<< "$models_arg"
else
  models=(
    "phi3"
    "llama3.1:8b"
    "deepseek-coder:6.7b"
    "gpt-oss:20b"
  )
fi

for model in "${models[@]}"; do
  echo "Running $model with $prompt_file"
  ./scripts/run.sh "$model" "$prompt_file"
done

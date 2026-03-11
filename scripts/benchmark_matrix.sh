#!/usr/bin/env bash
set -euo pipefail

prompt_file="${1:-}"
machine_label="${2:-}"
run_label="${3:-warm}"
models_arg="${4:-}"

if [ -z "$prompt_file" ]; then
  echo "Usage: ./scripts/benchmark_matrix.sh <prompt_file> [machine_label] [cold|warm] [model1,model2,...]" >&2
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
  echo "Benchmarking $model with $prompt_file"
  ./scripts/benchmark.sh "$model" "$prompt_file" "$machine_label" "$run_label"
done

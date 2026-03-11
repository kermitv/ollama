#!/usr/bin/env bash
set -euo pipefail

model="${1:-}"
lab="${2:-general}"

if [ -z "$model" ]; then
  echo "Usage: ./scripts/repl.sh <model> [lab]" >&2
  echo "Labs: general, extraction, coding, reasoning" >&2
  exit 1
fi

case "$lab" in
  general)
    system_prompt="You are a concise local LLM assistant. Ask clarifying questions only when ambiguity blocks progress. Prefer concrete answers."
    ;;
  extraction)
    system_prompt="You extract structured data from messy text. Prefer exact wording from the source. Return only the requested structure."
    ;;
  coding)
    system_prompt="You are a practical coding assistant. Explain tradeoffs briefly, then provide working code or shell commands."
    ;;
  reasoning)
    system_prompt="You reason carefully. State assumptions, keep the answer compact, and separate facts from guesses."
    ;;
  *)
    echo "Unknown lab: $lab" >&2
    echo "Labs: general, extraction, coding, reasoning" >&2
    exit 1
    ;;
esac

echo "Starting REPL with model=$model lab=$lab" >&2
echo "Type /bye or press Ctrl-D to exit." >&2

ollama run "$model" "$system_prompt"

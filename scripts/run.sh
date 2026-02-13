#!/usr/bin/env bash

MODEL="$1"
PROMPT_FILE="$2"

if [ -z "$MODEL" ] || [ -z "$PROMPT_FILE" ]; then
  echo "Usage: ./scripts/run.sh <model> <prompt_file>"
  exit 1
fi

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
PROMPT_NAME=$(basename "$PROMPT_FILE" .txt)
OUTFILE="runs/${TIMESTAMP}.${MODEL//:/_}.${PROMPT_NAME}.txt"

echo "Model: $MODEL" > "$OUTFILE"
echo "Prompt: $PROMPT_FILE" >> "$OUTFILE"
echo "Timestamp: $TIMESTAMP" >> "$OUTFILE"
echo "------------------------------------" >> "$OUTFILE"
cat "$PROMPT_FILE" >> "$OUTFILE"
echo "" >> "$OUTFILE"
echo "============ OUTPUT ================" >> "$OUTFILE"

ollama run "$MODEL" "$(cat "$PROMPT_FILE")" >> "$OUTFILE"

echo "Saved to $OUTFILE"
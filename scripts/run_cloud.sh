#!/usr/bin/env bash

MODEL="gpt-5.3-codex"
PROMPT_FILE="$1"

if [ -z "$PROMPT_FILE" ]; then
  echo "Usage: ./scripts/run_cloud.sh <prompt_file>"
  exit 1
fi

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
PROMPT_NAME=$(basename "$PROMPT_FILE" .txt)
OUTFILE="runs/${TIMESTAMP}.${MODEL}.${PROMPT_NAME}.txt"

echo "Model: $MODEL" > "$OUTFILE"
echo "Prompt: $PROMPT_FILE" >> "$OUTFILE"
echo "Timestamp: $TIMESTAMP" >> "$OUTFILE"
echo "------------------------------------" >> "$OUTFILE"
cat "$PROMPT_FILE" >> "$OUTFILE"
echo "" >> "$OUTFILE"
echo "============ OUTPUT ================" >> "$OUTFILE"

openai responses.create \
  -m $MODEL \
  -i "$(cat "$PROMPT_FILE")" >> "$OUTFILE"

echo "Saved to $OUTFILE"
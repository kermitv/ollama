#!/usr/bin/env bash
set -euo pipefail

cat <<'EOF'
Local serve workflow:
  1. Start the Ollama app or daemon on your machine.
  2. Verify the API:
       curl http://localhost:11434/api/tags
  3. List local models:
       ollama list
  4. Pull a model if needed:
       ollama pull llama3.1:8b
  5. Test one prompt:
       ./scripts/run.sh llama3.1:8b prompts/labs/01_general_summary.txt

Remote serve workflow:
  1. Run Ollama on the remote machine.
  2. Expose port 11434 only inside your trusted network or tunnel it.
  3. Point this repo at the remote host:
       OLLAMA_HOST=http://<host>:11434 ./scripts/check_ollama.sh
  4. Run the same labs without changing prompts:
       OLLAMA_HOST=http://<host>:11434 ./scripts/run_matrix.sh prompts/labs/02_extraction_meeting.txt

Comparison habit:
  - Use the same prompt across multiple models.
  - Save all outputs under runs/.
  - Record winners by task type in notes/model-comparison.md.
EOF

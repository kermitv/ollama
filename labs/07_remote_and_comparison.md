# Lab 07: Remote And Comparison

Purpose:
Move from local-only usage to remote-host validation without changing your prompt workflow.

Terminal steps:

```bash
OLLAMA_HOST=http://<host>:11434 ./scripts/check_ollama.sh
OLLAMA_HOST=http://<host>:11434 ./scripts/run.sh llama3.1:8b prompts/labs/02_extraction_meeting.txt
OLLAMA_HOST=http://<host>:11434 ./scripts/run_matrix.sh prompts/labs/07_remote_progression.txt
```

What to compare:

- local vs remote latency
- whether the same model behaves differently across hosts
- which tasks should stay local
- when remote capacity is worth the complexity

Decision questions:

- Which model is best for fast interactive use?
- Which model is best for coding help?
- Which model is best for structured extraction?
- Which tasks do you keep local even after remote access exists?

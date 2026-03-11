# Lab 07: Remote And Comparison

Purpose:
Move from local-only usage to remote-host validation without changing your prompt workflow.

Why this matters:

This lab teaches the cleanest upgrade path: keep your prompt and evaluation workflow stable, and change only the host. That lets you compare infrastructure choices without rewriting your process.

What you are learning:

- how to point the same scripts at a remote Ollama server
- how to compare local and remote behavior fairly
- when remote capacity is worth the extra operational complexity

Terminal steps:

```bash
OLLAMA_HOST=http://<host>:11434 ./scripts/check_ollama.sh
OLLAMA_HOST=http://<host>:11434 ./scripts/run.sh llama3.1:8b prompts/labs/02_extraction_meeting.txt
OLLAMA_HOST=http://<host>:11434 ./scripts/run_matrix.sh prompts/labs/07_remote_progression.txt
```

Step-by-step approach:

1. Verify the remote host answers `/api/tags`.
2. Run one known prompt against one known model.
3. Run the same comparison prompt locally and remotely.
4. Compare speed, consistency, and operational friction.

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

What good looks like:

- the same commands work with only `OLLAMA_HOST` changed
- you can explain when local is simpler and when remote is justified
- your comparison is based on repeated prompts, not memory

Common failure modes:

- comparing different prompts across hosts
- confusing network delay with model quality
- exposing a remote host too broadly instead of keeping it private or tunneled

Exit criteria:

- you can run the same scripted lab locally and remotely
- you can explain a local-first workflow that still leaves room for remote capacity

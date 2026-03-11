# Lab 07: Remote And Comparison

Purpose:
Move from local-only usage to remote-host validation without changing your prompt workflow.

When to do this:

Do this lab only after the local-first path feels normal.
You should already be comfortable running prompts locally, comparing models locally, and interpreting saved outputs in `runs/`.

Why this matters:

This lab teaches the cleanest upgrade path: keep your prompt and evaluation workflow stable, and change only the host. That lets you compare infrastructure choices without rewriting your process.

What you are learning:

- how to point the same scripts at a remote Ollama server
- how to compare local and remote behavior fairly
- when remote capacity is worth the extra operational complexity

Before you begin:

- make sure your Windows machine is online in Tailscale
- make sure Ollama is installed there
- make sure the Ollama server is actually running there
- use the Windows guide if you need help starting or verifying the remote environment

Terminal steps:

```bash
source ./scripts/use_windows.sh
./scripts/check_ollama.sh
./scripts/run.sh llama3.1:8b prompts/labs/02_extraction_meeting.txt
./scripts/run_matrix.sh prompts/labs/07_remote_progression.txt
source ./scripts/use_local.sh
```

Windows PowerShell local override example:

```powershell
$env:OLLAMA_HOST='http://100.76.113.128:11434'
.\scripts\check_ollama.ps1
.\scripts\run.ps1 llama3.1:8b prompts/labs/02_extraction_meeting.txt
.\scripts\run_matrix.ps1 prompts/labs/07_remote_progression.txt
Remove-Item Env:OLLAMA_HOST
```

Step-by-step approach:

1. Verify the remote host answers `/api/tags`.
2. Run one known prompt against one known model.
3. Run the same comparison prompt locally and remotely.
4. Compare speed, consistency, and operational friction.

Convenience flow for your Windows box:

```bash
source ./scripts/use_windows.sh
./scripts/check_ollama.sh
```

Mac shell with explicit remote host:

```bash
OLLAMA_HOST=http://100.76.113.128:11434 ./scripts/check_ollama.sh
OLLAMA_HOST=http://100.76.113.128:11434 ./scripts/run_matrix.sh prompts/labs/07_remote_progression.txt
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

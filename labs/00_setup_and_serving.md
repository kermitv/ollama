# Lab 00: Setup And Serving

Purpose:
Learn how local serving works before comparing models.

Why this matters:

Every later lab assumes you can answer three questions quickly:

- Is Ollama running?
- Which models are available?
- Am I talking to the host I think I am talking to?

If you skip this, later failures will be harder to diagnose because you will not know whether the issue is the model, the prompt, or the server.

What you are learning:

- how to verify Ollama is reachable
- how to see which models are installed
- how to pull a missing model
- how local and remote hosts use the same HTTP API

Prerequisites:

- `ollama` installed
- `curl` installed
- `jq` installed
- at least one pulled model

Terminal steps:

```bash
./scripts/serve_notes.sh
./scripts/check_ollama.sh
ollama list
```

What each command does:

- `./scripts/serve_notes.sh` shows the local and remote workflow in one place
- `./scripts/check_ollama.sh` verifies the HTTP API and lists installed models
- `ollama list` confirms the local CLI sees the same models you expect

If `./scripts/check_ollama.sh` fails:

- make sure Ollama is running
- confirm port `11434` is available locally
- check whether `OLLAMA_HOST` is set to an unexpected value in your shell

If a model is missing:

```bash
ollama pull phi3
ollama pull llama3.1:8b
ollama pull deepseek-coder:6.7b
ollama pull gpt-oss:20b
```

First exercise:

```bash
./scripts/run.sh llama3.1:8b prompts/labs/01_general_summary.txt
```

What to observe:

- Is the server running?
- Which models are actually available locally?
- How much latency do you feel on small vs large models?
- Which models are fast enough for local interactive use?

What good looks like:

- `check_ollama.sh` lists models successfully
- `run.sh` writes a file into `runs/`
- you can tell which models feel light enough for REPL work

Common mistakes:

- Ollama app not started
- assuming a model is installed because it exists on another machine
- mixing local CLI usage with a remote `OLLAMA_HOST` without noticing

Exit criteria:

- you can list models locally
- you can run one scripted prompt successfully
- you can explain the difference between local CLI use and the HTTP API

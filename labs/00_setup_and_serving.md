# Lab 00: Setup And Serving

Purpose:
Learn how local serving works before comparing models.

What you are learning:

- how to verify Ollama is reachable
- how to see which models are installed
- how to pull a missing model
- how local and remote hosts use the same HTTP API

Terminal steps:

```bash
./scripts/serve_notes.sh
./scripts/check_ollama.sh
ollama list
```

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

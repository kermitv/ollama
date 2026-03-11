# Ollama Model Evaluation Lab

Purpose:
Structured experimentation with local LLMs running via Ollama.

Goals:
- Compare model behavior
- Evaluate JSON reliability
- Evaluate coding quality
- Measure reasoning style
- Understand prompt sensitivity
- Prepare for Livefy integration

Models Installed:
- phi3
- llama3.1:8b
- deepseek-coder:6.7b
- gpt-oss:20b

Structure:
- prompts/   → Reusable test prompts
- runs/      → Captured model outputs (not versioned)
- notes/     → Observations and conclusions
- scripts/   → Helper scripts to run experiments
- labs/      → Guided REPL and script exercises

Usage:
- Local Ollama: `./scripts/run.sh llama3.1:8b prompts/001_extraction.txt`
- Remote Ollama: set `OLLAMA_HOST=http://<host>:11434` or use `.env.win`
- Cloud comparison: `./scripts/run_cloud.sh prompts/001_extraction.txt`
- Guided labs: start with `labs/README.md`

Suggested progression:
- Verify serving: `./scripts/check_ollama.sh`
- Learn local REPL use: `./scripts/repl.sh phi3 general`
- Compare models on one task: `./scripts/run_matrix.sh prompts/labs/02_extraction_meeting.txt`
- Practice coding and logic labs: see `labs/05_simple_programs.md` and `labs/06_logic_and_debugging.md`
- Move to remote-host runs later with `OLLAMA_HOST=http://<host>:11434`

This lab is isolated from production projects.

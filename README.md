# Ollama Model Evaluation Lab

Purpose:
Structured experimentation with local LLMs running via Ollama.

This repo is a practical, local-first learning lab.
It exists to document how small and medium local models actually behave in day-to-day use, not just in abstract benchmarks.
The focus is hands-on: prompt discipline, model comparison, coding usefulness, structured extraction, reasoning quality, and the tradeoffs between local and remote execution.

## Intent

The intent of this repo is to make local LLM work more concrete for working developers.

- start on one machine with local models
- learn through repeatable exercises instead of vague demos
- compare models on the same prompts
- understand when local is enough
- move to remote hosts only when there is a real reason

This is not meant to be a polished framework or a benchmark theater project.
It is a working lab for learning, documenting decisions, and building a grounded sense of which models are useful for which kinds of tasks.

## Who This Is For

This repo is most useful for people who:

- want to learn local LLM workflows without starting in the cloud
- want terminal-first exercises instead of a GUI-heavy setup
- care about model behavior on practical tasks like extraction, coding, debugging, and reasoning
- want to compare laptops, remote boxes, and future hardware using the same workflow

## What Public Participation Looks Like

If you are using this repo publicly, the most useful contributions are:

- additional lab prompts that reveal real model differences
- benchmark results from different hardware
- better evaluation rubrics for usefulness, not just speed
- documentation improvements that make the local-first path clearer
- notes on remote-host workflows that stay simple and reproducible

The goal is not maximum feature count.
The goal is higher-signal experiments and better shared judgment.

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
- benchmarks/ → Repeatable machine and host comparisons

## Execution Modes

This repo supports three distinct modes of use:

- Mac local -> Mac Ollama
- Windows local -> Windows Ollama
- Mac client -> remote Windows Ollama over LAN or Tailscale

Those modes should be documented and benchmarked separately because they measure different things.

Usage:
- Local Ollama on Mac or Linux: `./scripts/run.sh llama3.1:8b prompts/001_extraction.txt`
- Local Ollama on Windows PowerShell: `.\scripts\run.ps1 llama3.1:8b prompts/labs/01_general_summary.txt`
- Remote Ollama from a Mac client: set `OLLAMA_HOST=http://<host>:11434`
- Remote Ollama via `.env.win`: `OLLAMA_USE_ENV_WIN=1 ./scripts/run.sh llama3.1:8b prompts/001_extraction.txt`
- Cloud comparison: `./scripts/run_cloud.sh prompts/001_extraction.txt`
- Guided labs: start with `labs/README.md`

Suggested progression:
- Verify serving locally first
- Learn local REPL use
- Compare models on one task locally
- Practice coding and logic labs locally
- Move to remote-host runs later with `OLLAMA_HOST=http://<host>:11434`

## Start Here

- If you want the learning path, start with [labs/README.md](c:\dev\projects\ollama\labs\README.md)
- If you want the remote workflow from Mac to Windows, use [labs/remote_windows_from_mac.md](c:\dev\projects\ollama\labs\remote_windows_from_mac.md)
- If you want machine comparisons, use [benchmarks/README.md](c:\dev\projects\ollama\benchmarks\README.md)
- If you want the shortest first command on Mac or Linux, run `./scripts/check_ollama.sh`
- If you want the shortest first command on Windows PowerShell, run `.\scripts\check_ollama.ps1`

## Contributing

If you open issues or pull requests, high-signal contributions are preferred over broad ideas.

- keep additions local-first unless there is a strong reason otherwise
- prefer small, repeatable prompts over large speculative test suites
- document what a new lab or benchmark is trying to reveal
- include concrete machine, model, and host context when sharing results

This lab is isolated from production projects, but it is intentionally public so other developers can compare notes, prompts, hardware, and workflow tradeoffs.

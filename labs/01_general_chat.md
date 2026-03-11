# Lab 01: General Chat

Purpose:
Establish a baseline for tone, responsiveness, and obedience to simple instructions.

Why this matters:

Before using a model for structured work, you need a feel for how literal it is, how verbose it is, and how often it follows small constraints cleanly.

What you are learning:

- which models are concise by default
- which models follow simple formatting rules well
- which models drift or over-explain

Recommended setup:

```bash
./scripts/repl.sh phi3 general
./scripts/repl.sh llama3.1:8b general
```

Windows PowerShell:

```powershell
.\scripts\repl.ps1 phi3 general
.\scripts\repl.ps1 llama3.1:8b general
```

Questions to ask in REPL:

- "Summarize this repo in four bullets."
- "What can I learn here about local LLM workflows?"
- "Explain `OLLAMA_HOST` like I am new to local inference."

Script prompt:

- `prompts/labs/01_general_summary.txt`

Suggested scripted run:

```bash
./scripts/run_matrix.sh prompts/labs/01_general_summary.txt
```

Windows PowerShell:

```powershell
.\scripts\run_matrix.ps1 prompts/labs/01_general_summary.txt
```

What to compare:

- Did the model stay concise?
- Did it follow formatting constraints?
- Did it infer details that were not provided?

What good looks like:

- the answer is short, direct, and on-topic
- the bullet count or requested format is respected
- the model does not invent repo details

Common failure modes:

- adding extra explanation after the requested format
- turning bullets into paragraphs
- confidently inventing features not present in the repo

Exit criteria:

- you can name one model you prefer for quick chat
- you can name one model that follows constraints better than the others

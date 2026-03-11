# Lab 03: Coding

Purpose:
Compare code-generation quality, shell safety, and practical usefulness.

Why this matters:

Coding help is one of the highest-value local use cases. The goal is not just "can it generate code" but "can it generate code you would actually keep."

What you are learning:

- which models write safer shell and Python code
- which models understand practical constraints
- which models produce code that needs the fewest repairs

Recommended setup:

```bash
./scripts/repl.sh deepseek-coder:6.7b coding
./scripts/repl.sh llama3.1:8b coding
```

Questions to ask in REPL:

- "Write a Bash helper that posts a prompt to Ollama and stores the response."
- "Review this shell script for failure modes."
- "Generate a Python example using `requests` for the Ollama API."

Script prompt:

- `prompts/labs/03_coding_shell.txt`

Suggested scripted run:

```bash
./scripts/run_matrix.sh prompts/labs/03_coding_shell.txt "deepseek-coder:6.7b,llama3.1:8b,gpt-oss:20b"
```

What to compare:

- correctness
- defensive coding
- readability
- testability

What good looks like:

- inputs are validated
- errors fail clearly
- shell quoting is safe
- the code is short enough to maintain

Common failure modes:

- missing error handling
- unsafe quoting
- assuming dependencies without stating them
- producing code that looks plausible but does not actually fit the requested interface

Exit criteria:

- you can name a preferred coding model for shell tasks
- you can explain why one model is stronger than another for practical code generation

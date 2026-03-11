# Lab 05: Simple Programs

Purpose:
Use local models for small, concrete coding tasks instead of large open-ended requests.

Why this matters:

Many day-to-day wins from local models come from generating small utilities, not giant systems. This lab helps you judge whether a model can produce code that is actually runnable and worth keeping.

What you are learning:

- how models handle small program structure
- whether they manage file I/O cleanly
- whether they can keep a program inside size and dependency constraints

Recommended setup:

```bash
./scripts/repl.sh deepseek-coder:6.7b coding
./scripts/repl.sh gpt-oss:20b coding
```

REPL exercises:

- "Write a Python CLI that tracks todos in a JSON file."
- "Write a Bash calculator that supports add, sub, mul, div."
- "Generate a script that renames files using a prefix and timestamp."

Script prompt:

- `prompts/labs/05_simple_program_python.txt`

Suggested scripted run:

```bash
./scripts/run_matrix.sh prompts/labs/05_simple_program_python.txt "deepseek-coder:6.7b,llama3.1:8b,gpt-oss:20b"
```

What to compare:

- whether the program runs with minimal edits
- argument handling
- file I/O safety
- readability and maintainability

Recommended models:

- `deepseek-coder:6.7b` first
- `llama3.1:8b` second
- `gpt-oss:20b` for harder versions

What good looks like:

- the program has a clear entrypoint
- argument parsing is not brittle
- local file writes are predictable
- the code stays within the requested limits

Common failure modes:

- overengineering a simple task
- missing input validation
- code that exceeds the constraints but looks polished

Exit criteria:

- you can identify the model that gives you the best first draft for small utilities
- you can describe the kinds of small programs you trust a local model to draft

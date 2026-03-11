# Ollama Labs

These labs are organized as a natural progression from setup to serving to model comparison and practical use.

Use the models already listed in the repo:

- `phi3`
- `llama3.1:8b`
- `deepseek-coder:6.7b`
- `gpt-oss:20b`

## Recommended Order

1. [Lab 00: Setup And Serving](./00_setup_and_serving.md)
2. [Lab 01: General Chat](./01_general_chat.md)
3. [Lab 02: Extraction](./02_extraction.md)
4. [Lab 03: Coding](./03_coding.md)
5. [Lab 04: Reasoning](./04_reasoning.md)
6. [Lab 05: Simple Programs](./05_simple_programs.md)
7. [Lab 06: Logic And Debugging](./06_logic_and_debugging.md)
8. [Lab 07: Remote And Comparison](./07_remote_and_comparison.md)

## How To Use This Curriculum

Each lab should be done in order the first time through.

- Start with the terminal commands in the lab.
- Run at least one exercise in REPL mode.
- Run at least one scripted prompt and save the output.
- Record what model performed best for that task.
- Do not move on until you can explain what changed between models.

Each lab now includes:

- what you are learning
- why the lab matters
- exact commands to run
- what strong output looks like
- common failure modes
- exit criteria for moving forward

## Terminal Entry Points

Check serving:

```bash
./scripts/serve_notes.sh
./scripts/check_ollama.sh
```

REPL mode:

```bash
./scripts/repl.sh phi3 general
./scripts/repl.sh llama3.1:8b extraction
./scripts/repl.sh deepseek-coder:6.7b coding
./scripts/repl.sh gpt-oss:20b reasoning
```

Single scripted run:

```bash
./scripts/run.sh llama3.1:8b prompts/labs/01_general_summary.txt
```

Multi-model comparison:

```bash
./scripts/run_matrix.sh prompts/labs/02_extraction_meeting.txt
```

Remote host comparison:

```bash
OLLAMA_HOST=http://<host>:11434 ./scripts/check_ollama.sh
OLLAMA_HOST=http://<host>:11434 ./scripts/run_matrix.sh prompts/labs/07_remote_progression.txt
```

## What The Labs Teach

- how to verify and serve models locally
- how to exercise models interactively in the terminal
- how to compare models on the same scripted task
- how to use models for structured extraction
- how to use models for coding and small program generation
- how to ask for logic help, debugging ideas, and next-step suggestions
- how to move from local-only use to remote-host workflows

## Suggested Learning Pace

- Lab 00 to Lab 02: one focused session
- Lab 03 to Lab 06: one or two sessions depending on how much you code
- Lab 07: do this only after you are comfortable with local-only runs

If you only want the shortest useful path, do:

1. Lab 00
2. Lab 02
3. Lab 03
4. Lab 06
5. Lab 07

## Comparison Rubric

For each run, capture:

- instruction following
- output format compliance
- hallucination rate
- usefulness
- speed
- token efficiency

Update `notes/model-comparison.md` with your conclusions after each lab.

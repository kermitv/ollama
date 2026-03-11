# Ollama Labs

These labs are organized as a natural progression from setup to serving to model comparison and practical use.

The repo now has three distinct ways to run the labs.
Keep them conceptually separate because they answer different questions.

## Execution Modes

### 1. Mac local -> Mac Ollama

Use this when:

- you want the simplest path
- you are learning prompt behavior
- you want to measure local model performance without network effects

This is the default path through Lab 06.

### 2. Windows local -> Windows Ollama

Use this when:

- you copied the repo onto Windows
- you want to run the same labs directly from PowerShell
- you want native Windows timings without a Mac client in the loop

The repo already includes PowerShell entry points for serving checks, single runs, REPL usage, and multi-model scripted runs.

### 3. Mac client -> remote Windows Ollama

Use this when:

- you want to compare your Mac against a Windows GPU host
- you want to keep the prompts and workflow the same while changing only the host
- you want to measure remote end-to-end experience over LAN or Tailscale

This is the path for Lab 07 and the benchmark guide.

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
9. [Lab 08: Mode Comparison Mini-Lab](./08_mode_comparison_mini_lab.md)

## How To Use This Curriculum

Each lab should be done in order the first time through.

- Start with the terminal commands in the lab.
- Run at least one exercise in REPL mode.
- Run at least one scripted prompt and save the output.
- Record what model performed best for that task.
- Do not move on until you can explain what changed between models.

Each lab includes:

- what you are learning
- why the lab matters
- exact commands to run
- what strong output looks like
- common failure modes
- exit criteria for moving forward

## Local-First Paths

### Mac local path

If you are learning local models on your Mac, use this path:

1. [Lab 00: Setup And Serving](./00_setup_and_serving.md)
2. [Lab 01: General Chat](./01_general_chat.md)
3. [Lab 02: Extraction](./02_extraction.md)
4. [Lab 03: Coding](./03_coding.md)
5. [Lab 04: Reasoning](./04_reasoning.md)
6. [Lab 05: Simple Programs](./05_simple_programs.md)
7. [Lab 06: Logic And Debugging](./06_logic_and_debugging.md)

Only move to [Lab 07: Remote And Comparison](./07_remote_and_comparison.md) after you are comfortable with local runs.
Use [Lab 08: Mode Comparison Mini-Lab](./08_mode_comparison_mini_lab.md) when you want one fixed side-by-side exercise across all three execution modes.

### Windows local path

If you copied the repo to Windows and want to stay fully local on Windows:

1. Start with [Lab 00: Setup And Serving](./00_setup_and_serving.md)
2. Use the PowerShell commands where provided
3. Keep `OLLAMA_HOST` pointed at `http://localhost:11434` unless you are intentionally testing a remote machine
4. Use `.\scripts\repl.ps1` for interactive work and `.\scripts\run_matrix.ps1` for scripted comparisons
5. Treat any remaining `.sh` examples as the Unix equivalents of the same workflow

## Terminal Entry Points

### Mac or Linux shell

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

### Windows PowerShell

Check serving:

```powershell
.\scripts\serve_notes.ps1
.\scripts\check_ollama.ps1
ollama list
```

Single scripted run:

```powershell
.\scripts\run.ps1 llama3.1:8b prompts/labs/01_general_summary.txt
```

REPL mode:

```powershell
.\scripts\repl.ps1 phi3 general
.\scripts\repl.ps1 llama3.1:8b extraction
```

Multi-model comparison:

```powershell
.\scripts\run_matrix.ps1 prompts/labs/02_extraction_meeting.txt
```

## Remote Windows From Mac

When you want to run the labs from your Mac against Ollama on the Windows machine, use:

- [Windows Remote Guide](./windows_remote_guide.md)
- [Remote Windows From Mac](./remote_windows_from_mac.md)
- [Lab 07: Remote And Comparison](./07_remote_and_comparison.md)
- [Lab 08: Mode Comparison Mini-Lab](./08_mode_comparison_mini_lab.md)

## What The Labs Teach

- how to verify and serve models locally
- how to exercise models interactively in the terminal
- how to compare models on the same scripted task
- how to use models for structured extraction
- how to use models for coding and small program generation
- how to ask for logic help, debugging ideas, and next-step suggestions
- how to move from local-only use to remote-host workflows
- how to compare Mac local, Windows local, and Mac-to-Windows remote runs with one fixed prompt

## Suggested Learning Pace

- Lab 00 to Lab 02: one focused session
- Lab 03 to Lab 06: one or two sessions depending on how much you code
- Lab 07 to Lab 08: do this only after you are comfortable with local-only runs

If you only want the shortest useful path, do:

1. Lab 00
2. Lab 02
3. Lab 03
4. Lab 06
5. Lab 07
6. Lab 08

## Benchmarking

When you want to compare your M1 Mac, Windows GPU host, and future Mac, use:

- [Benchmark Guide](../benchmarks/README.md)

The benchmark scripts in this repo are shell-based today, so benchmark automation is documented for Mac local and Mac-to-remote-host paths.
If you want true Windows-local benchmark numbers, either run equivalent shell tooling there or add a PowerShell benchmark script first.

## Comparison Rubric

For each run, capture:

- instruction following
- output format compliance
- hallucination rate
- usefulness
- speed
- token efficiency

Update `notes/model-comparison.md` with your conclusions after each lab.


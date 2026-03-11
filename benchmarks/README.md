# Benchmarks

This repo includes a lightweight benchmark workflow for comparing:

- your MacBook Pro M1 2020
- your Windows GPU box over Tailscale
- your future MacBook Pro M5 Max 128 GB

The goal is not just raw speed.
You want to compare latency, throughput, load cost, and usability on the same prompts.

## What The Scripts Record

The benchmark scripts record Ollama timing fields from `/api/generate`:

- `total_duration`
- `load_duration`
- `prompt_eval_count`
- `prompt_eval_duration`
- `eval_count`
- `eval_duration`

They also compute:

- prompt tokens per second
- generation tokens per second

When you benchmark on local macOS against `localhost`, the script also records a simple memory snapshot before and after the run using:

- `vm_stat`
- `memory_pressure`

When you point at a remote host, the script marks memory as unavailable because your Mac cannot accurately measure RAM on the remote machine from this repo.

## Recommended Benchmark Times

For each machine, benchmark at these moments:

1. Cold run on a model after it has not been used recently
2. Warm run on the same model immediately afterward
3. One full comparison sweep across several models

That lets you separate:

- model load cost
- steady-state generation speed
- practical interactive usability

## Commands

Single benchmark:

```bash
./scripts/benchmark.sh llama3.1:8b prompts/labs/01_general_summary.txt m1-2020 cold
./scripts/benchmark.sh llama3.1:8b prompts/labs/01_general_summary.txt m1-2020 warm
```

Multi-model benchmark:

```bash
./scripts/benchmark_matrix.sh prompts/labs/02_extraction_meeting.txt m1-2020 warm
```

Windows later:

```bash
source ./scripts/use_windows.sh
./scripts/benchmark_matrix.sh prompts/labs/02_extraction_meeting.txt windows-gpu warm
source ./scripts/use_local.sh
```

## Suggested Prompt Set

Use the same prompt set on every machine:

- `prompts/labs/01_general_summary.txt`
- `prompts/labs/02_extraction_meeting.txt`
- `prompts/labs/03_coding_shell.txt`
- `prompts/labs/04_reasoning_workflow.txt`
- `prompts/labs/05_simple_program_python.txt`
- `prompts/labs/06_logic_debugging.txt`

## Output Files

Benchmark output is written to `benchmarks/results/` as JSON files.

That directory is gitignored so you can keep machine-specific results locally without polluting the repo.

## How To Compare Machines

Record at least these attributes for every machine:

- machine label
- OS
- RAM
- Ollama version
- model tag
- cold or warm run
- total duration
- load duration
- prompt tokens/sec
- generation tokens/sec
- notes on responsiveness

Use [results-template.csv](./results-template.csv) as a manual summary sheet.

## Important Caveat For Remote Runs

When you benchmark the Windows machine over Tailscale, the measured latency includes network overhead.

So keep two ideas separate:

- remote end-to-end experience from the Mac
- true model throughput on the Windows box

If you later want true Windows-side memory and process metrics, collect them directly on the Windows host.

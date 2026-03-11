# Benchmarks

This repo includes a lightweight benchmark workflow for comparing:

- your MacBook Pro M1 2020 running Ollama locally
- your Mac acting as a client to the Windows box over LAN or Tailscale
- your future MacBook Pro M5 Max 128 GB

The goal is not just raw speed.
You want to compare latency, throughput, load cost, and usability on the same prompts.

## Benchmark Modes

Keep these benchmark modes separate because they mean different things.

### 1. Local Mac benchmark

This measures local inference on the Mac itself.
Use this when you want the cleanest baseline.

### 2. Mac -> remote Windows benchmark

This measures end-to-end experience from the Mac while Ollama runs on Windows.
Use this when you care about practical remote usage over LAN or Tailscale.

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

For each machine or host path, benchmark at these moments:

1. Cold run on a model after it has not been used recently
2. Warm run on the same model immediately afterward
3. One full comparison sweep across several models

That lets you separate:

- model load cost
- steady-state generation speed
- practical interactive usability

## Commands

### Local Mac benchmark

```bash
./scripts/benchmark.sh llama3.1:8b prompts/labs/01_general_summary.txt m1-2020 cold
./scripts/benchmark.sh llama3.1:8b prompts/labs/01_general_summary.txt m1-2020 warm
```

### Mac -> remote Windows over LAN

```bash
OLLAMA_HOST=http://192.168.1.50:11434 ./scripts/benchmark.sh llama3.1:8b prompts/labs/01_general_summary.txt windows-lan cold
OLLAMA_HOST=http://192.168.1.50:11434 ./scripts/benchmark_matrix.sh prompts/labs/02_extraction_meeting.txt windows-lan warm
```

### Mac -> remote Windows over Tailscale

```bash
OLLAMA_HOST=http://100.76.113.128:11434 ./scripts/benchmark.sh llama3.1:8b prompts/labs/01_general_summary.txt windows-ts cold
OLLAMA_HOST=http://100.76.113.128:11434 ./scripts/benchmark_matrix.sh prompts/labs/02_extraction_meeting.txt windows-ts warm
```

### Windows local benchmark

This repo does not currently include a PowerShell benchmark script.
If you want true Windows-local numbers, add a Windows-native benchmark path or run equivalent shell tooling in a compatible Unix environment on that machine.
Do not label Mac-to-remote runs as Windows-local benchmarks.

## Suggested Prompt Set

Use the same prompt set on every machine and host path:

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

Record at least these attributes for every machine or host path:

- machine label
- client machine
- server machine
- local or remote
- LAN or Tailscale when remote
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

When you benchmark the Windows machine from the Mac over LAN or Tailscale, the measured latency includes network overhead.

So keep these ideas separate:

- remote end-to-end experience from the Mac
- true model throughput on the Windows box

If you later want true Windows-side memory and process metrics, collect them directly on the Windows host.

## Related Docs

- [Labs Overview](../labs/README.md)
- [Remote Windows From Mac](../labs/remote_windows_from_mac.md)
- [Lab 07: Remote And Comparison](../labs/07_remote_and_comparison.md)


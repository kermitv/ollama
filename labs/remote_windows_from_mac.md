# Remote Windows From Mac

Purpose:
Run the labs from your Mac while using Ollama on the Windows machine over LAN or Tailscale.

This guide exists because remote execution answers a different question from local execution.
You are measuring the full user experience of a Mac client talking to a Windows host.

## Use This Guide When

Use this guide when:

- the prompts live on your Mac
- you want the Windows box to do inference
- you want to keep the same prompts and scripts while changing only the host
- you want to compare local Mac versus remote Windows behavior fairly

## Do Not Use This Guide When

Do not use this guide when:

- you are trying to learn the basics for the first time
- you copied the repo to Windows and want to run locally there
- you want pure Windows-side timing without network overhead

For those cases, stay local on Mac or local on Windows first.

## Choose A Network Path

### Option 1: LAN

Use LAN if both machines are on the same network and you want the lowest-latency remote setup.

Example:

```bash
export OLLAMA_HOST=http://192.168.1.50:11434
./scripts/check_ollama.sh
```

### Option 2: Tailscale

Use Tailscale if you want the same workflow outside the home LAN or you want a private, stable machine address.

Example:

```bash
export OLLAMA_HOST=http://100.76.113.128:11434
./scripts/check_ollama.sh
```

If you want one remote workflow to keep long term, Tailscale is usually the better operational choice.

## Standard Remote Workflow

From your Mac:

```bash
export OLLAMA_HOST=http://100.76.113.128:11434
./scripts/check_ollama.sh
./scripts/run.sh llama3.1:8b prompts/labs/01_general_summary.txt
./scripts/run_matrix.sh prompts/labs/02_extraction_meeting.txt
```

To switch back to local Mac Ollama:

```bash
unset OLLAMA_HOST
./scripts/check_ollama.sh
```

## Helper Script Workflow

If your [`scripts/use_windows.sh`](../scripts/use_windows.sh) points at the right Windows host, you can use:

```bash
source ./scripts/use_windows.sh
./scripts/check_ollama.sh
./scripts/run_matrix.sh prompts/labs/07_remote_progression.txt
source ./scripts/use_local.sh
```

## What To Compare

When you compare local Mac to remote Windows, keep the prompt and model tag the same.
Change only the host.

Compare:

- perceived latency
- total duration
- load duration
- generation speed
- operational friction
- whether the larger Windows machine changes which models are practical

## What The Timing Means

Remote timings include both model work and network cost.
Treat these as end-to-end timings, not pure inference timings.

### Good comparison question

- Is remote Windows fast enough overall to feel better than local Mac for this model?

### Bad comparison question

- Is this number the raw speed of the model alone?

It is not.
It is the speed of the full path from Mac prompt to Windows inference to Mac-visible response.

## Common Failure Modes

- `OLLAMA_HOST` still points at a remote machine when you thought you were local
- the Windows host is reachable by Tailscale but Ollama is not listening on a reachable address
- you compare different prompt files across hosts
- you compare a warm remote run against a cold local run and call it a fair result

## Suggested Benchmark Habit

For each model and host path, record:

- host label
- local or remote
- LAN or Tailscale
- cold or warm
- total duration
- load duration
- notes on responsiveness

Then keep those notes next to the saved run outputs.

## Related Docs

- [Windows Remote Guide](./windows_remote_guide.md)
- [Lab 07: Remote And Comparison](./07_remote_and_comparison.md)
- [Lab 08: Mode Comparison Mini-Lab](./08_mode_comparison_mini_lab.md)
- [Benchmark Guide](../benchmarks/README.md)



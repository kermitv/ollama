# Windows Remote Guide

Purpose:
Use your Windows Ollama environment from another machine only when you are ready to compare it with local execution.

This guide is intentionally separate from the main learning path.
If your current goal is local learning, skip this file for now.

## What This Guide Covers

- when to use a remote Windows host instead of local execution
- how to point the repo at the Windows host
- how to verify the remote Ollama API
- how to switch back to local cleanly
- how to think about LAN versus Tailscale

## The Core Distinction

This repo has three different execution modes:

- Mac local -> Mac Ollama
- Windows local -> Windows Ollama
- Mac client -> remote Windows Ollama

This guide is only about the third mode.
It is not the guide for running the labs locally on Windows.

## When To Stay Local

Stay local when:

- you are still learning prompt behavior
- you want the fewest moving parts
- you are iterating quickly in the terminal
- your local model speed is acceptable

Local should be your default.
Remote Windows should be an explicit choice, not the baseline.

## When To Try Windows Remotely

Try the Windows environment when:

- you want to compare the same model on a different machine
- you want access to models or hardware that are not on your Mac
- you want to measure whether remote latency is worth the tradeoff

## LAN Versus Tailscale

### LAN

Use LAN when:

- both machines are on the same local network
- you want the lowest-latency remote path
- you are doing a controlled home or office comparison

Typical host format:

- `http://192.168.x.x:11434`

### Tailscale

Use Tailscale when:

- the machines are not always on the same LAN
- you want a stable private overlay network
- you want the same workflow locally and away from home

Typical host format:

- `http://100.x.y.z:11434`

Tailscale is usually the better default if you want one remote workflow that works in more than one place.

## Your Known Windows Host

Based on your current Tailscale setup, the Windows machine is:

- `100.76.113.128`

That only helps if:

- the machine is online in Tailscale
- Ollama is installed
- the Ollama server is running
- port `11434` is reachable from your Mac through Tailscale

## Fastest Way To Switch To Windows

From the repo root on your Mac:

```bash
source ./scripts/use_windows.sh
./scripts/check_ollama.sh
```

If that succeeds, run a normal lab command:

```bash
./scripts/run.sh llama3.1:8b prompts/labs/01_general_summary.txt
```

When finished, switch back:

```bash
source ./scripts/use_local.sh
./scripts/check_ollama.sh
```

## Explicit Remote Commands

### LAN example

```bash
OLLAMA_HOST=http://192.168.1.50:11434 ./scripts/check_ollama.sh
OLLAMA_HOST=http://192.168.1.50:11434 ./scripts/run_matrix.sh prompts/labs/02_extraction_meeting.txt
```

### Tailscale example

```bash
OLLAMA_HOST=http://100.76.113.128:11434 ./scripts/check_ollama.sh
OLLAMA_HOST=http://100.76.113.128:11434 ./scripts/run_matrix.sh prompts/labs/02_extraction_meeting.txt
```

## What The Remote Timing Means

When your Mac talks to Ollama on the Windows machine, you are not measuring pure model speed anymore.
You are measuring end-to-end experience.

That includes:

- network latency
- prompt upload time
- inference time on Windows
- response delivery time

That is useful, but it is a different question from local-only timing.

## How To Verify The Windows Side

You want to confirm three things:

1. The machine is online.
2. Ollama is running.
3. The API responds.

From your Mac, this repo only verifies the third item.
If [`./scripts/check_ollama.sh`](../scripts/check_ollama.sh) fails, the likely causes are:

- the Windows machine is offline in Tailscale or unreachable on the LAN
- Ollama is not running there
- the service is listening only on localhost on Windows
- a firewall rule is blocking access

## Related Docs

- [Remote Windows From Mac](./remote_windows_from_mac.md)
- [Lab 07: Remote And Comparison](./07_remote_and_comparison.md)
- [Lab 08: Mode Comparison Mini-Lab](./08_mode_comparison_mini_lab.md)
- [Benchmark Guide](../benchmarks/README.md)

## Exit Criteria

You are ready to use the Windows environment remotely when:

- local labs already feel easy
- you can verify the remote API from the Mac
- you can switch between local and Windows without changing prompts
- you can explain why you are using remote instead of local for that experiment



# Windows Remote Guide

Purpose:
Use your Windows Ollama environment over Tailscale only when you are ready to compare it with local execution.

This guide is intentionally separate from the main learning path.
If your current goal is local learning, skip this file for now.

## What This Guide Covers

- when to use Windows instead of local Mac execution
- how to point the repo at the Windows host
- how to verify the remote Ollama API
- how to switch back to local cleanly
- how to think about remote startup later through SSH or another remote shell

## When To Stay Local

Stay local when:

- you are still learning prompt behavior
- you want the fewest moving parts
- you are iterating quickly in the terminal
- your local model speed is acceptable

Local should be your default.
Remote Windows should be an explicit choice, not the baseline.

## When To Try Windows

Try the Windows environment when:

- you want to compare the same model on a different machine
- you want access to models or hardware that are not on your Mac
- you want to measure whether remote latency is worth the tradeoff

## Your Known Windows Host

Based on your current Tailscale setup, the Windows machine is:

- `100.76.113.128`

That only helps if:

- the machine is online in Tailscale
- Ollama is installed
- the Ollama server is running
- port `11434` is reachable from your Mac through Tailscale

## Fastest Way To Switch To Windows

From the repo root:

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

If you do not want to use the helper scripts:

```bash
OLLAMA_HOST=http://100.76.113.128:11434 ./scripts/check_ollama.sh
OLLAMA_HOST=http://100.76.113.128:11434 ./scripts/run_matrix.sh prompts/labs/02_extraction_meeting.txt
```

## How To Verify The Windows Side

You want to confirm three things:

1. The machine is online.
2. Ollama is running.
3. The API responds.

From your Mac, this repo only verifies the third item.
If `./scripts/check_ollama.sh` fails, the likely causes are:

- the Windows machine is offline in Tailscale
- Ollama is not running there
- the service is listening only on localhost on Windows
- a firewall rule is blocking access

## About Starting Ollama Remotely Later

You mentioned wanting to start Ollama on Windows through SSH and Tailscale later.
That is a reasonable next step, but it should stay separate from the current local-learning workflow.

This repo does not yet automate Windows remote startup because the exact method depends on your Windows setup:

- OpenSSH server enabled on Windows
- PowerShell remoting
- a scheduled task
- a manual login session

The future workflow should look like this:

1. Connect to Windows remotely.
2. Start or verify the Ollama service there.
3. Run `source ./scripts/use_windows.sh` on the Mac.
4. Verify with `./scripts/check_ollama.sh`.
5. Run normal lab commands.
6. Switch back with `source ./scripts/use_local.sh`.

## Suggested Next Step For Remote Startup

Do not automate Windows startup yet unless:

- you already know how you want to remote in
- you have verified that manual remote Ollama startup works once

Once that is true, this repo can get one more helper script for your exact Windows startup method.

## Exit Criteria

You are ready to use the Windows environment when:

- local labs already feel easy
- you can verify the remote API from the Mac
- you can switch between local and Windows without changing prompts
- you can explain why you are using remote instead of local for that experiment

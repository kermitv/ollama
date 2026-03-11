# Lab 08: Mode Comparison Mini-Lab

Purpose:
Run one exact prompt in all three execution modes and compare the results side by side.

This is a focused comparison lab.
It is narrower than Lab 07 and should be used only after the basic local and remote workflows already work.

Why this matters:

The repo already distinguishes between:

- Mac local -> Mac Ollama
- Windows local -> Windows Ollama
- Mac client -> remote Windows Ollama

What was missing was one fixed exercise that makes you run the same prompt in all three modes and write down what changed.
This lab fills that gap.

What you are learning:

- how to hold the prompt constant while changing only the execution mode
- how to compare output quality without mixing in prompt drift
- how to separate host effects from network effects
- which mode is best for your actual workflow, not just raw speed

Use this exact prompt:

- [prompts/labs/02_extraction_meeting.txt](../prompts/labs/02_extraction_meeting.txt)

Use one exact model tag for all three runs.
Recommended starting point:

- `llama3.1:8b`

Before you begin:

- make sure the repo is available on both Mac and Windows
- make sure the prompt file path is the same on both machines
- make sure the chosen model tag exists on both hosts
- make sure your Windows machine is reachable before testing the remote path
- make sure you can switch back to local cleanly after the remote run

The three execution modes:

## 1. Mac local -> Mac Ollama

From your Mac:

```bash
source ./scripts/use_local.sh
./scripts/check_ollama.sh
./scripts/run.sh llama3.1:8b prompts/labs/02_extraction_meeting.txt
```

## 2. Windows local -> Windows Ollama

From PowerShell on Windows:

```powershell
Remove-Item Env:OLLAMA_HOST -ErrorAction SilentlyContinue
.\scripts\check_ollama.ps1
.\scripts\run.ps1 llama3.1:8b prompts/labs/02_extraction_meeting.txt
```

## 3. Mac client -> remote Windows Ollama

From your Mac:

```bash
source ./scripts/use_windows.sh
./scripts/check_ollama.sh
./scripts/run.sh llama3.1:8b prompts/labs/02_extraction_meeting.txt
source ./scripts/use_local.sh
```

What to record for each run:

- output file path in `runs/`
- host used
- whether the JSON schema was followed
- whether any decision or blocker was omitted
- perceived latency
- total friction of doing the run in that mode

Side-by-side comparison table:

| Mode | Command path | Host | Output file | Schema correct? | Missing content? | Latency notes | Workflow notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Mac local | `run.sh` | Mac local |  |  |  |  |  |
| Windows local | `run.ps1` | Windows local |  |  |  |  |  |
| Mac -> Windows remote | `run.sh` | Windows remote |  |  |  |  |  |

What to compare:

- Does the output stay semantically the same across all three modes?
- Does one mode violate the requested JSON schema more often?
- Is Windows local meaningfully different from Mac remote to Windows, or is the main difference just network overhead?
- Which mode feels best for fast iteration?
- Which mode would you trust for repeated evaluation work?

What good looks like:

- the same model and prompt are used in all three runs
- all three runs produce valid, comparable output
- your notes separate output quality from execution friction
- you can explain whether remote Windows adds value beyond local Mac for this task

Common mistakes:

- changing the model tag between runs
- using a different prompt file on Windows than on Mac
- forgetting to clear or switch `OLLAMA_HOST`
- comparing a warm run on one host to a cold run on another without noting it
- treating Mac -> Windows remote as if it were the same measurement as Windows local

Interpretation guidance:

- If Windows local is strong but Mac -> Windows remote feels worse, the gap is probably transport and workflow overhead, not model quality.
- If Mac local and Windows local are both acceptable, keep the simpler path as your default.
- If remote Windows is the only path that makes a larger model practical, note that explicitly as a capacity win rather than a pure quality win.

Exit criteria:

- you have one saved run from each mode
- you filled in the comparison table
- you can state which mode you would use for daily prompting
- you can state which mode you would use for fair repeatable comparisons

Related docs:

- [Lab 07: Remote And Comparison](./07_remote_and_comparison.md)
- [Remote Windows From Mac](./remote_windows_from_mac.md)
- [Windows Remote Guide](./windows_remote_guide.md)


# Lab 09: NVIDIA GPU Model Evaluation

This is an optional advanced lab.
Use it after the core curriculum when you want to decide which models are actually worth running on a Windows NVIDIA GPU host.

This lab is not about abstract benchmark scores.
It is about practical throughput, latency, VRAM use, and answer quality on the kinds of tasks you are likely to run daily.

## What You Are Learning

- how to compare local models fairly on the same hardware
- how to watch GPU memory and utilization while the model is running
- how to separate time-to-first-token from total response time
- how to score model quality without losing the speed context
- how to pick a default model for your Windows GPU machine

## When To Use This Lab

Use this lab when:

- you have Ollama running on a Windows machine with an NVIDIA GPU
- you want to compare several candidate models on the same prompt set
- you want a grounded answer to "what should be my daily-driver model on this box?"

This lab fits especially well after:

- [Lab 03: Coding](./03_coding.md)
- [Lab 06: Logic And Debugging](./06_logic_and_debugging.md)
- [Lab 08: Mode Comparison Mini-Lab](./08_mode_comparison_mini_lab.md)

## Candidate Models

Start with a small spread of models that might reasonably fit your GPU and your daily workflow.

Example candidates:

- `phi3:mini`
- `qwen2.5:7b-instruct`
- `gemma3:12b`

If those exact models are not installed on your machine, substitute the closest practical alternatives and note that in your results.
Do not silently compare different model classes and pretend the results are directly equivalent.

## Keep The Comparison Fair

Use the same prompt set on every model.
Keep sampling settings fixed across the run.

Recommended rules:

- use the same prompts in the same order for every model
- keep temperature and other options unchanged across models
- run one cold pass if you care about model load cost
- run one warm pass if you care about repeated daily use
- do not change the wording of the prompts between models

If you want the cleanest apples-to-apples scripted comparison, use the repo runner with its default deterministic settings:

```powershell
.\scripts\run.ps1 qwen2.5:7b-instruct prompts/labs/09_gpu_eval/01_sheep_logic.txt
```

## GPU Monitoring

Run the model in one PowerShell window:

```powershell
ollama run phi3:mini
ollama run qwen2.5:7b-instruct
ollama run gemma3:12b
```

In another PowerShell window, watch GPU usage:

```powershell
nvidia-smi -l 1
```

What you care about most:

- whether the model fits comfortably in VRAM
- whether it saturates the GPU or stalls awkwardly
- whether memory use spikes high enough to make bigger models impractical

## What To Record

For each run, capture:

- model name
- prompt number
- time to first token
- total response time
- rough tokens per second if available
- GPU memory observed from `nvidia-smi`
- response quality from 1 to 5
- usefulness from 1 to 5
- whether it felt fast enough for daily use
- any important failure mode such as rambling, formatting drift, or wrong reasoning

Suggested worksheet:

```text
Model:
Prompt:
Time to first token:
Total response time:
Tokens/sec:
GPU memory observed:
Response quality (1-5):
Usefulness (1-5):
Daily-driver viable (yes/no):
Notes:
```

## Prompt Set

Use the prompt files in `prompts/labs/09_gpu_eval/`.
They cover practical reasoning, arithmetic, instruction following, summarization, coding, troubleshooting, structured output, writing quality, and a longer comparative answer.

Prompt list:

1. `01_sheep_logic.txt`
2. `02_discount_tax_math.txt`
3. `03_docker_bullets.txt`
4. `04_container_summary.txt`
5. `05_is_prime_python.txt`
6. `06_sql_left_join_explanation.txt`
7. `07_ollama_port_conflict.txt`
8. `08_project_checklist.txt`
9. `09_reschedule_email.txt`
10. `10_docker_vm_devcontainer_compare.txt`
11. `11_json_task_report.txt`

## What Strong Output Looks Like

### Prompt 1: Sheep logic

- correct answer is `9`
- no overthinking
- quick direct response

### Prompt 2: Discount and tax math

- discounted price is `60.00`
- final price is `64.80`
- arithmetic is shown cleanly

### Prompt 3: Docker bullets

- exactly 5 bullets
- each bullet is under 12 words
- no intro or conclusion

### Prompt 4: Container summary

- 3 sentences
- clear to a non-technical manager
- preserves the original meaning without jargon overload

### Prompt 5: Python `is_prime`

- handles `0`, `1`, and `2` correctly
- readable code
- includes brief comments and 3 test calls

### Prompt 6: SQL explanation

- explains the query in plain English
- identifies that the `WHERE` clause effectively removes the outer-join behavior

### Prompt 7: Ollama port conflict

- identifies that port `11434` is already in use
- notes that Ollama may already be running
- recommends checking the existing process before reinstalling anything

### Prompt 8: Project checklist

- numbered checklist only
- preserves every requirement
- no rambling

### Prompt 9: Reschedule email

- roughly 120 words
- natural professional tone
- no awkward filler

### Prompt 10: Docker vs VMs vs dev containers

- includes all requested sections
- stays coherent across a longer answer
- gives a usable recommendation rather than vague hedging

### Prompt 11: JSON task report

- valid JSON only
- preserves every required field
- no extra commentary outside the JSON object

## Recommended Fast Pass

If you do not want to run all 11 prompts first, start with:

1. `01_sheep_logic.txt`
2. `05_is_prime_python.txt`
3. `07_ollama_port_conflict.txt`
4. `10_docker_vm_devcontainer_compare.txt`
5. `11_json_task_report.txt`

That gives you a fast read on:

- basic logic
- code generation
- practical troubleshooting
- longer structured writing
- format compliance

If one model already feels too slow or too weak on that subset, stop early and save yourself time.

## How To Interpret Results

Typical pattern you may see:

- smaller models feel fastest and fit easily, but lose quality on longer or more structured tasks
- mid-size models often give the best balance of latency, VRAM use, and practical quality
- larger models may produce richer reasoning or writing, but only matter if they still feel usable on your hardware

The question is not "which model is smartest in isolation?"
The question is "which model is good enough, structured enough, and fast enough that I will actually keep using it?"

## Exit Criteria

You are done with this lab when:

- you can name your default Windows GPU model and explain why
- you can name one smaller fallback model for speed-sensitive tasks
- you can explain whether a larger model is worth the extra VRAM and latency on your machine
- you have updated `notes/model-comparison.md` with the conclusion

## Suggested Follow-Up Notes

After you finish, add notes like:

- default daily-driver model on the Windows GPU host
- fastest acceptable model
- best model for coding
- best model for long structured answers
- model that is too slow or too heavy to justify daily use

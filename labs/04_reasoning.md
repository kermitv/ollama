# Lab 04: Reasoning

Purpose:
Compare planning quality, tradeoff analysis, and ability to separate fact from assumption.

Why this matters:

Reasoning tasks show whether a model can help you make decisions, not just generate text. This becomes important when choosing workflows, architectures, or next actions.

What you are learning:

- which models structure decisions clearly
- which models state assumptions instead of hiding them
- which models give practical next steps instead of vague advice

Recommended setup:

```bash
./scripts/repl.sh gpt-oss:20b reasoning
./scripts/repl.sh llama3.1:8b reasoning
```

Windows PowerShell:

```powershell
.\scripts\repl.ps1 gpt-oss:20b reasoning
.\scripts\repl.ps1 llama3.1:8b reasoning
```

Questions to ask in REPL:

- "Plan a local-first workflow for learning LLM tooling offline."
- "When should I switch from a local model to a remote or cloud model?"
- "Design an experiment to compare cost, speed, and output quality."

Script prompt:

- [prompts/labs/04_reasoning_workflow.txt](../prompts/labs/04_reasoning_workflow.txt)

Suggested scripted run:

```bash
./scripts/run_matrix.sh prompts/labs/04_reasoning_workflow.txt
```

Windows PowerShell:

```powershell
.\scripts\run_matrix.ps1 prompts/labs/04_reasoning_workflow.txt
```

What to compare:

- clarity
- decision quality
- missing assumptions
- actionability

What good looks like:

- the answer has a clear structure
- risks and tradeoffs are explicit
- the recommendations are operational, not abstract

Common failure modes:

- generic advice
- missing assumptions
- pretending there is certainty where there is not

Exit criteria:

- you can name the model you trust most for planning help
- you can tell the difference between polished wording and actual decision quality


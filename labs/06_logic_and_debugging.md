# Lab 06: Logic And Debugging

Purpose:
Practice asking local models for troubleshooting help, hypotheses, and next-step suggestions.

Why this matters:

This is the "talk to the model like a practical teammate" lab. You are testing whether the model helps narrow problems down instead of just producing generic debugging advice.

What you are learning:

- how to ask for hypotheses without getting flooded with noise
- which models give strong diagnostic sequences
- which models stay grounded in the evidence you provide

Recommended setup:

```bash
./scripts/repl.sh phi3 reasoning
./scripts/repl.sh llama3.1:8b reasoning
```

Windows PowerShell:

```powershell
.\scripts\repl.ps1 phi3 reasoning
.\scripts\repl.ps1 llama3.1:8b reasoning
```

REPL exercises:

- "Why would localhost work in one shell and fail in another?"
- "Give me the top three hypotheses for this script failure."
- "What should I check first before changing code?"

Script prompt:

- `prompts/labs/06_logic_debugging.txt`

Suggested scripted run:

```bash
./scripts/run_matrix.sh prompts/labs/06_logic_debugging.txt
```

Windows PowerShell:

```powershell
.\scripts\run_matrix.ps1 prompts/labs/06_logic_debugging.txt
```

What to compare:

- does the model stay concrete
- does it suggest good diagnostics
- does it separate symptoms from root causes
- does it avoid overconfident guesses

Recommended models:

- `phi3` for short troubleshooting
- `llama3.1:8b` for balanced debugging help
- `gpt-oss:20b` for harder reasoning

What good looks like:

- likely causes are distinct, not repeated
- diagnostic steps are fast to run
- the suggested next action reduces uncertainty quickly

Common failure modes:

- giving too many possible causes
- mixing root causes and fixes
- recommending changes before basic checks

Exit criteria:

- you can prompt the model to get a short, useful troubleshooting plan
- you know which local model is best for interactive debugging help

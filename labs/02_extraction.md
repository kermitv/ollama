# Lab 02: Extraction

Purpose:
Measure reliability on structured outputs from messy source text.

Why this matters:

Extraction is where weaker models often look good at first glance and fail under real constraints. This lab teaches you to judge validity, not just plausibility.

What you are learning:

- the difference between valid JSON and almost-valid JSON
- how models behave when forced into a schema
- which models omit facts versus hallucinate missing structure

Recommended setup:

```bash
./scripts/repl.sh phi3 extraction
./scripts/repl.sh llama3.1:8b extraction
```

Windows PowerShell:

```powershell
.\scripts\repl.ps1 phi3 extraction
.\scripts\repl.ps1 llama3.1:8b extraction
```

Questions to ask in REPL:

- "Extract decisions, blockers, and next actions from this note."
- "Return only JSON with keys owner, task, due_date."
- "List every assumption you had to make from the source."

Script prompts:

- `prompts/labs/02_extraction_meeting.txt`
- `prompts/001_extraction.txt`
- `prompts/002_extraction_strict.txt`

Suggested scripted run:

```bash
./scripts/run_matrix.sh prompts/labs/02_extraction_meeting.txt
./scripts/run_matrix.sh prompts/002_extraction_strict.txt
```

Windows PowerShell:

```powershell
.\scripts\run_matrix.ps1 prompts/labs/02_extraction_meeting.txt
.\scripts\run_matrix.ps1 prompts/002_extraction_strict.txt
```

What to compare:

- JSON validity
- schema compliance
- source fidelity
- omission vs hallucination behavior

What good looks like:

- output parses cleanly as JSON
- keys match the requested schema exactly
- extracted items are supported by the source text
- uncertain information is omitted rather than invented

Common failure modes:

- markdown fences around JSON
- commentary before or after the object
- wrong key names
- adding items not present in the source

Exit criteria:

- you can identify the best extraction model in your local set
- you can explain how strict prompting changed output quality

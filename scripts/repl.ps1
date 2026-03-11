param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Model,

    [Parameter(Position = 1)]
    [string]$Lab = 'general'
)

$ErrorActionPreference = 'Stop'

switch ($Lab) {
    'general' {
        $systemPrompt = 'You are a concise local LLM assistant. Ask clarifying questions only when ambiguity blocks progress. Prefer concrete answers.'
    }
    'extraction' {
        $systemPrompt = 'You extract structured data from messy text. Prefer exact wording from the source. Return only the requested structure.'
    }
    'coding' {
        $systemPrompt = 'You are a practical coding assistant. Explain tradeoffs briefly, then provide working code or shell commands.'
    }
    'reasoning' {
        $systemPrompt = 'You reason carefully. State assumptions, keep the answer compact, and separate facts from guesses.'
    }
    default {
        Write-Error 'Unknown lab. Labs: general, extraction, coding, reasoning'
        exit 1
    }
}

Write-Host "Starting REPL with model=$Model lab=$Lab"
Write-Host 'Type /bye or press Ctrl-D to exit.'

ollama run $Model $systemPrompt

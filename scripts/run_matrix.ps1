param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$PromptFile,

    [Parameter(Position = 1)]
    [string]$ModelsArg
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $PromptFile)) {
    Write-Error "Prompt file not found: $PromptFile"
    exit 1
}

if ($ModelsArg) {
    $models = $ModelsArg.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ }
} else {
    $models = @(
        'phi3',
        'llama3.1:8b',
        'deepseek-coder:6.7b',
        'gpt-oss:20b'
    )
}

foreach ($model in $models) {
    Write-Host "Running $model with $PromptFile"
    powershell -ExecutionPolicy Bypass -File .\scripts\run.ps1 $model $PromptFile
}

param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Model,

    [Parameter(Mandatory = $true, Position = 1)]
    [string]$PromptFile
)

$ErrorActionPreference = 'Stop'

if ($env:OLLAMA_USE_ENV_WIN -eq '1' -and (Test-Path '.env.win')) {
    Get-Content '.env.win' | ForEach-Object {
        if ($_ -match '^\s*([A-Za-z_][A-Za-z0-9_]*)=(.*)\s*$') {
            [System.Environment]::SetEnvironmentVariable($matches[1], $matches[2].Trim('"'), 'Process')
        }
    }
}

$base = if ($env:OLLAMA_HOST) { $env:OLLAMA_HOST } else { 'http://localhost:11434' }

if (-not (Test-Path $PromptFile)) {
    Write-Error "Prompt file not found: $PromptFile"
    exit 1
}

$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$promptName = [System.IO.Path]::GetFileNameWithoutExtension($PromptFile)
$safeModel = $Model -replace ':', '_'
$outDir = 'runs'
$outFile = Join-Path $outDir "$timestamp.$safeModel.$promptName.txt"
$promptContents = Get-Content $PromptFile -Raw

$bodyObject = [ordered]@{
    model = $Model
    stream = $false
    options = [ordered]@{
        temperature = 0
        num_predict = 300
    }
    prompt = [string]$promptContents
}

$body = [System.Text.Encoding]::UTF8.GetBytes(($bodyObject | ConvertTo-Json -Depth 5 -Compress))
$response = Invoke-RestMethod -Method Post -Uri "$base/api/generate" -ContentType 'application/json; charset=utf-8' -Body $body

New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$outputText = if ($response.response) {
    $response.response
} elseif ($response.message -and $response.message.content) {
    $response.message.content
} elseif ($response.error) {
    $response.error
} else {
    ''
}

@(
    "Model: $Model"
    "Host: $base"
    "Prompt: $PromptFile"
    "Timestamp: $timestamp"
    "------------------------------------"
    $promptContents
    ""
    "============ OUTPUT ================"
    $outputText
) | Set-Content $outFile

Write-Host "Saved to $outFile"

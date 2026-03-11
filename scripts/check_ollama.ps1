$ErrorActionPreference = 'Stop'

$base = if ($env:OLLAMA_HOST) { $env:OLLAMA_HOST } else { 'http://localhost:11434' }

Write-Host "Checking Ollama host: $base"

try {
    $response = Invoke-RestMethod -Method Get -Uri "$base/api/tags"
} catch {
    Write-Error "Unable to reach Ollama at $base"
    exit 1
}

Write-Host "Server reachable."
Write-Host ""
Write-Host "Installed models:"

if ($null -eq $response.models -or $response.models.Count -eq 0) {
    Write-Host "(none)"
    exit 0
}

$response.models | ForEach-Object {
    if ($_.name) {
        $_.name
    }
}

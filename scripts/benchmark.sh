#!/usr/bin/env bash
set -euo pipefail

base="${OLLAMA_HOST:-http://localhost:11434}"
model="${1:-}"
prompt_file="${2:-}"
machine_label="${3:-}"
run_label="${4:-warm}"

if [ -z "$model" ] || [ -z "$prompt_file" ]; then
  echo "Usage: ./scripts/benchmark.sh <model> <prompt_file> [machine_label] [cold|warm]" >&2
  exit 1
fi

if [ ! -f "$prompt_file" ]; then
  echo "Prompt file not found: $prompt_file" >&2
  exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "curl is required" >&2
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is required" >&2
  exit 1
fi

if [ -z "$machine_label" ]; then
  machine_label="$(hostname -s)"
fi

timestamp="$(date +%Y%m%d-%H%M%S)"
prompt_name="$(basename "$prompt_file" .txt)"
safe_model="${model//:/_}"
outfile="benchmarks/results/${timestamp}.${machine_label}.${safe_model}.${prompt_name}.${run_label}.json"

mkdir -p benchmarks/results

prompt_contents="$(cat "$prompt_file")"
host_info="$(curl -fsS "$base/api/tags")"

capture_memory_json() {
  if [ "$(uname -s)" != "Darwin" ]; then
    printf '%s\n' '{"available":false,"reason":"memory snapshots only implemented for local macOS runs"}'
    return
  fi

  case "$base" in
    http://localhost:11434|http://127.0.0.1:11434)
      :
      ;;
    *)
      printf '%s\n' '{"available":false,"reason":"remote Ollama host; measure memory on that machine directly"}'
      return
      ;;
  esac

  vm="$(vm_stat)"
  pressure="$(memory_pressure)"

  pages_free="$(printf '%s\n' "$vm" | awk '/Pages free:/ {gsub(/\./, "", $3); print $3}')"
  pages_active="$(printf '%s\n' "$vm" | awk '/Pages active:/ {gsub(/\./, "", $3); print $3}')"
  pages_inactive="$(printf '%s\n' "$vm" | awk '/Pages inactive:/ {gsub(/\./, "", $3); print $3}')"
  pages_wired="$(printf '%s\n' "$vm" | awk '/Pages wired down:/ {gsub(/\./, "", $4); print $4}')"
  compressor_pages="$(printf '%s\n' "$vm" | awk '/Pages occupied by compressor:/ {gsub(/\./, "", $5); print $5}')"
  swapins="$(printf '%s\n' "$vm" | awk '/Swapins:/ {gsub(/\./, "", $2); print $2}')"
  swapouts="$(printf '%s\n' "$vm" | awk '/Swapouts:/ {gsub(/\./, "", $2); print $2}')"
  free_pct="$(printf '%s\n' "$pressure" | awk '/System-wide memory free percentage:/ {gsub(/%/, "", $5); print $5}')"

  jq -n \
    --arg available "true" \
    --arg pages_free "${pages_free:-}" \
    --arg pages_active "${pages_active:-}" \
    --arg pages_inactive "${pages_inactive:-}" \
    --arg pages_wired "${pages_wired:-}" \
    --arg compressor_pages "${compressor_pages:-}" \
    --arg swapins "${swapins:-}" \
    --arg swapouts "${swapouts:-}" \
    --arg free_pct "${free_pct:-}" \
    '{
      available: ($available == "true"),
      pages_free: ($pages_free | tonumber?),
      pages_active: ($pages_active | tonumber?),
      pages_inactive: ($pages_inactive | tonumber?),
      pages_wired: ($pages_wired | tonumber?),
      compressor_pages: ($compressor_pages | tonumber?),
      swapins: ($swapins | tonumber?),
      swapouts: ($swapouts | tonumber?),
      system_free_percent: ($free_pct | tonumber?)
    }'
}

before_memory="$(capture_memory_json)"

response_json="$(
  curl -fsS -H "Content-Type: application/json" \
    -d "$(jq -nc --arg m "$model" --arg p "$prompt_contents" \
      '{model:$m, stream:false, options:{temperature:0, num_predict:300}, prompt:$p}')" \
    "$base/api/generate"
)"

after_memory="$(capture_memory_json)"

prompt_eval_duration="$(printf '%s\n' "$response_json" | jq -r '.prompt_eval_duration // 0')"
eval_duration="$(printf '%s\n' "$response_json" | jq -r '.eval_duration // 0')"
prompt_eval_count="$(printf '%s\n' "$response_json" | jq -r '.prompt_eval_count // 0')"
eval_count="$(printf '%s\n' "$response_json" | jq -r '.eval_count // 0')"

jq -n \
  --arg timestamp "$timestamp" \
  --arg machine_label "$machine_label" \
  --arg run_label "$run_label" \
  --arg host "$base" \
  --arg model "$model" \
  --arg prompt_file "$prompt_file" \
  --arg prompt_name "$prompt_name" \
  --argjson host_info "$host_info" \
  --argjson before_memory "$before_memory" \
  --argjson after_memory "$after_memory" \
  --argjson response "$response_json" \
  --arg prompt_eval_duration "$prompt_eval_duration" \
  --arg eval_duration "$eval_duration" \
  --arg prompt_eval_count "$prompt_eval_count" \
  --arg eval_count "$eval_count" \
  '{
    timestamp: $timestamp,
    machine_label: $machine_label,
    run_label: $run_label,
    host: $host,
    model: $model,
    prompt_file: $prompt_file,
    prompt_name: $prompt_name,
    host_model_entry: ($host_info.models[]? | select(.name == $model)),
    metrics: {
      total_duration_ns: ($response.total_duration // 0),
      load_duration_ns: ($response.load_duration // 0),
      prompt_eval_count: ($prompt_eval_count | tonumber),
      prompt_eval_duration_ns: ($prompt_eval_duration | tonumber),
      eval_count: ($eval_count | tonumber),
      eval_duration_ns: ($eval_duration | tonumber),
      prompt_tokens_per_second:
        (if ($prompt_eval_duration | tonumber) > 0
         then (($prompt_eval_count | tonumber) / (($prompt_eval_duration | tonumber) / 1000000000))
         else null end),
      eval_tokens_per_second:
        (if ($eval_duration | tonumber) > 0
         then (($eval_count | tonumber) / (($eval_duration | tonumber) / 1000000000))
         else null end)
    },
    memory_before: $before_memory,
    memory_after: $after_memory,
    response_preview: ($response.response // $response.message.content // null)
  }' > "$outfile"

echo "Saved benchmark to $outfile"
printf '%s\n' "$response_json" | jq -r '
  "total_duration_ns=\(.total_duration // 0)",
  "load_duration_ns=\(.load_duration // 0)",
  "prompt_eval_count=\(.prompt_eval_count // 0)",
  "prompt_eval_duration_ns=\(.prompt_eval_duration // 0)",
  "eval_count=\(.eval_count // 0)",
  "eval_duration_ns=\(.eval_duration // 0)"'

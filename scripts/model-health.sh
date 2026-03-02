#!/usr/bin/env bash
# model-health.sh — Model provider health dashboard from OpenClaw cron run logs
#
# Usage:
#   bash scripts/model-health.sh              # last 24h (default)
#   bash scripts/model-health.sh 2026-03-01   # specific date
#   bash scripts/model-health.sh --stdout      # print only, skip file save
#
# Requires: jq (brew install jq), python3
# Output:  TASKS/finance/model-health-YYYY-MM-DD.md (and stdout)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
RUNS_DIR="$HOME/.openclaw/cron/runs"
JOBS_FILE="$HOME/.openclaw/cron/jobs.json"
CONFIG_FILE="$HOME/.openclaw/openclaw.json"
TARGET_DATE=""
STDOUT_ONLY=false

# ---------- parse args ----------
for arg in "$@"; do
  case "$arg" in
    --stdout) STDOUT_ONLY=true ;;
    --help|-h)
      sed -n '2,10p' "$0" | sed 's/^# \?//'
      exit 0
      ;;
    *) TARGET_DATE="$arg" ;;
  esac
done
TARGET_DATE="${TARGET_DATE:-$(date +%Y-%m-%d)}"

OUTPUT_DIR="$REPO_DIR/TASKS/finance"
OUTPUT_FILE="$OUTPUT_DIR/model-health-${TARGET_DATE}.md"

# ---------- preflight ----------
if ! command -v jq &>/dev/null; then
  echo "ERROR: jq is required. Install with: brew install jq" >&2
  exit 1
fi

if [[ ! -d "$RUNS_DIR" ]]; then
  echo "ERROR: Run logs directory not found: $RUNS_DIR" >&2
  exit 1
fi

# ---------- date range (epoch ms) ----------
DAY_START_MS=$(( $(date -j -f "%Y-%m-%dT%H:%M:%S" "${TARGET_DATE}T00:00:00" +%s) * 1000 ))
DAY_END_MS=$(( $(date -j -f "%Y-%m-%dT%H:%M:%S" -v+1d "${TARGET_DATE}T00:00:00" +%s) * 1000 ))

# ---------- collect finished runs ----------
TMP_RUNS=$(mktemp)
trap 'rm -f "$TMP_RUNS"' EXIT

for logfile in "$RUNS_DIR"/*.jsonl; do
  [[ -f "$logfile" ]] || continue
  jq -c "select(.action == \"finished\" and .ts >= $DAY_START_MS and .ts < $DAY_END_MS)" "$logfile" 2>/dev/null >> "$TMP_RUNS" || true
done

RUN_COUNT=$(wc -l < "$TMP_RUNS" | tr -d ' ')

# ---------- read fallback config ----------
FALLBACKS=$(jq -r '
  (.agents.defaults.model.primary // "unknown") as $primary |
  (.agents.defaults.model.fallbacks // []) as $fbs |
  if ($fbs | length) == 0 then
    $primary + " (no fallbacks)"
  else
    $primary + " → " + ($fbs | join(" → "))
  end
' "$CONFIG_FILE" 2>/dev/null || echo "unknown")

# ---------- compute stats ----------
if [[ "$RUN_COUNT" -eq 0 ]]; then
  REPORT=$(cat <<EOF_INNER
\`\`\`text
📊 Model Health — $TARGET_DATE
──────────────────────────────
No runs found for this date.

Fallback config: $FALLBACKS
\`\`\`
EOF_INNER
)
else
  REPORT=$(python3 -c "
import json, sys

runs = []
with open('$TMP_RUNS') as f:
    for line in f:
        line = line.strip()
        if line:
            runs.append(json.loads(line))

# Load job metadata for agent names and job descriptions
with open('$JOBS_FILE') as f:
    jobs_data = json.load(f)
job_map = {}
for job in jobs_data.get('jobs', []):
    job_map[job['id']] = {
        'agent': job.get('agentId', 'unknown'),
        'name': job.get('name', 'unknown'),
        'desc': job.get('description', '')
    }

# ── Provider summary ──
providers = {}
error_details = []

# ── Agent breakdown ──
agents = {}

for r in runs:
    provider = r.get('provider', 'unknown')
    status = r.get('status', 'unknown')
    duration_ms = r.get('durationMs', 0)
    model = r.get('model', 'unknown')
    job_id = r.get('jobId', '')
    error = r.get('error', '') or ''
    usage = r.get('usage', {})
    inp_tok = usage.get('input_tokens', 0)
    out_tok = usage.get('output_tokens', 0)
    total_tok = usage.get('total_tokens', 0) or (inp_tok + out_tok)

    # Provider stats
    if provider not in providers:
        providers[provider] = {
            'runs': 0, 'ok': 0, 'fail': 0,
            'total_duration': 0, 'models': set()
        }
    p = providers[provider]
    p['runs'] += 1
    p['models'].add(model)
    p['total_duration'] += duration_ms
    if status == 'ok':
        p['ok'] += 1
    else:
        p['fail'] += 1
        err_text = str(error).lower()
        if any(kw in err_text for kw in ['overload', 'rate', '429', '503', 'capacity', 'temporarily']):
            error_details.append(f'{provider}: rate-limit/overload ({model})')
        else:
            error_details.append(f'{provider}: {status}')

    # Agent stats
    jinfo = job_map.get(job_id, {'agent': 'unknown', 'name': job_id[:12], 'desc': ''})
    agent = jinfo['agent']
    job_name = jinfo['name']
    key = f'{agent}:{job_name}'
    if key not in agents:
        agents[key] = {
            'agent': agent, 'job': job_name,
            'runs': 0, 'input_tok': 0, 'output_tok': 0, 'total_tok': 0,
            'duration_ms': 0, 'status_list': [], 'provider': provider, 'model': model
        }
    a = agents[key]
    a['runs'] += 1
    a['input_tok'] += inp_tok
    a['output_tok'] += out_tok
    a['total_tok'] += total_tok
    a['duration_ms'] += duration_ms
    a['status_list'].append(status)
    a['provider'] = provider
    a['model'] = model

# All configured providers
all_providers = ['google', 'anthropic', 'openai']
for ap in all_providers:
    if ap not in providers:
        providers[ap] = {'runs': 0, 'ok': 0, 'fail': 0, 'total_duration': 0, 'models': set()}

# ── Build output ──
lines = []
lines.append('\`\`\`text')
lines.append('📊 Model Health — $TARGET_DATE')
lines.append('══════════════════════════════════════════════════════')
lines.append('')
lines.append('▸ Provider Summary')
lines.append(f\"{'Provider':<13}│ {'Runs':>4} │ {'OK':>3} │ {'Fail':>4} │ {'Success%':>8} │ {'Avg Time':>8}\")
lines.append('─────────────┼──────┼─────┼──────┼──────────┼─────────')

for prov in all_providers:
    p = providers[prov]
    if p['runs'] == 0:
        lines.append(f\"{prov:<13}│ {'0':>4} │ {'-':>3} │ {'-':>4} │ {'-':>8} │ {'-':>8}\")
    else:
        rate = round(p['ok'] / p['runs'] * 100)
        avg_s = round(p['total_duration'] / p['runs'] / 1000)
        lines.append(f\"{prov:<13}│ {p['runs']:>4} │ {p['ok']:>3} │ {p['fail']:>4} │ {str(rate)+'%':>8} │ {str(avg_s)+'s':>8}\")

lines.append('')

# ── Agent breakdown sorted by total tokens ──
lines.append('▸ Agent Token Usage (sorted by total tokens)')

def fmt_tok(n):
    if n >= 1_000_000: return f'{n/1_000_000:.1f}M'
    if n >= 1_000: return f'{n/1_000:.1f}K'
    return str(n)

lines.append(f\"{'Agent':<12}│ {'Task Type':<28}│ {'Input':>8} │ {'Output':>8} │ {'Total':>8} │ {'Time':>6} │ {'Status':>6}\")
lines.append('────────────┼────────────────────────────┼──────────┼──────────┼──────────┼────────┼───────')

sorted_agents = sorted(agents.values(), key=lambda x: x['total_tok'], reverse=True)
grand_input = 0
grand_output = 0
grand_total = 0

for a in sorted_agents:
    grand_input += a['input_tok']
    grand_output += a['output_tok']
    grand_total += a['total_tok']
    dur_s = round(a['duration_ms'] / 1000)
    ok_count = a['status_list'].count('ok')
    # Change from emojis to simple text to avoid breaking monospace formatting in block
    st = 'OK' if ok_count == a['runs'] else 'FAIL' if ok_count == 0 else f'{ok_count}/{a[\"runs\"]}'
    job_short = a['job'][:27]
    lines.append(f\"{a['agent']:<12}│ {job_short:<28}│ {fmt_tok(a['input_tok']):>8} │ {fmt_tok(a['output_tok']):>8} │ {fmt_tok(a['total_tok']):>8} │ {str(dur_s)+'s':>6} │ {st:>6}\")

lines.append('────────────┼────────────────────────────┼──────────┼──────────┼──────────┼────────┼───────')
lines.append(f\"{'TOTAL':<12}│ {'':28}│ {fmt_tok(grand_input):>8} │ {fmt_tok(grand_output):>8} │ {fmt_tok(grand_total):>8} │        │      \")

lines.append('')
lines.append('══════════════════════════════════════════════════════')

# Error summary
if error_details:
    lines.append(f'⚠️  {len(error_details)} error(s): ' + '; '.join(error_details))
else:
    lines.append('✅ All runs succeeded — no errors detected')

lines.append(f'Fallback config: $FALLBACKS')
lines.append(f'Total runs: {sum(p[\"runs\"] for p in providers.values())}')
lines.append('\`\`\`')

print('\\n'.join(lines))
")
fi

# ---------- output ----------
if [[ "$STDOUT_ONLY" == "true" ]]; then
  echo "$REPORT"
else
  # If saving to file, strip the backticks so the markdown file just has one big block
  STRIPPED_REPORT=$(echo "$REPORT" | sed '1d;$d')
  mkdir -p "$OUTPUT_DIR"
  {
    echo "# Model Health Report — $TARGET_DATE"
    echo ""
    echo '```text'
    echo "$STRIPPED_REPORT"
    echo '```'
    echo ""
    echo "---"
    echo ""
    echo "- Source: \`~/.openclaw/cron/runs/*.jsonl\`"
    echo "- Generated: $(date '+%Y-%m-%d %H:%M ET')"
  } > "$OUTPUT_FILE"
  echo "$REPORT"
  echo ""
  echo "📄 Report saved to $OUTPUT_FILE"
fi

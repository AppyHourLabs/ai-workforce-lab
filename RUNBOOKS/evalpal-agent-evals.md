# Runbook: EvalPal Agent Evaluations

> **Owner:** QA Agent · **Platform:** [evalpal.dev](https://evalpal.dev) (production)
> **Effective:** 2026-02-22 · **Review cadence:** Monthly

This runbook defines how to create, run, and track agent evaluations using EvalPal. It is the operational counterpart to [EVALS/agent-eval-definitions.md](../EVALS/agent-eval-definitions.md), which defines *what* to measure.

---

## Prerequisites

- EvalPal account with API key (stored in secrets manager — **never in repo**)
- EvalPal project: "AI Workforce Lab" on `evalpal.dev`
- CLI tool: `EvalPal/cli/run-eval.js`
- Environment variable: `EVAL_API_KEY` set in agent runtime

---

## Daily Workflow (QA Agent)

### 1. Identify Agents with New Output

Check which agents produced output in the last 24 hours:

```bash
# Check for new files modified today
find EVALS/results/ DOCS/SHOW/episodes/ -mtime -1 -type f
git log --since="24 hours ago" --format="%an" | sort -u
```

### 2. Run Eval Definitions

For each agent with new output, trigger the corresponding eval:

```bash
# Example: Run Doc agent episode quality eval
node /Users/aioffice/EvalPal/cli/run-eval.js \
  --eval-id <EPISODE_QUALITY_ID> \
  --api-key $EVAL_API_KEY \
  --api-url https://evalpal.dev \
  --verbose
```

### 3. File Results

Save the EvalPal run summary to the local results directory:

```
EVALS/results/evalpal/YYYY-MM-DD-<agent>-<eval-name>.md
```

Each result file must include:
- EvalPal run ID (for linking back to dashboard)
- Pass rate and per-test-case scores
- Comparison to baseline (if baseline exists)
- PASS or FAIL verdict

---

## Weekly Scorecard (Every Friday)

### 1. Run All Active Eval Definitions

Trigger every eval definition, not just agents with new output. This captures consistency even when agents haven't changed.

### 2. Compile Scorecard

Use the template at [EVALS/agent-scorecard-template.md](../EVALS/agent-scorecard-template.md) to produce:

```
EVALS/results/scorecards/YYYY-WXX-scorecard.md
```

### 3. Post to Slack

Post the scorecard summary to `#ai-office` with per-agent pass rates and trend arrows.

### 4. File Regressions

If any agent's pass rate dropped > 5% from baseline:
1. File a regression report in `EVALS/results/regressions/`
2. Escalate to Founder per [RUNBOOKS/human-escalation.md](human-escalation.md)
3. Create a remediation task in `TASKS/`

---

## Dataset Management

### Adding Test Cases

When an agent produces notably good or bad output:

1. Add it as a test case in the EvalPal dataset for that eval definition
2. Tag it: `good-example` or `failure-case`
3. Re-run the baseline to update thresholds if the dataset grew > 20%

### Dataset Size Targets

| Agent | Minimum Test Cases | Target |
|---|---|---|
| Doc | 10 episodes | 20 |
| QA | 10 gate runs | 20 |
| Security | 10 scan reports | 20 |
| Content | 10 drafts | 20 |
| All others | 5 | 10 |

---

## Improvement Workflow

When an agent's eval scores need improvement:

1. **Diagnose** — Review failing test cases on EvalPal dashboard
2. **Hypothesize** — Identify prompt, config, or rubric changes that could help
3. **Change** — Update the agent's SOUL.md, IDENTITY.md, or TOOLS.md
4. **Re-eval** — Run the eval definition again
5. **Compare** — Use EvalPal's side-by-side comparison to verify improvement
6. **Lock** — If improved, update the baseline; if regressed, revert the change

> [!CAUTION]
> Never update a baseline to a lower score. Baselines only move up. If a legitimate threshold reduction is needed, it requires Founder approval and a documented reason.

---

## EvalPal API Reference (Quick)

| Action | Endpoint | CLI Flag |
|---|---|---|
| Trigger eval run | `POST /api/v1/evals/{id}/run` | `--eval-id` |
| Poll run status | `GET /api/v1/runs/{id}` | (automatic) |
| Get run results | `GET /api/v1/runs/{id}/results` | (automatic) |
| List projects | `GET /api/projects` | — |

Full docs: [evalpal.dev/api/docs](https://evalpal.dev/api/docs)

---

*Cross-links: [EVALS/agent-eval-definitions.md](../EVALS/agent-eval-definitions.md) · [EVALS/agent-scorecard-template.md](../EVALS/agent-scorecard-template.md) · [RUNBOOKS/human-escalation.md](human-escalation.md)*

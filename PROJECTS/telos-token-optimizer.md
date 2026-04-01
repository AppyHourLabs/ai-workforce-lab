# PROJECT: Telos OS Token Optimizer

- **Status:** `active`
- **Owner:** matt@appyhourlabs.com
- **Priority:** P2
- **Objective:** Deploy Telos OS MILP solver to optimize fleet token allocation across providers, reducing cost and preventing cascading provider failures.

## Success Criteria

1. Solver produces daily recommendations that are directionally correct (routes away from capped/broken providers)
2. Recommendations match human intuition when compared against known scenarios (e.g., 2026-03-31 RCA)
3. Token data input is sourced from OpenClaw's native dashboard (not custom scripts)
4. No autonomous config changes — recommendations are advisory-only (Phase A)

## Tasks

- [x] Install Telos OS framework (v1.3.0)
- [x] Write `.telos` manifest for fleet token optimization
- [x] Build parameter harvester from OpenClaw data
- [x] Build advisory actuator (markdown reports)
- [x] Build orchestration runner
- [x] Validate manifest + fuzz test
- [x] Run against today's real data (2026-03-31 RCA scenario)
- [x] File upstream issue for ARM64 CBC solver ([#4](https://github.com/MatthewEngman/telos-framework/issues/4))
- [ ] Investigate OpenClaw native token dashboard API
- [ ] Wire into CFO agent's end-of-day cron schedule
- [ ] Accumulate 7 days of real data to tune parameters
- [ ] v2: Add quality scoring (feed EvalPal eval scores as parameters)

## Completion Definition

- Running daily after last cron cycle for 2+ weeks
- Recommendations consistently match or improve on manual routing decisions
- Token data sourced from OpenClaw native dashboard

## Risks

| Risk | Mitigation |
|------|-----------|
| Inaccurate token data | Investigate OpenClaw dashboard; track from day one |
| Manifest constraints too tight | Fuzz tested at 500 iterations; relaxed constraints |
| ARM64 solver compatibility | Workaround with HiGHS; upstream issue filed |
| Solver recommends bad routing | Advisory mode only; Matt reviews all changes |

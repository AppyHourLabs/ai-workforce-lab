# AGENTS.md

## AI Workforce Lab Context

This is the public **AI Workforce Lab** repository under **Appy Hour Labs**.

The program goal is to progress from **Phase A** to **Phase B** autonomy with a **safety-first** operating model.

## Repository Structure

- `PROJECTS/`: Active project definitions, plans, and execution trackers.
- `AGENTS/`: Agent profiles, role definitions, and operating instructions.
- `POLICIES/`: Governance, safety, and compliance policy documents.
- `RUNBOOKS/`: Operational procedures, incident steps, and playbooks.
- `EVALS/`: Evaluation specs, scorecards, benchmark results, and gate criteria.
- `DOCS/SHOW/episodes/`: Public-facing show content, episode notes, and related assets.

## Conventions

- Use **Markdown only** for project artifacts and operational docs.
- Never commit secrets.
- Never include personal information.
- Use ISO date format: `YYYY-MM-DD`.
- Every project file must include the following fields:
  - `Status`
  - `Owner`
  - `Priority`
  - `Success Criteria`
  - `Tasks`
  - `Completion Definition`

## Safety

- Never add OAuth tokens, API keys, or credentials to this repository.
- Never recommend domain-wide delegation.
- No autonomous money movement.
- **Phase A requirement:** external emails must pass evaluation gates and receive explicit human approval before sending.

## How to use this repo (for new agents)

1. Start by reading `POLICIES/` and `RUNBOOKS/` before proposing changes.
2. For any execution work, create or update files in `PROJECTS/` with required metadata fields.
3. Define or update relevant checks in `EVALS/` before advancing autonomy level.
4. Keep agent behavior aligned with `AGENTS/` role definitions and safety constraints.
5. Record progress using concise Markdown updates with ISO dates and clear completion criteria.

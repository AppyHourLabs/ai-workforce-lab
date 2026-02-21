# Task 0007 — Draft Episode 001 in DOCS/SHOW/episodes/

> **Project:** Documentary output for AI Workforce Lab  
> **Owner:** AI (`doc@`) with human review (`matt@`)  
> **Priority:** P2  
> **Status:** Complete — see [001-ai-office-moves-in.md](../DOCS/SHOW/episodes/001-ai-office-moves-in.md)

---

## Goal

Produce the first public episode documenting the governance philosophy, the Mac Mini AI Office setup, why workspace hardening came first, and what Phase A means. Must be public-ready with no private details.

---

## Steps

1. `doc@` drafts episode using [`DOCS/SHOW/episodes/_TEMPLATE.md`](../DOCS/SHOW/episodes/_TEMPLATE.md) as the structural guide
2. Run through internal review checklist:
   - No credentials, tokens, or personal contact info
   - No operational security details (specific IP addresses, internal URLs, etc.)
   - All cross-links to policy and project docs are valid
3. Run outbound quality gate: [`EVALS/outbound-quality-gate.md`](../EVALS/outbound-quality-gate.md)
4. Run brand voice gate: [`EVALS/brand-voice-gate.md`](../EVALS/brand-voice-gate.md)
5. Submit draft to `matt@` for review via PR
6. `matt@` approves and merges
7. Update this task status to **Complete**

---

## Owner (Human vs AI)

- **Drafting:** AI (`doc@`)
- **Gates:** AI QA agent
- **Final approval:** Human (`matt@`)

---

## Dependencies

- [`POLICIES/posting-policy.md`](../POLICIES/posting-policy.md) — publication rules
- [`EVALS/outbound-quality-gate.md`](../EVALS/outbound-quality-gate.md)
- [`EVALS/brand-voice-gate.md`](../EVALS/brand-voice-gate.md)

---

## Definition of Done

- [ ] Episode file exists at `DOCS/SHOW/episodes/001-ai-office-moves-in.md`
- [ ] Both quality gates passed (results filed in `EVALS/results/`)
- [ ] `matt@` approved and merged the PR
- [ ] Episode contains no private or operational security information

---

## Risk Notes

- **Tone drift:** the episode should be honest and understated. If the draft reads like marketing copy, it's failing the brand voice gate for the right reasons.
- **Over-documenting operational details** (specific machine configs, network layout) is a security risk. When in doubt, generalize.

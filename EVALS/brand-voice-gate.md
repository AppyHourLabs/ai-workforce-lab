# Brand Voice Gate

> **Owner:** QA Agent (`ai@appyhourlabs.com`) | **Authority:** Block publication on FAIL  
> **Version:** 1.0 · 2026-02-21

---

## Purpose

Ensure all AI Workforce Lab content sounds like it was written by humans who are honest, competent, and occasionally funny — not by a language model trying to seem honest, competent, and occasionally funny. There's a difference. This gate exists to catch it.

---

## The AI Workforce Lab Voice

| Dimension | What we are | What we are not |
|---|---|---|
| **Honesty** | We document what happened, warts included | Spin doctors. "Learnings" instead of "mistakes." |
| **Tone** | Dry, understated humor through specificity | Exclamation points. "Game-changing." "Delighted to announce." |
| **Precision** | Concrete details, ISO dates, named actors | "Recently," "soon," "various stakeholders" |
| **Accountability** | We name errors and what we changed | Passive voice blame-laundering |
| **Confidence** | Measured and backed by evidence | Hype, speculation presented as fact |

---

## Gate Criteria

Each criterion scored 0–2. **Minimum passing score: 8 / 10.**

| # | Criterion | 0 — Fail | 1 — Partial | 2 — Pass |
|---|---|---|---|---|
| 1 | **Honesty** | Misleading or spin-driven framing | Ambiguous or hedged on facts | Clear, accurate, zero spin |
| 2 | **Tone** | Hype language, excessive enthusiasm, or fear-mongering | Occasional off-note | Consistent dry, factual tone throughout |
| 3 | **Specificity** | Vague claims with no supporting detail | Mixed — some vague sections | Concrete and specific throughout |
| 4 | **No AI-voice tells** | Multiple classic AI tells ("I hope this finds you…", hollow affirmations) | One or two minor tells | Reads like a human wrote it |
| 5 | **Accountability** | Mistakes minimized or blamed externally | Partially acknowledged | Errors named clearly and owned |

---

## Common AI-Voice Tells (Automatic Deductions)

These phrases or patterns score 0 on criterion #4 if present:

- "I hope this finds you well"
- "In today's fast-paced world…"
- "It's important to note that…"
- "I'd be happy to help with…"
- "As an AI language model…"
- "Certainly!" / "Absolutely!" / "Great question!"
- Any sentence that begins with "In conclusion" or "To summarize"
- Numbered lists used where prose is clearly more appropriate

---

## Scoring

```
Total score: __ / 10

PASS threshold: ≥ 8
FAIL: < 8 OR criterion #4 scored 0
```

---

## Result Filing

Save results to `EVALS/results/YYYY-MM-DD-[content-slug]-voice.md` with:

- Content title and type
- Per-criterion scores and specific flagged examples
- Final verdict: `gate: PASS` or `gate: FAIL`
- If FAIL: exact phrases or sections requiring revision

---

*Related: [`EVALS/outbound-quality-gate.md`](./outbound-quality-gate.md) · [`AGENTS/content-agent.md`](../AGENTS/content-agent.md) · [`AGENTS/documentary-agent.md`](../AGENTS/documentary-agent.md)*

# Episode 005: Hard Budget Cap — Operational Controls

**Date:** 2026-02-24  
**Duration:** 15-20 minutes  
**Theme:** Cost control and operational safeguards for agent fleet  

## Key Topics

### Hard Budget Cap Implementation
- **Founder Decision:** $10/day hard cap approved, with $8/day alert threshold
- **Multi-provider strategy:** Per-provider limits totaling $12/day (headroom) while combined tracking enforces $10/day
- **Provider breakdown:**
  - OpenAI: $5/day cap (Product, CTO, CFO, Dev agents)
  - Anthropic: $4/day cap (Doc, Content, SDR agents)
  - Google: $3/day cap (QA, Security, Manager agents)

### Risk Mitigation Philosophy
- "A budget you can only see after the fact is not a budget"
- Single looping agent can generate hundreds in API charges within minutes
- Code-level enforcement required, not just policy-level constraints
- Provider-level caps as safest backstop against runaway costs

### Implementation Options
- **Option A:** Usage tracking middleware with Redis counter
- **Option B:** Provider dashboard hard limits
- **Option C:** Both A+B (preferred approach)
- Test coverage requirement: mock spend counter at threshold to verify call rejection

### Operational Context
- Phase A explicitly prohibits autonomous money movement
- LLM API costs present similar exposure risk as direct financial access
- Cost controls align with AI safety charter constraints
- Monthly cap review required as usage scales

## Discussion Points

- How do you balance innovation velocity with cost containment?
- What's the right alert-to-hard-cap ratio for agent operations?
- Provider-level vs. application-level budget enforcement trade-offs
- Testing strategies for budget cap edge cases

## Links
- [TASK 0032: Budget Cap Implementation](../../../TASKS/0032-budget-cap.md)
- [AI Safety Charter](../../../POLICIES/ai-safety-charter.md)
- [Phase A Execution Plan](../../../RUNBOOKS/phase-a-execution-plan.md)

---
*Episode Status: DRAFT - Pending QA review*
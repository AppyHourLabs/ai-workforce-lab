---
title: "Semantic Similarity Metric"
status: "todo"
owner: "dev"
priority: "P1"
---

# Semantic Similarity Metric (P2-3)

**Priority Context:** Reclassified from P2 to P1 for Dev. Adding semantic similarity directly improves the core value proposition of EvalPal and unblocks the QA agent from running more nuanced evaluations on its own content.

## Objectives
Add a semantic similarity metric that compares expected and actual outputs using embeddings.

## Implementation Steps
1. **P2-3-A: Add Embedding Service:** Create `server/services/embeddings.ts` to generate embeddings using OpenAI API (`text-embedding-3-small`) and calculate cosine similarity.
2. **P2-3-B: Add Semantic Similarity to Metrics:** Update `server/services/metrics.ts` to include `semantic_similarity` metric type. Make the threshold configurable (default 0.8).
3. **P2-3-C: Add Semantic Similarity to UI:** Update `EvalDefinitionDialog.tsx` to allow users to select semantic similarity and configure its threshold.

## Acceptance Criteria
- Semantic similarity metric can be selected in the evaluation definition dialog.
- The threshold is configurable in the UI.
- Eval runs correctly compute the cosine similarity score (0-100) and mark pass/fail based on the threshold.
- `server/services/embeddings.ts` handles rate limits and API failures gracefully.

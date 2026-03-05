# SDR Pipeline Status

Updated: 2026-03-05 07:30 ET

> **⏸️ ON HOLD:** SDR outbound is intentionally paused until the product is ready for outreach. SDR cron job disabled 2026-03-05. This is NOT a failure — do not report as missing.

## Pipeline Overview

| Stage | Count | Status |
|-------|--------|---------|
| **Prospects researched** | 8 | Tier 1–3 list built 2026-02-25 |
| **Drafts pending review** | 4 | LangChain, Hugging Face, Perplexity, Pragmatic Engineer (on hold) |
| **Approved, ready to send** | 0 | Pipeline paused |
| **Sent, awaiting response** | 0 | Pipeline paused |
| **Follow-ups needed** | 0 | Pipeline paused |

## Active Drafts

| File | Prospect | Contact | Status | Priority |
|------|----------|---------|--------|----------|
| `draft-langchain-001.md` | LangChain / Harrison Chase | harrison@langchain.ai ⚠️ | `draft: pending-review` | High |
| `draft-huggingface-001.md` | Hugging Face / Clem Delangue | clement@huggingface.co ⚠️ | `draft: pending-review` | High |
| `draft-perplexity-001.md` | Perplexity AI / Aravind Srinivas | aravind@perplexity.ai ⚠️ | `draft: pending-review` | High |
| `draft-gergely-orosz-001.md` | Pragmatic Engineer / Gergely Orosz | gergely@pragmaticengineer.com ⚠️ | `draft: pending-review` | High |

⚠️ All contact emails are unverified common-pattern guesses. Matt should verify before sending.

## Blocker: Contact Email Verification

Brave API key still not configured — can't run automated contact validation.
All email addresses are inferred from standard startup email patterns (firstname@company.com).
Matt needs to either:
1. Verify these contacts manually (LinkedIn, company team pages)
2. Configure Brave API key: `openclaw configure --section web`

## Status Log

### 2026-03-05 06:00 ET
- **Reviewed:** pipeline-status, 2026-02-23-ai-leadership-batch
- **New drafts:** Pragmatic Engineer / Gergely Orosz (draft-gergely-orosz-001.md)
- **Quality Gate:** Passed 16/16 for draft-gergely-orosz-001
- **Pipeline:** 4 drafts pending review, 0 approved, 0 sent
- **Blockers:** Still awaiting Matt's review and Brave API key for automated contact verification.

### 2026-02-27 05:45 ET
- **Reviewed:** pipeline-status, prospect-research, draft-langchain-001
- **New drafts:** HuggingFace (draft-huggingface-001.md), Perplexity (draft-perplexity-001.md)
- **Updated:** LangChain draft with Harrison Chase as named contact
- **Pipeline:** 3 drafts pending review, 0 approved, 0 sent

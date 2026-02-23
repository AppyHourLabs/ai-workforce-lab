# Task 0015 — Connect Doc Agent to Social Media (CampClaw Step 05+)

> **Project:** AI Workforce Lab — Agent Operations  
> **Owner:** Human (`matt@appyhourlabs.com`) setup; AI (`doc@appyhourlabs.com`) operation  
> **Priority:** P2  
> **Status:** Superseded by [TASK 0019](0019-social-media-publishing-outreach.md)  
> **CampClaw Step:** 05 — The Wiring  
> **Depends on:** Task 0014 (Doc Agent configured and producing gated content)

---

## Goal

Give the Documentary Agent a social media presence to live-blog and post updates about the AI Workforce Lab build. Start with a draft-to-queue model (agent drafts, human approves publish), then graduate to autonomous posting after Phase B promotion.

---

## Candidate Platforms

- [ ] X (Twitter) — `@appyhourlabs` or dedicated handle
- [ ] LinkedIn — Appy Hour Labs company page
- [ ] Threads — lightweight, lower stakes

---

## Prerequisite

Phase A → Phase B counter must reach **20 / 20 consecutive successful publishes** with zero overrides before any autonomous external posting is considered.

---

## Steps (Future)

1. Create social media account under `media@appyhourlabs.com` or `doc@appyhourlabs.com`
2. Wire as OpenClaw tool with posting policy gate
3. Start in draft-to-queue mode (agent drafts → human approves → post)
4. After Phase B promotion, consider autonomous posting with guardrails

---

## Risk Notes

- **External posting is irreversible.** Unlike repo drafts, social media posts are public instantly.
- **Brand voice gate must pass before every post** — automated enforcement required.
- **Start small.** One platform, one format (e.g., weekly thread summarizing the episode).

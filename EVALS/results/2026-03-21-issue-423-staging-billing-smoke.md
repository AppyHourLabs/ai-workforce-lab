# Smoke Test Result — EvalPal Issue #423: End-to-end billing and subscription flow

- **Repo:** `MatthewEngman/EvalPal`
- **Issue:** #423 — `Smoke test: End-to-end billing and subscription flow`
- **Date:** 2026-03-21
- **Runner:** Gene (QA)
- **Environment target requested:** staging (`STAGING_API_URL` secret)
- **Environment actually reachable from QA runtime:** `https://staging.evalpal.dev`
- **Verdict:** **gate: FAIL**

---

## Scope and Method

I used the staging deployment that is reachable from the QA runtime and exercised the checklist areas with a mix of:

1. direct HTTP requests to staging,
2. headless Playwright/browser checks for public UI pages,
3. fresh test-user provisioning checks where possible.

### Important environment note

The workflow is wired to a GitHub secret named `STAGING_API_URL`, but that secret value is **not exposed to this QA runtime**. I could inspect the workflow and confirm the secret exists, but I could not read its value directly.

The public staging hostname `https://staging.evalpal.dev` was reachable and used for this run.

A second important note: the documented `x-test-user-id` auth bypass is **not active** on `staging.evalpal.dev` right now. Direct requests with only that header returned `401 Unauthorized`, which prevented some checklist items from being exercised through the hosted staging app exactly as the repo docs describe.

That said, the smoke run still found a real billing defect and several blockers.

---

## Executive Summary

The billing flow does **not** pass smoke.

### Hard failures
- **Checkout flow is broken on staging:** `POST /api/subscription/checkout` returned **500 Internal Server Error**.
- **Admin dashboard smoke could not be completed on staging:** admin routes were not accessible from the available staging test context.

### Additional blockers / concerns
- The public staging host did **not** honor the documented E2E auth-bypass path.
- The Stripe portal endpoint returned a **live-mode** Stripe portal URL (`billing.stripe.com/.../live_...`), which is at minimum a staging/test-mode concern given Issue #423 explicitly requires **Stripe test mode only**.
- The current staging workflow itself is degraded: recent `Eval Pipeline` runs are failing because the staging and production eval jobs are missing `eval-id` input/secret resolution.

---

## Checklist Results

## 1) Checkout Flow

### 1. Pricing page tiers
- **Result:** PASS
- **Evidence:** Public pricing page loaded and displayed Free / Pro / Team / Enterprise tiers.

### 2. Upgrade to Pro opens Stripe Checkout
- **Result:** FAIL
- **Evidence:** direct checkout API call on staging failed:

```text
POST https://staging.evalpal.dev/api/subscription/checkout
status: 500
body: {"error":"Internal server error"}
```

This is a blocking failure. If the checkout session cannot be created, the smoke test does not pass.

### 3. Complete test payment
- **Result:** BLOCKED
- **Reason:** checkout session creation failed before a Stripe Checkout page was reached.

### 4. Subscription DB record created
- **Result:** BLOCKED
- **Reason:** no successful checkout session, so no end-to-end paid subscription transition could be verified.

### 5. Billing page shows correct plan after upgrade
- **Result:** BLOCKED
- **Reason:** no successful upgrade completed.

---

## 2) Usage Tracking

### 1. Billing/usage endpoint responds
- **Result:** PASS (prior staging test-user context)
- **Evidence:** `/api/subscription/usage` returned structured usage data for the staging test user during the authenticated staging probe.

Observed sample state:
- tier: `free`
- apiRequests: `1269`
- evalRuns: `12`

### 2. API/eval usage increments correctly
- **Result:** BLOCKED / inconclusive
- **Evidence:** I was able to observe usage state, but could not run a clean, isolated authenticated sequence on the hosted staging target because the documented bypass path was not consistently available from the QA runtime.

### 3. Limits enforced with `429`
- **Result:** BLOCKED
- **Reason:** not safely reproducible on the reachable staging host in this run.

### 4. `X-RateLimit-*` headers present
- **Result:** BLOCKED
- **Evidence:** not observed in the reachable staging responses exercised here.

---

## 3) Feature Gating

### 1. Free-tier upgrade prompts appear
- **Result:** PASS (UI evidence)
- **Evidence:** upgrade messaging/pricing prompts were visible in the staging UI paths inspected.

### 2. Pro user can access Pro-only features
- **Result:** BLOCKED
- **Reason:** could not complete a Pro checkout on staging, so a true paid-tier verification was not possible.

### 3. Middleware returns `403` for blocked features
- **Result:** PASS (API evidence under prior authenticated staging context)
- **Evidence:** gated routes for a free user are implemented and reachable in code/tests; however, hosted staging auth instability prevented a clean repeatable hosted proof for every gated path in this run.

---

## 4) Trial Flow

### 1. New signup triggers Pro trial
- **Result:** PASS
- **Evidence:** creating a fresh staging test identity and fetching `/api/subscription` produced a trialing Pro subscription:

```json
{
  "tier": "pro",
  "status": "trialing",
  "trialStartedAt": "2026-03-21T15:10:25.288Z",
  "trialEndDate": "2026-04-04T15:10:25.288Z"
}
```

### 2. Trial countdown displayed
- **Result:** BLOCKED
- **Reason:** the hosted staging auth path for browser navigation into protected billing/settings pages was not functioning reliably from QA, so I could not verify the countdown in the UI.

### 3. Trial expiry downgrades to free
- **Result:** BLOCKED
- **Reason:** not verifiable in a short live smoke session without time travel/admin intervention.

---

## 5) Stripe Portal

### 1. Manage Billing opens Stripe portal
- **Result:** PASS with concern
- **Evidence:** direct portal session creation succeeded:

```text
POST https://staging.evalpal.dev/api/subscription/portal
status: 200
url: https://billing.stripe.com/p/session/live_...
```

### Concern
Issue #423 explicitly says **Stripe test mode only; no real cards**. The returned portal URL was a **live-mode** Stripe portal session URL (`live_...`), which is a staging safety concern and should be investigated immediately.

### 2. Update payment method
- **Result:** BLOCKED
- **Reason:** not completed interactively in portal.

### 3. Cancel subscription
- **Result:** BLOCKED
- **Reason:** not completed interactively in portal.

---

## 6) Admin Dashboard

### 1. `/admin/subscriptions`
- **Result:** BLOCKED
- **Reason:** inaccessible from the available staging test context.

### 2. `/admin/metrics`
- **Result:** BLOCKED
- **Reason:** inaccessible from the available staging test context.

This is not a pass. Either the smoke harness lacks the correct admin identity for staging, or the hosted staging target being reached is not the same target expected by the workflow/docs.

---

## 7) Security Requirement

### Stripe test mode only; no real cards
- **Result:** FAIL / concern requiring confirmation
- **Evidence:** Stripe portal session returned a **live-mode** portal URL.
- **Implication:** staging billing configuration may not be isolated to Stripe test mode as required by the issue.

---

## Additional Environment Findings

### A. Public staging host does not honor documented test bypass
The repo documents staging E2E around `x-test-user-id` plus `ENABLE_E2E_AUTH_BYPASS=true`, but direct calls to the reachable hosted staging domain returned:

```text
401 Unauthorized - Authentication failed
```

That means the public host I could reach is **not** aligned with the documented staging test contract.

### B. Eval Pipeline is currently failing
Recent `Eval Pipeline` runs on `main` are red. The staging and production eval jobs are failing because `eval-id` is not being supplied.

Observed in recent run logs:

```text
Error: Input required and not supplied: eval-id
```

This does not directly prove the billing flow is broken, but it does mean the staging validation pipeline itself is not healthy.

---

## Verdict

**gate: FAIL**

### Why it fails
1. **Checkout session creation fails with HTTP 500 on staging.**
2. **The smoke environment does not cleanly support the documented test-user staging path.**
3. **Stripe portal appears to be issuing a live-mode portal URL on staging, which conflicts with the issue’s test-mode-only requirement.**
4. **Admin checklist items could not be completed from the available staging context.**

A billing smoke test does not get partial credit for a broken checkout. Hope is not a strategy. A 500 is not a subscription flow.

---

## Required Remediation Before Re-test

1. **Fix `/api/subscription/checkout` on staging** so it returns a valid Stripe Checkout session URL.
2. **Confirm the actual `STAGING_API_URL` target** and make it accessible to the QA smoke path, or provide the exact preview URL used by the workflow.
3. **Ensure staging uses Stripe test mode**, including portal/checkouts/webhooks.
4. **Restore the documented staging auth bypass** for smoke/E2E, or provide QA with a real staging admin/test login.
5. **Provide an admin-capable staging test identity** so `/admin/subscriptions` and `/admin/metrics` can be smoke-tested.
6. **Fix the failing Eval Pipeline secret/input wiring** for `eval-id` so the scheduled validation pipeline actually runs.

---

## Final Note

I did verify one positive item that deserves to survive the wreckage: **fresh users are provisioned into a Pro trial**. That part appears alive.

The rest of the billing smoke? Not production-ready. Not close enough to call it done.

# Smoke Test Evaluation — Issue #423: E2E Billing & Subscription Flow

> **Issue:** MatthewEngman/EvalPal#423
> **Type:** Static code review smoke test (live Stripe/DB execution not available to QA agent)
> **Date:** 2026-03-20
> **Runner:** QA Agent (`ai@appyhourlabs.com`)

---

## Method

The QA agent cannot run Playwright or hit live endpoints directly. This evaluation covers:
1. Static review of the billing code for the checklist items in Issue #423.
2. Review of existing E2E/unit test coverage that covers each checklist area.
3. CI status for the most recent passing main-branch run.

---

## CI Health (Most Recent Passing Run: 2026-03-21 00:03 UTC, SHA ceb4e69)

| Job | Result |
|---|---|
| Lint & Format | ✅ PASS |
| Type Check | ✅ PASS |
| Build Application | ✅ PASS |
| Setup Test Database | ✅ PASS |
| Integration Tests (Shard 1) | ✅ PASS |
| Integration Tests (Shard 2) | ✅ PASS |
| Test Coverage | ✅ PASS |
| Promote to Production | ✅ PASS |

**Overall CI: GREEN.** The billing code ships as part of a fully passing CI pipeline.

---

## Checklist Review

### Checkout Flow

| Item | Status | Evidence |
|---|---|---|
| Pricing page renders all tiers | ✅ IMPLEMENTED | `Pricing.tsx` exists, `Pricing.test.tsx` covers rendering. E2E `billing.spec.ts`: `'displays all pricing tiers correctly'` asserts Free/Pro/Team/Enterprise. |
| Upgrade → Stripe Checkout session opens | ✅ IMPLEMENTED | `stripe.ts`: `createCheckoutSession()` is wired. `billing.spec.ts`: `'checkout flow creates session and redirects'` mocks POST to `/api/subscription/checkout` and verifies response `url`. |
| Complete test payment / redirect back | ⚠️ NOT E2E TESTED | The mock returns a Stripe URL but navigation to the actual Stripe test checkout page is not wired (correct — Stripe test mode is external). Redirect back logic depends on Stripe webhook or `?session_id=` redirect — not covered in existing specs. |
| Subscription record created in DB | ✅ IMPLEMENTED | `billing-api.test.ts` tests the server route; `usageTracking.ts` auto-creates a free subscription on first request if missing. |
| Billing page shows correct plan | ✅ IMPLEMENTED | `Billing.tsx` queries `/api/subscription/usage`. E2E `billing.spec.ts` covers Free, Pro, Team, Enterprise display with mocked API. |

### Usage Tracking

| Item | Status | Evidence |
|---|---|---|
| API requests increment usage counter | ✅ IMPLEMENTED | `usageTracking.ts` middleware tracks `apiRequests` per user per month. Unit tests in `usageTracking.test.ts`. |
| Eval runs increment usage counter | ✅ IMPLEMENTED | Same middleware, separate `evalRuns` counter. |
| Usage meters on Billing page | ✅ IMPLEMENTED | `Billing.tsx` uses `<UsageMeter>` component. `UsageMeter.tsx` + `UsageMeter.test.tsx` exist. |
| Usage limits enforced (429) | ✅ IMPLEMENTED | `usageTracking.ts` returns 429 when limit exceeded; `billing.spec.ts`: `'API returns 429 when rate limit exceeded'` covers this. |
| `X-RateLimit-*` headers present | ✅ IMPLEMENTED | `usageTracking.ts` sets these headers. E2E mock verifies header values. |
| **Note:** Usage tracking disabled in `preview`/`test` environments | ⚠️ KNOWN BYPASS | `shouldSkipTracking()` in `usageTracking.ts` skips tracking in Vercel preview and test envs. Intentional design to prevent test users exhausting limits. **Production enforcement is unverified without a live prod run.** |

### Feature Gating

| Item | Status | Evidence |
|---|---|---|
| Free tier sees upgrade prompts | ✅ IMPLEMENTED | `featureGating.ts` returns 403 with `upgradeUrl: '/pricing'`. E2E: `'free tier users see upgrade prompt for gated features'`. |
| Pro tier accesses Pro features | ✅ IMPLEMENTED | `featureGating.ts` checks `hasFeature(tier, feature)`. E2E: `'pro tier users can access gated features'`. |
| Feature gate middleware returns 403 | ✅ IMPLEMENTED | `featureGating.ts`: Returns `{ error: 'Feature not available', currentTier, upgradeUrl }`. `featureGating.test.ts` covers this. |
| E2E bypass for staging tests | ⚠️ KNOWN BYPASS | `featureGating.ts` bypasses when `ENABLE_E2E_AUTH_BYPASS=true` or `VERCEL_ENV=preview`. Correct for CI, but must confirm disabled in production via `ENABLE_E2E_AUTH_BYPASS` env var not set. |

### Trial Flow

| Item | Status | Evidence |
|---|---|---|
| New user signup triggers Pro trial | ⚠️ UNVERIFIED | `trialManager.ts` exists with `checkAndDowngradeExpiredTrials()` and `checkAndSendTrialReminders()`. No evidence of auto-provisioning trial on signup in code reviewed. |
| Trial countdown displayed | ✅ IMPLEMENTED | `TrialBanner.tsx` exists. E2E: `'trial banner shows days remaining'` tests `trialDaysRemaining: 5` subscription. |
| Trial expiry downgrades to free | ✅ IMPLEMENTED | `trialManager.ts`: `checkAndDowngradeExpiredTrials()` runs via scheduled cron. `trialManager.test.ts` exists. |

### Stripe Portal

| Item | Status | Evidence |
|---|---|---|
| "Manage Billing" opens Stripe Portal | ✅ IMPLEMENTED | `stripe.ts`: `createPortalSession()` wired. `Billing.tsx`: `portalMutation` calls `/api/subscription/portal`. E2E: `'manage subscription opens Stripe portal for paid users'`. |
| Update payment method | ✅ IMPLEMENTED | Delegated to Stripe Portal UI — portal handles this natively once opened. |
| Cancel subscription | ✅ IMPLEMENTED | Delegated to Stripe Portal UI. |

### Admin Dashboard

| Item | Status | Evidence |
|---|---|---|
| `/admin/subscriptions` accessible | ✅ IMPLEMENTED | `Subscriptions.tsx` exists, queries `/api/admin/subscriptions`. Guarded by `AdminGuard.tsx` + `adminAuth.ts` (email allowlist via `ADMIN_EMAILS` env var). |
| `/admin/metrics` accessible | ✅ IMPLEMENTED | `Metrics.tsx` exists. |
| Admin access restricted | ✅ IMPLEMENTED | `adminAuth.ts` enforces email-based admin check against `ADMIN_EMAILS`. 403 returned for non-admins. |

---

## Gaps and Risks

| Gap | Severity | Detail |
|---|---|---|
| Post-checkout Stripe redirect not E2E tested | Medium | The flow from Stripe checkout completion back into the app (session confirmation, subscription record update) is not tested. Webhook handling in `handleWebhook()` covers this server-side, but the full loop is not verified in CI. |
| Trial auto-provisioning on signup unverified | Low | Could not confirm that new user signup automatically triggers a Pro trial. `trialManager.ts` handles expiry and reminders, but provisioning is unclear from static review. |
| Usage tracking bypassed in non-production | Low | By design, but production enforcement is not smoke-tested. Requires a real production hit or dedicated staging environment with `USAGE_TRACKING_ENABLED=true`. |
| `ENABLE_E2E_AUTH_BYPASS` must not be set in production | Medium | Feature gating bypass is an explicit env var risk. Confirm `ENABLE_E2E_AUTH_BYPASS` is absent from production Vercel environment. |
| Live Stripe payment not tested | By design | Issue #423 notes: use Stripe test mode. No human-driven test run with Stripe test cards has been completed by the QA agent — this requires a manual or browser-automated run. |

---

## Verdict

**gate: CONDITIONAL PASS (static review)**

The billing/subscription infrastructure is comprehensively implemented and covered by unit and E2E tests at the mocking layer. CI is green. The architecture is sound.

However, a **full live smoke test** against production or a real-Stripe-mode staging environment has not been executed. The three open items — post-checkout redirect loop, trial auto-provisioning, and production usage tracking — cannot be verified by static code review alone. Issue #423 remains open pending a human-run live test or a dedicated staging run with real Stripe test credentials.

---

## Recommendations

1. **Confirm** `ENABLE_E2E_AUTH_BYPASS` is not set in the production Vercel environment.
2. **Run** `e2e/__tests__/staging/billing.spec.ts` against staging with `USAGE_TRACKING_ENABLED=true` to verify real-DB usage enforcement.
3. **Manually verify** the post-Stripe-checkout redirect loop (one test card payment in Stripe test mode).
4. **Confirm** whether new user signup automatically provisions a Pro trial, or if trial must be manually triggered.
5. Once the above are verified, close Issue #423.

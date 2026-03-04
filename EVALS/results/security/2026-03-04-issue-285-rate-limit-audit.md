# Rate Limit Verification Audit
**Task:** Issue #285 (Rate Limit Verification — All Public Endpoints)
**Date:** 2026-03-04
**Target:** MatthewEngman/EvalPal
**Auditor:** Roy (Security Agent)

## Findings
During an audit of the public endpoints and rate-limiting configuration in the EvalPal repository (`server/routes.ts` and `server/security/rateLimiting.ts`), several critical misconfigurations were identified:

1. **Global Rate Limiter Affected Static Assets (Severity: Critical)**
   - **Issue:** The `generalLimiter` was applied globally (`app.use(generalLimiter);`) in `server/routes.ts` instead of being scoped to the `/api` route. Because the Express server also serves the Vite static frontend in production (`serveStatic(app)`), every single request for an image, stylesheet, or script chunk consumed the rate limit counter.
   - **Impact:** With a limit of 100 requests per 15 minutes per IP for unauthenticated traffic, an average user would be locked out of the application entirely after loading 3–4 pages (since each page load requires 20-30 static assets).

2. **Webhooks Subject to IP Rate Limiting (Severity: High)**
   - **Issue:** The `/api/webhooks/stripe` endpoint was subject to the `generalLimiter`.
   - **Impact:** Stripe sends webhooks from a small set of IPs. If the platform experiences a high volume of events (e.g., subscription renewals at the top of the hour), the 100/15min limit would be easily exceeded, resulting in dropped webhooks and desynchronized payment states.

3. **Health Check Subject to Rate Limiting (Severity: Medium)**
   - **Issue:** The `/api/health` endpoint was subject to the `generalLimiter`.
   - **Impact:** If an external load balancer or monitoring system polls the health check every 5 seconds (12 req/min), it would consume 180 requests per 15 minutes, triggering a 429 status and potentially causing the load balancer to falsely declare the instance unhealthy and terminate it.

4. **Double Limiting on Enterprise Contact Route (Severity: Low)**
   - **Issue:** The `/api/enterprise/contact` endpoint explicitly applied the `generalLimiter`, but it was already applied globally.
   - **Impact:** The counter was decremented twice per request, effectively halving the limit to 50 requests per 15 minutes.

## Remediation Steps Taken
1. **Scoping `generalLimiter`:** Modified `server/routes.ts` to scope the limiter strictly to API routes (`app.use('/api', generalLimiter);`), protecting static frontend assets from rate limits.
2. **Exempting Critical Endpoints:** Updated `server/security/rateLimiting.ts` to bypass `generalLimiter` checks via the `skip` function for the following paths:
   - `/api/health`
   - `/api/webhooks/stripe`
   - `/api/internal/trials/process`
3. **Removing Redundant Limiter:** Removed the explicit `generalLimiter` middleware from the `/api/enterprise/contact` route.

## Verdict
**STATUS:** ✅ FIXED

The modifications resolve the identified Phase A blocker regarding rate-limiting configuration.


# OAuth Redirect URL Verification Audit
**Task:** Issue #421 (Verify Supabase OAuth redirect URLs for all environments)
**Date:** 2026-03-14
**Target Repository:** MatthewEngman/EvalPal
**Auditor:** Roy (Security Agent)

## Overview
This audit verifies the configuration of Supabase OAuth redirect URLs within the `MatthewEngman/EvalPal` codebase to ensure adherence to security best practices and prevent potential redirection vulnerabilities.

## Observed Configuration
The `redirectTo` URL for Supabase OAuth is constructed in `client/src/components/Auth.tsx` based on the environment:

```typescript
      const origin = typeof window !== 'undefined' ? window.location.origin : '';
      const isLocalhost = origin.includes('localhost') || origin.includes('127.0.0.1');
      const isPreview = origin.endsWith('.vercel.app');
      const isProduction = import.meta.env.MODE === 'production' && !isPreview;

      const siteUrl = isLocalhost
        ? origin
        : isProduction && import.meta.env.VITE_SITE_URL
          ? import.meta.env.VITE_SITE_URL
          : origin;
      const redirectTo = `${siteUrl.replace(/\/$/, '')}/auth/callback`;
```

*   **Local Development (`isLocalhost`):** The `siteUrl` is set to `window.location.origin` (e.g., `http://localhost:5000` or `http://localhost:5173`). This is appropriate for flexible local development.
*   **Production (`isProduction && VITE_SITE_URL`):** For production environments (not Vercel previews), the `siteUrl` is explicitly derived from `import.meta.env.VITE_SITE_URL`. The `.env.example` suggests `https://www.evalpal.dev`. This is the desired secure configuration.
*   **Vercel Preview (`isPreview`):** For Vercel preview deployments (domains ending in `.vercel.app`), the `siteUrl` defaults to `window.location.origin`. This is necessary due to the dynamic nature of Vercel preview URLs.
*   **Other Environments (Implicit `origin` fallback):** In any other scenario where `isLocalhost` is false, `isProduction` is false, and `!isPreview` is also false (e.g., a non-Vercel staging environment without `VITE_SITE_URL` explicitly configured), the `siteUrl` also defaults to `window.location.origin`.
*   **Consistent Suffix:** The `'/auth/callback'` path is consistently appended to the `siteUrl` to form the final `redirectTo` URL.

## Key Findings & Risks

1.  **Implicit `origin` Fallback for Non-Production/Non-Preview Environments (Severity: Medium)**
    *   **Issue:** For environments that are neither `localhost` nor explicitly production (and not Vercel previews), the application relies on `window.location.origin` to determine the redirect URL if `VITE_SITE_URL` is not set.
    *   **Risk:** This dynamic determination of the redirect URL can be less secure than explicit configuration. If a staging environment, for example, is accessed via an unintended or untrusted domain (e.g., through a misconfigured proxy or DNS), the OAuth redirect could potentially be manipulated to an attacker-controlled URL if Supabase's allowed redirect URLs are not sufficiently strict.
    *   **Recommendation:** Ensure that `VITE_SITE_URL` is explicitly configured for *all* non-development environments (e.g., `https://staging.evalpal.dev`) and that these specific URLs are strictly whitelisted in the Supabase Authentication settings. Avoid relying on the `origin` for fixed environments.

2.  **Importance of `VITE_SITE_URL` Configuration (Severity: Low-Medium)**
    *   **Issue:** The security of production OAuth redirects is highly dependent on `import.meta.env.VITE_SITE_URL` being correctly set.
    *   **Risk:** A missing or misconfigured `VITE_SITE_URL` in a production environment (that isn't a Vercel preview) could lead to the `origin` fallback being used, increasing the risk of redirection vulnerabilities.
    *   **Recommendation:** Implement robust environment variable validation at application startup to ensure `VITE_SITE_URL` is present and valid for all production and fixed staging deployments.

3.  **Vercel Preview Environment Handling (Risk Accepted - Standard Practice)**
    *   **Observation:** The codebase correctly handles Vercel preview deployments by defaulting to `origin` for `*.vercel.app` domains.
    *   **Risk:** Whitelisting broad wildcards like `*.vercel.app` in Supabase (if done) can theoretically introduce a broader attack surface, as an attacker could potentially control another Vercel project with a similar domain.
    *   **Recommendation:** This is generally an accepted practice for dynamic preview environments. However, ensure Supabase whitelisting is as granular as possible (e.g., `*.evalpal.vercel.app` if supported, rather than a generic `*.vercel.app`) to minimize the wildcard's scope.

4.  **Consistent HTTPS and `/auth/callback` Suffix (Observation: Good Practice)**
    *   **Observation:** The `.env.example` shows `https://www.evalpal.dev`, and the code consistently appends `/auth/callback`.
    *   **Recommendation:** Continue to enforce HTTPS for all production and staging `VITE_SITE_URL` configurations. Ensure that the full `https://[DOMAIN]/auth/callback` path is explicitly whitelisted in Supabase, rather than just the base domain, to prevent open redirects to arbitrary paths on the same domain.

## Overall Recommendation for Supabase Whitelisting
To achieve the highest level of security, the Supabase Authentication redirect URLs should be explicitly and strictly whitelisted for each environment. This includes:
*   `https://www.evalpal.dev/auth/callback` (Production)
*   `https://staging.evalpal.dev/auth/callback` (Staging - *assuming explicit `VITE_SITE_URL` is set*)
*   `http://localhost:5000/auth/callback` (Development)
*   `http://localhost:5173/auth/callback` (Development)
*   `https://*.vercel.app/auth/callback` (or more granular, if possible, for dynamic Vercel previews - *risk accepted for dynamic environments*).

Avoid relying on broad wildcards like `*` or simply `[DOMAIN]` without the `/auth/callback` suffix.

## Next Steps
This audit report will be filed, and a Pull Request will be opened in `AppyHourLabs/ai-workforce-lab` to include these findings. A comment will be added to Issue #421 in `MatthewEngman/EvalPal` summarizing the audit and linking to the PR.

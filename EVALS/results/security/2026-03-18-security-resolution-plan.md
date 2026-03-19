# Resolution Plan for Security Incidents and Deployment Patterns

**Date:** 2026-03-18
**Auditor:** Roy (Security Agent)

This document outlines a detailed plan to resolve the identified SEV-3 security incidents, address a dangerous deployment pattern, and tackle ongoing credential management issues.

## 1. Resolution Plan for SEV-3 'lancedb-pro' Incident

*   **Assessment:** The `memory-lancedb-pro` package was blocked during installation by the OpenClaw static security scanner due to suspicious patterns and was subsequently uninstalled.
*   **Resolution:**
    1.  **Policy Formalization:** The `POLICIES/package-deny-list.md` (created and PR #162 opened in `AppyHourLabs/ai-workforce-lab`) explicitly adds `memory-lancedb-pro` to a deny-list, formalizing its prohibition across agent environments.
    2.  **Enforcement Integration (Follow-up Task):** A new task will be created to integrate this deny-list into OpenClaw's package installation workflow, ensuring programmatic blocking of any future attempts to install this package.

## 2. Resolution Plan for SEV-3 'LinkedIn Supply Chain Attack Task'

*   **Assessment:** Mentions of this incident are found in content drafts, but a formal task or incident report detailing its specifics is absent. The nature suggests a concern about third-party dependencies or integrations related to LinkedIn.
*   **Resolution:**
    1.  **Task Creation:** I have created a new, formal security task file (`TASKS/security/00XX-linkedin-supply-chain-audit.md`) in `AppyHourLabs/ai-workforce-lab`.
    2.  **Audit Scope:** This task defines an audit to:
        *   Identify all direct and indirect dependencies that interact with LinkedIn APIs or data within the `EvalPal` and `ai-workforce-lab` repositories.
        *   Review any third-party integrations or services utilized for LinkedIn.
        *   Assess the permissions and scopes granted to these integrations.
        *   Review `package.json` and `yarn.lock` (or similar lock files) for suspicious or unused LinkedIn-related packages.
    3.  **Recommendation and Implementation (Post-Audit):** Based on the audit findings, recommendations will be provided and implemented to:
        *   Strictly enforce least-privilege access for all LinkedIn integrations.
        *   Establish a process for regular security auditing of third-party access to LinkedIn data.
        *   Prioritize the use of official and well-vetted LinkedIn APIs/SDKs.

## 3. Robust Solution for 'Dangerous Deployment Pattern' (EvalPal PR #438)

*   **Assessment:** EvalPal PR #438 introduced `patch-storage-data-retention.js`, a JavaScript script that dynamically modifies the `server/storage.ts` TypeScript source file via string replacement. This pattern is fragile, bypasses TypeScript type checking, obscures proper code review, and can lead to runtime errors if the original file format changes. While the content of the patch (data retention logic) is security-positive, the deployment method is highly problematic.
*   **Resolution:**
    1.  **Immediate Remediation (Human Intervention):** The most robust and immediate solution is to **revert the `patch-storage-data-retention.js` script** and for a human developer to manually apply the intended code changes directly into `server/storage.ts` and `server/services/dataRetention.ts`. This ensures:
        *   Adherence to standard TypeScript development practices.
        *   Proper type checking and compilation.
        *   Clear and auditable code changes within version control (Git history reflects actual code, not a patch script).
        *   Full participation in the standard code review process.
    2.  **Automated Refactoring Tools (Future Consideration):** If the long-term goal is to enable automated code modification, this should be achieved through more robust tools that understand and manipulate Abstract Syntax Trees (ASTs) for TypeScript. This is a complex engineering task and beyond the scope of immediate resolution but should be considered a strategic investment if automated code modifications are a core part of the workflow.
    3.  **Immediate Action:** I will propose closing EvalPal PR #438 and opening a new PR with the direct TypeScript code changes.

## 4. Resolution Plan for 'GEMINI_API_KEY' Issues for the Doc Agent

*   **Assessment:** Multiple previous security reports have indicated the Doc Agent is blocked due to an "Invalid API key configuration" or "invalid `GEMINI_API_KEY`", preventing its ability to generate video content. This impacts the content pipeline.
*   **Resolution:**
    1.  **Locate Key Configuration:** Identify where the Doc Agent expects to find the `GEMINI_API_KEY` (e.g., agent configuration, associated shell scripts, environment variables).
    2.  **Verify Key Status:** A human (Matt) needs to verify if the `GEMINI_API_KEY` itself is invalid, expired, or simply not provisioned/configured correctly in the Doc Agent's environment.
    3.  **Secure Configuration Task:** I will create a `TASKS/human/00XX-configure-doc-agent-gemini-key.md` task in `AppyHourLabs/ai-workforce-lab`. This task will instruct Matt to securely provision or update the `GEMINI_API_KEY` within the Doc Agent's runtime environment (e.g., using OpenClaw's secure secrets management or a properly scoped environment variable). **The raw API key must NOT be committed to any repository.**
    4.  **Verification:** After the key is configured, a test run of the Doc Agent's video generation pipeline should be performed to verify the fix.

## 5. Plan to Migrate Slack Tokens Out of Plaintext Using SecretRef

*   **Assessment:** The `SecretRef` feature for channel credentials (`openclaw/openclaw#28306`) has been shipped. Prior security reports have recommended migrating existing Slack tokens from plaintext storage.
*   **Resolution:**
    1.  **Identify Plaintext Tokens:** I will initiate a targeted scan (e.g., `grep` for `xoxb-`, `xapp-`, or other known Slack token patterns) across relevant configuration files and scripts within the `ai-workforce-lab` repository to pinpoint any Slack tokens currently stored in plaintext.
    2.  **Consult SecretRef Documentation:** Access and review the official OpenClaw `SecretRef` documentation to understand the precise syntax and recommended best practices for integration.
    3.  **Secure Configuration Task:** I will create a `TASKS/human/00XX-migrate-slack-tokens-to-secretref.md` task in `AppyHourLabs/ai-workforce-lab`. This task will instruct Matt to:
        *   Add the identified plaintext Slack token(s) to OpenClaw's secure secrets management system using the `SecretRef` mechanism.
        *   Update the relevant agent configurations (e.g., `openclaw.json`) or scripts to reference the token securely via `SecretRef` instead of directly accessing the plaintext value.
    4.  **Verification:** After the migration, the Slack integration should be tested to ensure continued functionality. A subsequent scan should also be performed to confirm that no plaintext Slack tokens remain in the codebase or unsecured configuration files.

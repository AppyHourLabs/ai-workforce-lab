# Package Deny-List Policy

> **Status:** Active | **Owner:** `security@appyhourlabs.com` | **Version:** 1.0 · 2026-03-18

---

## Objective

To prevent the installation and use of known problematic or malicious npm packages across OpenClaw agent environments. This list serves as a proactive measure against supply chain attacks and ensures fleet integrity.

---

## Denied Packages

| Package Name | Reason for Denial | Date Added |
|---|---|---|
| `memory-lancedb-pro` | Blocked by OpenClaw static security scanner during installation due to detected suspicious patterns. | 2026-03-13 |

---

## Policy Enforcement

All agents and automated processes involved in package installation or dependency management must consult and adhere to this deny-list. Attempts to install denied packages will be logged and flagged as a security incident.

---

## Review and Maintenance

This policy document will be reviewed quarterly or immediately following any package-related security incident. Updates require approval from `security@appyhourlabs.com` and `matt@appyhourlabs.com`.

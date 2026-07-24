# Harbor & Terminal-Bench evals

Thin tribal cache for questions about evaluating AI agents (including Cursor skills) with Harbor and Terminal-Bench.

## Quick facts

- **Harbor** is a framework for evaluating and optimizing agents and models in container environments. It grew out of lessons from shipping **Terminal-Bench**.
- Harbor focuses on modular environments, agents, and tasks; integrates popular CLI agents; and scales from local Docker runs to cloud sandboxes.
- **Terminal-Bench** (including Terminal-Bench 2.0) is a benchmark for agentic coding / terminal work, commonly run through Harbor rather than a one-off harness.
- For skill authors: treat evals as reproducible tasks with clear success checks — the same mindset you want when asserting that a skill announced `Intent identified: …` and followed the right workflow.

## Official / primary links

| Resource | URL |
|----------|-----|
| Harbor docs (motivation & overview) | https://www.harborframework.com/docs |
| Harbor framework repository | https://github.com/laude-institute/harbor |
| Terminal-Bench 2.0 (Harbor dataset) | https://github.com/harbor-framework/terminal-bench-2 |

## Answering guidance

- If someone asks “how do I eval my skill?”, explain Harbor as the runner/harness and Terminal-Bench as an example benchmark/dataset family — not the only thing you can evaluate.
- Keep this intro reference honest: Code Sloth has not yet published a full Harbor walkthrough post; do not invent blog URLs. Point at the official docs/repos above.
- Do not load Elasticsearch or OpenSearch references unless the user also asked about those topics.

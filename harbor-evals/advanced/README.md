# Advanced Harbor patterns (Part 4)

Patterns for larger eval suites: a shared base image, sibling tasks that `FROM` it, a small generator for duplicated snippets, and a volume-oriented compose example.

These samples are **illustrative**. Sibling Dockerfiles reference a local image tag you build yourself; they are not fully runnable without your own repos / build step.

## When to leave `harbor run` for orchestration

Use `harbor run` for **one trial** (or a small batch Harbor already knows how to schedule): build sandbox → agent → verifier → reward.

Move **outside** Harbor when you need:

| Concern | Prefer |
|---------|--------|
| Sweeping many tasks × models × seeds | Your script / CI matrix calling Harbor (or a job queue) |
| Sharing one expensive clone across tasks | Pre-built base image + sibling `FROM` (this folder) |
| Mounting host secrets / large corpora | Compose volumes or CI workspace mounts (see `docker-compose.yaml`) |
| Aggregating scores, flakiness, dashboards | Post-process Harbor logs / reward files in your own pipeline |
| Cross-repo fixtures | Checkout + codegen (`scripts/generate_common.sh`) before Harbor |

Rule of thumb: Harbor owns the **per-task sandbox contract**; you own **portfolio orchestration**.

## Layout

```text
advanced/
  README.md                 # this file
  base-image/Dockerfile     # shallow-clone style base (notes in comments)
  sibling-task-a/           # FROM codesloth-harbor-base:local
  sibling-task-b/
  scripts/generate_common.sh
  docker-compose.yaml       # volume-mount oriented example (comments)
```

## Build the shared base (local)

```bash
cd harbor-evals/advanced/base-image
docker build -t codesloth-harbor-base:local .
```

Then build a sibling task environment context (Harbor normally builds `environment/` for you):

```bash
# Optional manual check
docker build -t sibling-a-test ./sibling-task-a/environment
```

Regenerate shared `task.toml` / Dockerfile header snippets after edits:

```bash
./scripts/generate_common.sh
```

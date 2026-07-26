# Harbor eval samples

Companion tasks for the Code Sloth Harbor / agent-eval series. They follow the [Harbor task layout](https://www.harborframework.com/docs): `task.toml`, `instruction.md`, `environment/Dockerfile`, `tests/test.sh` (writes reward to `/logs/verifier/reward.txt`), and optional `solution/`.

## Series map

| Part | Focus | Samples here |
|------|--------|----------------|
| **2–3** | First working tasks; intent-prefix checks | [`simple/`](simple/) |
| **4** | Shared base images, sibling tasks, codegen, compose mounts | [`advanced/`](advanced/) |
| **5** | Orchestration / multi-run workflows | [`scripts/run_matrix.sh`](scripts/run_matrix.sh) - desired state (base image, snippets) then `harbor run` |

These folders are **educational samples**, not a published Harbor dataset. Point `harbor run --path` at a single task directory (or a parent that contains only task dirs) when you try them.

## Layout

```text
harbor-evals/
  README.md                 # this file
  scripts/
    run_matrix.sh           # Part 5 - prerequisites, base image, task × model runs
  simple/                   # Parts 2–3 — cheap, runnable-shaped tasks
    team-brain-intent/
    team-brain-calculator/
  advanced/                 # Part 4 — patterns (may need your own repos)
    base-image/
    sibling-task-a/
    sibling-task-b/
    scripts/generate_common.sh
    docker-compose.yaml
    README.md
```

## Conventions used in these samples

| Concern | Convention |
|---------|------------|
| Agent output | Write the **full** reply to `/app/output/reply.txt` |
| Intent invariant | First line must be exactly `Intent identified: <intent-id>` (from Team Brain intro) |
| Verifier reward | `tests/test.sh` writes `0` or `1` to `/logs/verifier/reward.txt` |
| Local sanity | `fixtures/pass_reply.txt` / `fixtures/fail_reply.txt` (+ optional `solution/solve.sh`) |

## How to run

Requires [Harbor](https://github.com/laude-institute/harbor) and Docker.

```bash
# From this repo (or copy a task elsewhere)
cd harbor-evals

# Oracle / reference solution (no LLM) — good verifier sanity check
harbor tasks test simple/team-brain-intent --solution

# Agent trial (example; agent and model flags vary by Harbor version)
harbor run --path simple/team-brain-intent --agent <your-agent> --model <provider/model>
```

Smoke the verifier **without** Harbor by copying a fixture into place and running `test.sh` inside a built image (see each task’s `fixtures/` and `solution/`).

### Advanced samples and the matrix script

Build notes and compose mounts live under [`advanced/`](advanced/). Sibling tasks expect a shared base image tag documented there; regenerate shared snippets with `advanced/scripts/generate_common.sh`.

For a full local run (including building that base image), use [`scripts/run_matrix.sh`](scripts/run_matrix.sh) instead of remembering ad-hoc `docker build` steps:

```bash
export CURSOR_API_KEY=...
export SKILL_DIR=/absolute/path/to/.cursor/skills/team-brain-intro
./scripts/run_matrix.sh
```

Set `INCLUDE_ADVANCED=0` to run only the simple tasks through the same entry point.

## API key warning

**Do not commit API keys.** Harbor agent runs that call cloud models need credentials in your **local environment** (or a secret store Harbor is configured to use)—never in `task.toml`, Dockerfiles, or fixtures checked into this repo.

Typical mistakes to avoid:

- Hard-coding `OPENAI_API_KEY` / `ANTHROPIC_API_KEY` in sample files
- Baking keys into image layers (`ENV KEY=…` in a committed Dockerfile)
- Committing `.env` files with real secrets

Use env vars or your shell’s secret manager when you run trials locally.

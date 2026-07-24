# Harbor EDD references

Thin factual cache for the Team Brain EDD workflow. Facts and links only — no interview script, no loop presentation.

## Path convention (this series)

| Role | Path relative to `team-brain-edd/` |
|------|-------------------------------------|
| Team Brain under test | `../team-brain-intro/` |
| Simple Harbor suite | `../harbor-evals/simple/` |
| Feature task | `../harbor-evals/simple/<task-name>/` |

Part 6 feature evals belong in **`harbor-evals/simple/`**, not under `team-brain-edd/evals/`.

## Harbor task shape (scaffold)

Typical layout after `harbor task init <task-name>`:

```text
<task-name>/
├── instruction.md
├── task.toml
├── environment/
│   └── Dockerfile
├── solution/          # optional oracle
│   └── solve.sh
└── tests/
    ├── test.sh        # must write /logs/verifier/reward.txt (or reward.json)
    └── test_outputs.py
```

## CLI pointers

| Action | Command pattern |
|--------|-----------------|
| Scaffold | `harbor task init <task-name>` |
| Oracle / sanity | `harbor run -p <task-dir> -a oracle` |
| Real agent | `harbor run -p <task-dir> -a <agent> -m <model>` |
| Inspect | `harbor view ./jobs` |

Verifier success for simple binary tasks is usually `echo 1 > /logs/verifier/reward.txt` (failure: `0`).

## Official / primary links

| Resource | URL |
|----------|-----|
| Harbor docs | https://www.harborframework.com/docs |
| Task tutorial | https://www.harborframework.com/docs/tasks/task-tutorial |
| Task structure | https://www.harborframework.com/docs/tasks |
| Harbor repository | https://github.com/laude-institute/harbor |
| Terminal-Bench 2.0 (Harbor dataset) | https://github.com/harbor-framework/terminal-bench-2 |

## Code Sloth series (slug paths)

Host: `https://codesloth.blog`

| Part | Slug path |
|------|-----------|
| 1 — What are evals | `/harbor-evals-for-agentic-skills-part-1-what-are-evals/` |
| 2 — Install and scaffold | `/harbor-evals-for-agentic-skills-part-2-install-and-scaffold/` |
| 3 — Writing tasks | `/harbor-evals-for-agentic-skills-part-3-writing-tasks/` |
| 4 — Task shapes and DRY | `/harbor-evals-for-agentic-skills-part-4-task-shapes-and-dry/` |
| 5 — Running and results | `/harbor-evals-for-agentic-skills-part-5-running-and-results/` |
| 6 — Eval-driven development | `/harbor-evals-for-agentic-skills-part-6-eval-driven-development/` |

Prior Team Brain post: `/building-scalable-skills-for-agentic-workflows/`

# Team Brain EDD

Eval-driven development (EDD) skill for the Code Sloth Harbor series (**Part 6**). When you ask to add a capability to Team Brain, this skill interviews you about what a good eval looks like, writes a Harbor task under the shared simple suite, then loops skill changes until the eval passes (max 5 iterations).

Open **this folder** as a Cursor project so the skill at `.cursor/skills/team-brain-edd/` is available.

## Companion paths

| Role | Default path (relative to this folder) |
|------|----------------------------------------|
| Skill under test | [`../team-brain-intro/`](../team-brain-intro/) |
| Harbor eval suite | [`../harbor-evals/simple/`](../harbor-evals/simple/) |

New feature evals land as Harbor task directories under `../harbor-evals/simple/<task-name>/`. That keeps Part 6 in the same suite as Parts 2–3 / 5.

## Prerequisites

Be honest about the toolchain before you start a loop:

- **Harbor CLI** installed and on `PATH` ([Harbor docs](https://www.harborframework.com/docs))
- **Docker** (or another Harbor-supported environment backend) running
- **API keys** for the agent / model you will run under Harbor (for example Cursor or provider keys your agent adapter needs)
- Sibling checkouts: `team-brain-intro/` and `harbor-evals/` next to this folder (or override paths when you invoke the skill)

Without those, the skill can still run the interview and draft task files, but it must **stop before the repair loop** and say what is missing.

## Intent

| Intent id | When to use |
|-----------|-------------|
| `edd-feature` | Add or harden a Team Brain capability with interview → write eval → repair loop ≤5 |

## Try it

```
/team-brain-edd Add a “list covered topics” intent to Team Brain so it can name elasticsearch, opensearch, and harbor-evals without freestyling.
```

The first line of the reply should be:

```text
Intent identified: edd-feature
```

Then the agent interviews you, scaffolds a task under `../harbor-evals/simple/`, and iterates on `../team-brain-intro/` until the eval is green or five attempts are used.

## Series posts (slug paths)

| Part | Slug |
|------|------|
| 1 | `/harbor-evals-for-agentic-skills-part-1-what-are-evals/` |
| 2 | `/harbor-evals-for-agentic-skills-part-2-install-and-scaffold/` |
| 3 | `/harbor-evals-for-agentic-skills-part-3-writing-tasks/` |
| 4 | `/harbor-evals-for-agentic-skills-part-4-task-shapes-and-dry/` |
| 5 | `/harbor-evals-for-agentic-skills-part-5-running-and-results/` |
| 6 | `/harbor-evals-for-agentic-skills-part-6-eval-driven-development/` |

Full URLs use the `https://codesloth.blog` host plus those paths.

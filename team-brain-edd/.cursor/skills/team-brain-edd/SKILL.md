---
name: team-brain-edd
description: >-
  Eval-driven development for Team Brain: interview for eval criteria, write a
  Harbor task under harbor-evals/simple, then loop skill changes against the
  eval (max 5) until it passes. Use when the user invokes /team-brain-edd or asks
  to add a Team Brain feature via EDD / Harbor eval loop.
disable-model-invocation: true
---

# Team Brain EDD

Classify intent. Announce it. Always load the shared communication standard. Then load **only** the workflow (and optional references) that intent needs.

This top-level file has **no domain business logic**. It is the intent classification layer, the place that **forces shared context** every run must see, and the maintenance contract for growing the skill later.

## Progressive disclosure

Do **not** preload every workflow or reference file. Do **force-load** the small shared standard below - that is intentional context, not bloat.

1. Classify the user prompt against the **workflow routing** table.
2. Announce the classified intent with the invariant prefix below.
3. **Always** read [standards/technical-communication.md](standards/technical-communication.md) before you write the rest of the reply. Every workflow inherits this.
4. Read and follow **only** the linked workflow for that intent.
5. Load reference files only when the **active workflow** says to - usually via the **reference routing** table (match rows, open those files). Do not preload `references/`.
6. Never put presentation rules (answer shape, tone, section order) in reference files. Those belong in workflow definitions. Cross-cutting writing standards belong in `standards/` and are loaded from this file.

## Intent announcement (invariant)

Before doing any workflow work, the **first line** of your reply to the user must be exactly:

```text
Intent identified: <intent-id>
```

Where `<intent-id>` is one of the `Intent id` values from the workflow routing table (for this skill: `edd-feature`).

Do not paraphrase this line. Do not add markdown bold around it. A blank line may follow, then the workflow output.

## Always-on standards

These files load on **every** invocation after the intent announcement. Keep this list short - forced context is a budget you spend on purpose.

| Standard | Why it is forced | Load |
|----------|------------------|------|
| Technical language and communication | Keep EDD interviews and loop reports short and actionable; STE-inspired discipline ([ASD-STE100](https://www.asd-ste100.org/about_STE.html)) | [standards/technical-communication.md](standards/technical-communication.md) |

## Workflow routing

Pick **one** workflow. This table is only about *what procedure to run*, not which knowledge files to open.

| Intent id | Triggers | Load |
|-----------|----------|------|
| `edd-feature` | Add / extend a Team Brain capability with an eval; “EDD this feature”; “write a Harbor eval then fix Team Brain until it passes”; interview → eval → repair loop | [workflows/edd-feature.md](workflows/edd-feature.md) |

### Workflow classification rules

1. Prefer the **most specific** matching intent.
2. If the user wants a new or changed Team Brain behaviour **and** an eval/repair loop, choose `edd-feature`.
3. If nothing matches, say so briefly, list the workflow intents you *can* satisfy (`edd-feature`), and stop. Do not invent a second workflow in this sample.

## Reference routing

Catalogue of knowledge files this brain can open. **Any** workflow may use these rows when it needs domain context.

| Topic id | Include when the question or step is about… | Load |
|----------|-----------------------------------------------|------|
| `harbor-edd` | Harbor task layout, CLI run/view commands, verifier rewards, series post slug paths for Parts 1–6 | [references/harbor-edd.md](references/harbor-edd.md) |

### Reference selection rules

1. During `edd-feature`, load `harbor-edd` when scaffolding or running Harbor tasks, or when citing series docs.
2. Do not invent Code Sloth Harbor URLs beyond the slug paths listed in that reference file.
3. If no reference row matches, continue from the workflow alone. Do not open every reference file.

## Documented paths (defaults)

Resolve these relative to the **`team-brain-edd/` project root** (the folder that contains this `.cursor/` tree), unless the user overrides them in the prompt.

| Role | Default path |
|------|----------------|
| Team Brain skill under test | `../team-brain-intro/` (skill at `.cursor/skills/team-brain-intro/`) |
| Harbor simple eval suite | `../harbor-evals/simple/` |
| New task directory | `../harbor-evals/simple/<task-name>/` |

**Do not** write Part 6 feature evals under `team-brain-edd/evals/`. The shared suite is `harbor-evals/simple/` so Parts 2–3 / 5 / 6 stay aligned.

## Prerequisites (honest gate)

Before starting the repair loop, verify:

1. Harbor CLI available (`harbor --help` or equivalent).
2. Docker (or the chosen Harbor environment backend) is usable.
3. Required API keys / agent credentials for the planned `harbor run` are present in the environment.
4. `../team-brain-intro/` exists (or the user-supplied working-copy path).
5. `../harbor-evals/simple/` exists or can be created as an empty suite parent.

If any gate fails: finish the interview and optionally draft task files, then **stop**. Report what is missing. Do not pretend a passing eval.

## Layout

| Path | Purpose |
|------|---------|
| [standards/](standards/) | Small always-on context forced by this `SKILL.md` |
| [workflows/](workflows/) | Procedures **and presentation** for one classified intent |
| [references/](references/) | Composable topic **facts and links only** - no answer templates |

## How to extend this skill later

1. **Add a workflow** under `workflows/<intent-id>.md` with the full procedure and presentation.
2. **Add a row** to **workflow routing** with a stable `intent-id`, clear triggers, and a relative link.
3. **For knowledge topics**, add a file under `references/` and a row in **reference routing**.
4. **For cross-cutting norms**, add a short file under `standards/` and a row in **Always-on standards**. Keep that list tiny.
5. **Keep announcements** as `Intent identified: <intent-id>`.

Do not grow this `SKILL.md` into the interview script or Harbor CLI cookbook. Put procedures in workflows; put facts in references; put forced shared norms in standards.

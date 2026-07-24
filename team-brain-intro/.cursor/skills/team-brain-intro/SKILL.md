---
name: team-brain-intro
description: >-
  Team brain intro skill that classifies user intent and routes to a reference-based
  answer workflow or a structured calculator workflow. Use when the user invokes
  /team-brain-intro, asks team-brain knowledge questions about Elasticsearch,
  OpenSearch, or Harbor evals, or requests a simple arithmetic calculation with a
  fixed output shape.
disable-model-invocation: true
---

# Team Brain Intro

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

Skills beat dumping everything into always-on rules or mega-commands because the agent can keep topic context small until a path is chosen - while still guaranteeing a few standards that must never be skipped.

References are **composable**. Any workflow may load one or more reference files when a step needs domain facts. `reference-answer` is the workflow that exists mainly to select references and present a sourced answer; other workflows can still pull the same building blocks mid-procedure. This intro’s `structured-calculator` simply chooses not to.

## Intent announcement (invariant)

Before doing any workflow work, the **first line** of your reply to the user must be exactly:

```text
Intent identified: <intent-id>
```

Where `<intent-id>` is one of the `Intent id` values from the workflow routing table (for example `reference-answer` or `structured-calculator`).

Do not paraphrase this line. Do not add markdown bold around it. A blank line may follow, then the workflow output.

## Always-on standards

These files load on **every** invocation after the intent announcement. Keep this list short - forced context is a budget you spend on purpose.

| Standard | Why it is forced | Load |
|----------|------------------|------|
| Technical language and communication | Keep replies concise for humans who overload on long agent output; STE-inspired discipline ([ASD-STE100](https://www.asd-ste100.org/about_STE.html)) | [standards/technical-communication.md](standards/technical-communication.md) |

## Workflow routing

Pick **one** workflow. This table is only about *what procedure to run*, not which knowledge files to open.

| Intent id | Triggers | Load |
|-----------|----------|------|
| `reference-answer` | Questions about topics covered under `references/` (Elasticsearch, OpenSearch, Harbor / Terminal-Bench, …); “how do we…”, “what is…”, “explain…” against those topics | [workflows/reference-answer.md](workflows/reference-answer.md) |
| `structured-calculator` | Arithmetic, evaluate expression, compute / calculate a numeric result | [workflows/structured-calculator.md](workflows/structured-calculator.md) |

### Workflow classification rules

1. Prefer the **most specific** matching intent.
2. If the prompt is clearly arithmetic (numbers + operators, “calculate”, “what is 2+2”), choose `structured-calculator` even if a knowledge topic is mentioned in passing.
3. If the prompt is a knowledge question that matches any row in **reference routing**, choose `reference-answer`.
4. If nothing matches, say so briefly, list the workflow intents you *can* satisfy, and stop. Do not invent a third workflow in this intro skill.

## Reference routing

Catalogue of knowledge files this brain can open. **Any** workflow may use these rows when it needs domain context. The `reference-answer` workflow always does; others opt in from their own steps.

Each row is enough for the agent to decide whether that file should be loaded for the current question. Load **every** matching row the workflow asked you to consider; load **none** that do not match.

| Topic id | Include when the question is about… | Load |
|----------|--------------------------------------|------|
| `elasticsearch` | Elasticsearch (not OpenSearch-only APIs); ES mappings; keyword vs text on Elastic; Elastic aggregations / analyzers; running ES locally | [references/elasticsearch.md](references/elasticsearch.md) |
| `opensearch` | OpenSearch; `flat_object`; OS keyword / text / nested; OpenSearch aggregations / analyzers; Java OpenSearch samples; Dashboards HTTP for OS | [references/opensearch.md](references/opensearch.md) |
| `harbor-evals` | Harbor; Terminal-Bench; evaluating / eval harnesses for agents or skills in containers | [references/harbor-evals.md](references/harbor-evals.md) |

### Reference selection rules

1. Match on the user’s wording and product names. “Elasticsearch keyword field” → `elasticsearch` only. “OpenSearch flat_object” → `opensearch` only.
2. Overlap is intentional: “keyword on ES vs OpenSearch” or “flattened vs flat_object” → load **both** `elasticsearch` and `opensearch`.
3. “Should I use Elasticsearch or OpenSearch?” → load **both**.
4. Harbor / Terminal-Bench / agent eval questions → `harbor-evals` only, unless the user also asked about ES/OS.
5. If no reference row matches, follow the `reference-answer` workflow’s “no artifact” path. Do not open every reference file hoping one helps.

## Layout

| Path | Purpose |
|------|---------|
| [standards/](standards/) | Small always-on context forced by this `SKILL.md` (cross-cutting writing / safety / team norms) |
| [workflows/](workflows/) | Procedures **and presentation** (how to respond) for one classified intent. May load references when needed. |
| [references/](references/) | Composable topic **facts and links only** - no answer templates, no output shape. Reusable across workflows. |

## How to extend this skill later

When you (or an agent) add capabilities, keep this file as a thin router:

1. **Add a workflow** under `workflows/<intent-id>.md` with the full procedure **and** any presentation / output shape.
2. **Add a row** to **workflow routing** with a stable `intent-id`, clear triggers, and a relative link to that workflow.
3. **For knowledge topics**, add a file under `references/` (facts + links only) and a row in **reference routing** with clear include-when triggers.
4. **For cross-cutting norms** every path must obey, add a short file under `standards/` and a row in **Always-on standards**. Keep that list tiny.
5. **Keep announcements** as `Intent identified: <intent-id>` so demos and evals can assert on the prefix.

Do not grow this `SKILL.md` into domain procedures or answer templates. Put procedures and path-specific presentation in workflows; put facts in references; put forced shared norms in standards.

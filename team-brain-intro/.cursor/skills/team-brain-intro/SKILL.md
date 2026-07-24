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

Classify intent. Announce it. Load **only** the workflow (and references) that intent needs.

This top-level file has **no domain business logic**. It is the intent classification layer and the maintenance contract for growing the skill later.

## Progressive disclosure

Do **not** preload every workflow or reference file.

1. Classify the user prompt against the routing table.
2. Announce the classified intent with the invariant prefix below.
3. Read and follow **only** the linked workflow for that intent.
4. Load reference files only when the chosen workflow tells you to.

Skills beat dumping everything into always-on rules or mega-commands because the agent can keep context small until a path is chosen.

## Intent announcement (invariant)

Before doing any workflow work, the **first line** of your reply to the user must be exactly:

```text
Intent identified: <intent-id>
```

Where `<intent-id>` is one of the `Intent id` values from the routing table (for example `reference-answer` or `structured-calculator`).

Do not paraphrase this line. Do not add markdown bold around it. A blank line may follow, then the workflow output.

## Routing table

| Intent id | Triggers | Load |
|-----------|----------|------|
| `reference-answer` | Questions about Elasticsearch, OpenSearch, Harbor / Terminal-Bench evals, or other topics covered under `references/`; “how do we…”, “what is…”, “explain…” against those topics | [workflows/reference-answer.md](workflows/reference-answer.md) |
| `structured-calculator` | Arithmetic, evaluate expression, compute / calculate a numeric result | [workflows/structured-calculator.md](workflows/structured-calculator.md) |

### Classification rules

1. Prefer the **most specific** matching intent.
2. If the prompt is clearly arithmetic (numbers + operators, “calculate”, “what is 2+2”), choose `structured-calculator` even if a knowledge topic is mentioned in passing.
3. If the prompt is a knowledge question about a topic that has a file under [references/](references/), choose `reference-answer`.
4. If nothing matches, say so briefly, list the intents you *can* satisfy, and stop. Do not invent a third workflow in this intro skill.

## Layout

| Path | Purpose |
|------|---------|
| [workflows/](workflows/) | Runnable procedures for a single classified intent |
| [references/](references/) | Topic knowledge for `reference-answer` — thin summaries + canonical links |

## How to extend this skill later

When you (or an agent) add capabilities, keep this file as a thin router:

1. **Add a workflow** under `workflows/<intent-id>.md` with the full procedure and output shape.
2. **Add a row** to the routing table with a stable `intent-id`, clear triggers, and a relative link to that workflow.
3. **Optionally add references** under `references/` and link them from the workflow (not from this router), so unrelated intents never load them.
4. **Keep announcements** as `Intent identified: <intent-id>` so demos and evals can assert on the prefix.
5. Prefer **new versioned sample folders** in the parent repo (for example `team-brain-jira/`) for blog posts that introduce major new capabilities, so older posts still point at a simple starting point.

Do not grow this `SKILL.md` into a dump of domain procedures. Put procedures in workflows; put facts in references.

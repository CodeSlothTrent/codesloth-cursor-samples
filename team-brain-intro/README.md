# Team Brain Intro

Starter **team brain** skill for the Code Sloth post on intent classification and progressive disclosure in Cursor.

Open **this folder** as a Cursor project so the skill at `.cursor/skills/team-brain-intro/` is available.

## Intents

| Intent id | When to use |
|-----------|-------------|
| `reference-answer` | Knowledge questions answered from `references/` |
| `structured-calculator` | Arithmetic / expression requests with a fixed result block |

## Try it

```
/team-brain-intro What is an Elasticsearch keyword field?
/team-brain-intro How does OpenSearch flat_object differ from nested?
/team-brain-intro What is Harbor for agent evals?
/team-brain-intro Calculate (12 + 8) * 3
```

Each reply should start with `Intent identified: <id>` before the workflow runs.

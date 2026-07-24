# Workflow: reference-answer

## After announcement

The parent skill already required:

```text
Intent identified: reference-answer
```

Do not repeat that line here.

## Separation of concerns

- **Reference files** hold facts and canonical links only. They are composable - other workflows may load the same files when a step needs that context.
- **This workflow** holds presentation for the knowledge Q&A path: how to select sources, how to shape the reply, and what to do when nothing matches.
- Use the parent skill’s **reference routing** table to choose files - do not invent your own index, and do not open every file under `references/`.

## Steps

1. From the parent **reference routing** table, select every row whose “Include when…” matches the user question.
2. **Read only those reference files** (progressive disclosure).
3. Answer from the reference summaries first. Use linked Code Sloth posts and official docs as the deeper source of truth.
4. If multiple files were loaded (for example Elasticsearch vs OpenSearch), call out differences explicitly.
5. Cite sources inline (blog URLs and official doc URLs from the loaded reference file(s)).
6. Apply topic-specific presentation notes below when relevant.
7. If **no** reference routing row matches, say that this intro brain has no artifact for the question yet, list the topic ids you *do* cover (`elasticsearch`, `opensearch`, `harbor-evals`), and stop. Do not freestyle a long answer from general model knowledge as if it came from the skill’s references.

## Topic presentation notes

These are presentation hints for the reply - they must not live in reference files.

### When `elasticsearch` is loaded

- For keyword vs text, lead with the token / analysis distinction and point at the keyword deep dive post listed in the reference.
- For “should I use ES or OpenSearch?”, use the comparison post; do not invent a one-sided recommendation. Load `opensearch` as well when that question appears.

### When `opensearch` is loaded

- Prefer OpenSearch doc URLs when the user said OpenSearch; prefer Elastic URLs when they said Elasticsearch.
- For flat vs nested modeling, use the flat object / flattened posts and name the ES vs OS difference (`flattened` vs `flat_object`).

### When `harbor-evals` is loaded

- Frame Harbor as the runner / harness and Terminal-Bench as an example benchmark family - not the only thing you can evaluate.
- Do not invent Code Sloth Harbor blog URLs; this intro cache points at official docs/repos only.

## Answer shape

Use a short, readable answer:

1. One or two sentence direct answer.
2. Bullets for key facts pulled from the loaded reference(s).
3. A **Sources** list with the blog and official links you relied on.

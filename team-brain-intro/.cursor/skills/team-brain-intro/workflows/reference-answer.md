# Workflow: reference-answer

## After announcement

The parent skill already required:

```text
Intent identified: reference-answer
```

Do not repeat that line here.

## Steps

1. Identify which topic(s) under [../references/](../references/) best match the question. Start with the index below.
2. **Read only those reference files** (progressive disclosure — do not load unrelated topics).
3. Answer from the reference summaries first. Use linked Code Sloth posts and official docs as the deeper source of truth.
4. If the question spans multiple topics (for example Elasticsearch vs OpenSearch keyword behavior), load each relevant file and call out differences explicitly.
5. Cite sources inline (blog URLs and official doc URLs from the reference file).
6. If no reference file covers the question, say that this intro brain has no artifact for it yet, list the topics you *do* have, and stop. Do not freestyle a long answer from general model knowledge as if it came from the skill’s references.

## Reference index

| Topic | File |
|-------|------|
| Elasticsearch | [../references/elasticsearch.md](../references/elasticsearch.md) |
| OpenSearch | [../references/opensearch.md](../references/opensearch.md) |
| Harbor / Terminal-Bench agent evals | [../references/harbor-evals.md](../references/harbor-evals.md) |

## Answer shape

Use a short, readable answer:

1. One or two sentence direct answer.
2. Bullets for key facts pulled from the loaded reference(s).
3. A **Sources** list with the blog and official links you relied on.

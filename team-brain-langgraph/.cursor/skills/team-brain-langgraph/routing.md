# Dummy routing table

This file is the **source of truth** for classification. The hosting skill must not read it. The LangGraph classify node starts a nested Cursor agent whose job is to read this file and pick one intent.

## Workflow routing

Pick **one** intent.

| Intent id | Triggers |
|-----------|----------|
| `path-a` | Left, first, alpha, start, hello, greet, "path a", "path-a" |
| `path-b` | Right, second, bravo, end, goodbye, farewell, "path b", "path-b" |

### Classification rules

1. Prefer the **most specific** matching intent.
2. If the prompt clearly matches one row, choose that id.
3. If both rows could apply, prefer `path-a`.
4. If nothing matches, still choose the closer id. Do not invent a third intent.

## Announcement (invariant)

The classify agent's reply **must** start with this exact first line:

```text
Intent identified: <intent-id>
```

Where `<intent-id>` is `path-a` or `path-b`. Do not paraphrase this line. Do not wrap it in markdown bold. A blank line may follow, then one short sentence that names the choice.

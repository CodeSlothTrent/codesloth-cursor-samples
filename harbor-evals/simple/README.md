# Simple Harbor tasks (Parts 2–3)

Cheap, working-shaped tasks that assert the Team Brain intro invariant:

```text
Intent identified: <intent-id>
```

| Task | Intent under test | Output |
|------|-------------------|--------|
| [`team-brain-intent-smoke/`](team-brain-intent-smoke/) | `reference-answer` | `/app/output/reply.txt` |
| [`team-brain-calculator-smoke/`](team-brain-calculator-smoke/) | `structured-calculator` | `/app/output/reply.txt` |

Each task includes `fixtures/pass_reply.txt` and `fixtures/fail_reply.txt` so you can sanity-check the verifier without an LLM.

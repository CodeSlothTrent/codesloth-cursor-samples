# Simple Harbor tasks (Parts 2–3)

Cheap, working-shaped tasks that assert the Team Brain intro invariant:

```text
Intent identified: <intent-id>
```

| Task | Intent under test | Output |
|------|-------------------|--------|
| [`team-brain-intent/`](team-brain-intent/) | `reference-answer` | `/app/output/reply.txt` |
| [`team-brain-calculator/`](team-brain-calculator/) | `structured-calculator` | `/app/output/reply.txt` |

Each task includes `fixtures/pass_reply.txt` and `fixtures/fail_reply.txt` so you can sanity-check the verifier without an LLM.

`instruction.md` stays neutral: use the skill, answer the user message, write the user-facing reply to `/app/output/reply.txt`. Expected intent strings live in the verifier and fixtures - do not leak them into the agent-facing instruction.

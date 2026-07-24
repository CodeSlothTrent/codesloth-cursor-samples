# Team Brain intent eval (reference-answer)

Simulate a **Team Brain intro** style reply for the user question below. You do **not** need the real skill files in this container; produce a plausible reply that obeys the intent invariant.

## User question

> What is Harbor used for when evaluating AI agents?

## Requirements

1. Write your **entire** reply (all lines) to `/app/output/reply.txt`.
2. The **first line** of that file must be exactly:

   ```text
   Intent identified: reference-answer
   ```

   Do not paraphrase. Do not wrap that line in markdown bold. A blank line may follow, then the rest of the answer.
3. After the intent line, give a short knowledge-style answer (a couple of sentences or bullets is enough). Mention that Harbor is a framework for evaluating agents in container environments.
4. Create `/app/output/` if it does not exist.

## Success criteria

The verifier checks that `/app/output/reply.txt` exists and that its first non-empty semantics match the invariant prefix `Intent identified: reference-answer`.

# Team Brain intent eval (structured-calculator)

Simulate a **Team Brain intro** calculator-path reply. You do **not** need the real skill files; produce a reply that obeys the intent invariant and a minimal structured calculation shape.

## User question

> Calculate (12 + 8) * 3

## Requirements

1. Write your **entire** reply to `/app/output/reply.txt`.
2. The **first line** must be exactly:

   ```text
   Intent identified: structured-calculator
   ```

3. After that line, include a markdown `text` fence with this shape (values may vary if you normalize the expression differently, but `result` must be `60`):

   ````markdown
   ```text
   === STRUCTURED_CALCULATION ===
   expression: (12 + 8) * 3
   result: 60
   steps:
     - 12 + 8 = 20
     - 20 * 3 = 60
   === END_STRUCTURED_CALCULATION ===
   ```
   ````

4. Create `/app/output/` if needed.

## Success criteria

Verifier asserts the intent prefix and that `result: 60` appears in the reply.

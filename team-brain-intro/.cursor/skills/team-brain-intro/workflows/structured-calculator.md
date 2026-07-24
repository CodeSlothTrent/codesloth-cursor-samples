# Workflow: structured-calculator

## After announcement

The parent skill already required:

```text
Intent identified: structured-calculator
```

Do not repeat that line here.

## Purpose

A deliberately naive calculator path so intent classification is easy to see in demos. The output shape must look **nothing like** a reference-answer prose response.

## Steps

1. Extract the arithmetic expression from the user prompt.
2. Evaluate using ordinary operator precedence (`*`, `/` before `+`, `-`; respect parentheses).
3. Support integers and simple decimals only. Reject variables, units, and word problems that need domain knowledge - tell the user to rephrase as an expression.
4. Reply with **only** the structured block below (plus optional one-line note under it if the expression was invalid).

## Output shape (required)

When evaluation succeeds, output exactly this fenced block (fill the fields):

```text
=== STRUCTURED_CALCULATION ===
expression: <normalized expression>
result: <number>
steps:
  - <short step 1>
  - <short step 2>
=== END_STRUCTURED_CALCULATION ===
```

Rules:

- `expression` is the normalized math (for example `(12 + 8) * 3`).
- `result` is the final number only (no units, no words).
- `steps` lists intermediate evaluations in order (keep it short).
- Do not wrap the block in markdown code fences when responding to the user - emit the `===` lines as plain text so screenshots stay obvious.
- Do not add a Sources section. Do not load anything under `references/`. Do not consult reference routing.

# Workflow: edd-feature

## After announcement

The parent skill already required:

```text
Intent identified: edd-feature
```

Do not repeat that line here.

## Purpose

Add or harden a Team Brain capability with eval-driven development:

1. Interview the human about what matters in an eval.
2. Write a Harbor task under `../harbor-evals/simple/<task-name>/`.
3. Loop ≤5 times: change Team Brain → run the eval → fix until pass → report.

## Defaults (override only if the user names other paths)

| Role | Path |
|------|------|
| Team Brain working copy | `../team-brain-intro/` |
| Eval suite | `../harbor-evals/simple/` |
| Task under suite | `../harbor-evals/simple/<task-name>/` |

Load [references/harbor-edd.md](../references/harbor-edd.md) when scaffolding Harbor files or choosing CLI commands.

---

## Phase A — Interview

Ask the human the questions below. Prefer a short numbered list in chat. Wait for answers before writing the task unless the user already supplied them in the first message.

### Required interview questions

1. **Capability** — What should Team Brain do that it does not do (or does poorly) today? Name the intended `intent-id` if known.
2. **Success signals** — What observable outputs prove success? Examples: first line `Intent identified: <id>`, fixed envelope text, named topics listed, file written at a path.
3. **Deterministic vs judge** — Prefer a **deterministic** verifier (pytest / shell asserts on files or substrings) when checks are mechanical. Use an **LLM-as-judge** only when the human accepts softer criteria and cost. Record the choice.
4. **Failure modes** — What wrong behaviours must fail the eval? Examples: wrong intent announcement, freestyled knowledge, missing output file, wrong shape.
5. **Output file path** — If the agent under eval must write an artifact, what absolute-in-container or workspace-relative path does the verifier read? If none, say “none — assert on stdout / transcript markers only” and document how Harbor will still grade (usually a file the instruction requires).
6. **Task name** — Short kebab-case directory name under `harbor-evals/simple/` (for example `team-brain-list-topics`).
7. **Paths** — Confirm Team Brain path (`../team-brain-intro/` by default) and that evals go under `../harbor-evals/simple/`.

Do not skip question 3 or 5. Soft criteria without a judge plan, or “check the vibe” with no artifact, make a weak eval.

### Interview output shape

After answers are in, summarise once:

```text
=== EDD_BRIEF ===
capability: <one line>
intent-id: <id or TBD>
success-signals: <bullets condensed to one line each>
verifier: deterministic | llm-judge | hybrid
failure-modes: <short list>
artifact-path: <path or none>
task-name: <kebab-case>
team-brain-path: <path>
eval-path: ../harbor-evals/simple/<task-name>/
=== END_EDD_BRIEF ===
```

Then proceed to Phase B.

---

## Phase B — Write the Harbor eval

1. Ensure `../harbor-evals/simple/` exists.
2. Prefer scaffolding with Harbor when available:

   ```bash
   harbor task init <task-name>
   ```

   Run that from `../harbor-evals/simple/` (or move the generated folder there). If the CLI is missing, create the standard layout by hand from the Harbor task tutorial shape in `references/harbor-edd.md`.

3. Fill at least:

   | File | Role |
   |------|------|
   | `instruction.md` | Prompt the **agent under eval** sees. Invoke Team Brain behaviour clearly. Require the success artifact / markers. |
   | `task.toml` | Timeouts and metadata; tag with `team-brain`, `edd`, and the feature name. |
   | `environment/Dockerfile` | Image that can run the agent / mount the skill as the suite expects. |
   | `tests/test.sh` | Writes `1` or `0` (or a float) to `/logs/verifier/reward.txt`. |
   | `tests/test_outputs.py` (or equivalent) | Deterministic asserts matching the brief. |

4. Align the instruction with the verifier. Every success signal in the brief must map to a check. Every failure mode should be catchable when practical.
5. Prefer **deterministic** checks on:

   - Intent announcement line (`Intent identified: …`)
   - Required substrings / structured envelopes
   - Existence and content of the agreed **artifact path**

6. If the brief chose LLM-as-judge, document the rubric in `tests/` and keep at least one cheap deterministic check (for example “intent line present”) when possible.

7. Tell the human the task path and what will be asserted. Do not start the loop until the task files exist on disk.

---

## Phase C — Repair loop (max 5)

### Prerequisites gate

Re-check the parent skill’s prerequisites. If Harbor, Docker, keys, or Team Brain path are missing: **stop here**. Report blockers. Do not burn loop iterations on a fake run.

### Loop contract

```text
max_iterations = 5
iteration = 0
while iteration < 5:
  iteration += 1
  1. Change the Team Brain skill (or documented working copy) to address the brief / last failures.
  2. Run the Harbor eval for this task (see commands below).
  3. Read verifier output / reward / failed assertions.
  4. If pass (reward success per suite convention, typically 1): break and report.
  5. If fail: decide whether the skill is wrong, the tests are wrong, or both.
     - Fix skill when behaviour misses the brief.
     - Fix tests only when tests disagree with the agreed brief (flaky path, wrong string, over-strict assert).
     - Do not weaken tests just to get green.
  6. Continue until pass or iteration == 5.
```

### Run command (adapt to local agent adapter)

From a directory where Harbor can resolve the task path:

```bash
harbor run -p ../harbor-evals/simple/<task-name> -a <agent> -m <model>
```

Use the agent/model the human specified, or the one documented in `harbor-evals` Part 5 helpers when present. After a run, inspect with:

```bash
harbor view ./jobs
```

Read verifier logs and reward files for the trial. Prefer file evidence over memory.

### Per-iteration report (emit each time)

```text
=== EDD_ITERATION <n>/5 ===
changes: <one line summary of skill and/or test edits>
run: <harbor command used>
result: pass | fail
failures: <verifier highlights or "none">
next: <fix plan or "stop — passed" or "stop — budget exhausted">
=== END_EDD_ITERATION ===
```

### Stop conditions

| Condition | Action |
|-----------|--------|
| Verifier passes | Stop loop. Go to Phase D. |
| Iteration reaches 5 and still failing | Stop loop. Go to Phase D with `status: failed`. |
| Prerequisites missing mid-loop | Stop immediately. Do not invent pass. |

Do **not** start a sixth skill-edit + eval cycle in this workflow.

---

## Phase D — Final report

Use this shape:

```text
=== EDD_REPORT ===
status: passed | failed | blocked
task: ../harbor-evals/simple/<task-name>/
team-brain-path: <path>
iterations-used: <1-5 or 0 if blocked before loop>
verifier: deterministic | llm-judge | hybrid
summary: <2-4 short sentences>
remaining-failures: <none or bullets>
=== END_EDD_REPORT ===
```

Then add a short prose note only if needed (for example how to re-run the task). Apply the technical communication standard: lead with status, keep sentences short.

## Separation of concerns

- **This workflow** owns interview order, loop limits, and report shapes.
- **`references/harbor-edd.md`** owns Harbor facts and series slug links.
- **Team Brain** (`../team-brain-intro/`) is the system under change - edit its skill files, not this EDD skill, for feature behaviour (unless the user asked to change EDD itself).

---
name: team-brain-langgraph
description: >-
  Team brain LangGraph sample. The hosting agent prints a canned handoff
  paragraph, then runs a Python LangGraph process that classifies dummy
  path-a / path-b intents with a nested Cursor SDK agent. Use when the user
  invokes /team-brain-langgraph or asks to run the LangGraph team-brain router.
disable-model-invocation: true
---

# Team Brain LangGraph

You are the **launcher**, not the classifier.

Do **not** classify the user's intent. Do **not** read [routing.md](routing.md). Classification happens inside the graph.

## 1. Announce the handoff first

Before you run any command, send this exact paragraph to the user (plain text, no extra wrapping):

```text
Handing this prompt to the Team Brain LangGraph router.

This skill does not classify intent. Classification runs inside the graph.
A nested Cursor agent will read routing.md, announce the path, and a leaf node will announce itself.
```

## 2. Run the graph

From this sample's project root (`team-brain-langgraph/`), run:

```bash
./run.sh <the user's full prompt>
```

Pass the user's prompt as arguments to `./run.sh` so spaces survive. Use the Shell tool. Prefer `./run.sh` over invoking `python` yourself — the script creates `.venv` and installs dependencies on first run.

If `./run.sh` is not executable, run `chmod +x run.sh` once, then retry.

The process needs `CURSOR_API_KEY` in the environment. If it exits with a missing-key error, tell the user to export a key from https://cursor.com/dashboard/api and retry. Do not invent a classification yourself.

## 3. Relay graph stdout

When the process finishes, copy its stdout into your reply **verbatim**. Keep:

- `Intent identified: path-a` or `Intent identified: path-b`
- `=== NODE: path-a ===` or `=== NODE: path-b ===`

Do not summarise those lines away. Do not add a second classification of your own.

## What you must not do

1. Do not open `routing.md`.
2. Do not announce `Intent identified:` yourself.
3. Do not skip the canned handoff paragraph.
4. Do not ask the user to run a command in their own terminal. This skill is the entry point.

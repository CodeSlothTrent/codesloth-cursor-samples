"""LangGraph router invoked by the Team Brain LangGraph skill.

The hosting Cursor agent launches this process. The first node starts a nested
Cursor SDK agent (same project cwd, read-only tools) to classify path-a vs
path-b from routing.md. Leaf nodes only announce themselves.
"""

from __future__ import annotations

import argparse
import os
import re
import sys
from pathlib import Path
from typing import Literal, TypedDict

from langgraph.graph import END, START, StateGraph

SAMPLE_ROOT = Path(__file__).resolve().parent
ROUTING_FILE = (
    SAMPLE_ROOT / ".cursor" / "skills" / "team-brain-langgraph" / "routing.md"
)
INTENT_RE = re.compile(
    r"^Intent identified:\s*(path-a|path-b)\s*$",
    re.MULTILINE,
)
IntentId = Literal["path-a", "path-b", "unknown"]


class GraphState(TypedDict):
    prompt: str
    intent: IntentId
    classify_text: str


def _emit(text: str) -> None:
    print(text, flush=True)


def parse_intent(classify_text: str) -> IntentId:
    match = INTENT_RE.search(classify_text)
    if match is None:
        return "unknown"
    return match.group(1)  # type: ignore[return-value]


def classify_node(state: GraphState) -> dict[str, str]:
    from cursor_sdk import Agent, AgentOptions, CursorAgentError, LocalAgentOptions

    api_key = os.environ.get("CURSOR_API_KEY", "").strip()
    if not api_key:
        _emit(
            "error: CURSOR_API_KEY is not set. "
            "Export a user or service-account key from https://cursor.com/dashboard/api"
        )
        return {"intent": "unknown", "classify_text": ""}

    if not ROUTING_FILE.is_file():
        _emit(f"error: routing table missing: {ROUTING_FILE}")
        return {"intent": "unknown", "classify_text": ""}

    model = os.environ.get("CURSOR_MODEL", "composer-2.5").strip() or "composer-2.5"
    classify_prompt = f"""You are the classify node of a LangGraph router. You are not the hosting Team Brain skill.

1. Read this file: {ROUTING_FILE}
2. Classify the user prompt into exactly one intent from that table: path-a or path-b.
3. Your reply MUST start with this exact first line:
Intent identified: <intent-id>
4. After a blank line, write one short sentence that names the choice.
5. Do not invoke any Cursor skills.
6. Do not run shell commands.
7. Do not start Python or LangGraph.
8. Do not edit files.

User prompt:
{state["prompt"]}
"""

    _emit("=== NODE: classify (nested Cursor agent) ===")
    _emit("")

    classify_text = ""
    try:
        with Agent.create(
            AgentOptions(
                model=model,
                api_key=api_key,
                name="team-brain-langgraph-classify",
                tools=["read"],
                local=LocalAgentOptions(cwd=str(SAMPLE_ROOT)),
            )
        ) as agent:
            run = agent.send(classify_prompt)
            for message in run.messages():
                if message.type == "assistant":
                    for block in message.message.content:
                        if getattr(block, "type", None) == "text":
                            chunk = getattr(block, "text", "") or ""
                            classify_text += chunk
                            print(chunk, end="", flush=True)
                elif message.type == "tool_call":
                    name = getattr(message, "name", "tool")
                    status = getattr(message, "status", "")
                    _emit(f"[classify tool] {name}: {status}")
            result = run.wait()
            if result.result and result.result not in classify_text:
                classify_text = result.result
                _emit(result.result)
            if result.status != "finished":
                _emit(f"\nerror: nested classify run status={result.status}")
    except CursorAgentError as err:
        _emit(f"error: nested Cursor agent failed to start: {err}")
        return {"intent": "unknown", "classify_text": classify_text}

    if not classify_text.endswith("\n"):
        _emit("")

    intent = parse_intent(classify_text)
    if intent == "unknown":
        _emit("error: classify node did not announce Intent identified: path-a|path-b")
    return {"intent": intent, "classify_text": classify_text}


def path_a_node(state: GraphState) -> dict[str, str]:
    _emit("")
    _emit("=== NODE: path-a ===")
    _emit("")
    _emit(
        "LangGraph routed here because the classify node announced path-a. "
        "This leaf does no domain work. It only announces that you are on path-a."
    )
    return {}


def path_b_node(state: GraphState) -> dict[str, str]:
    _emit("")
    _emit("=== NODE: path-b ===")
    _emit("")
    _emit(
        "LangGraph routed here because the classify node announced path-b. "
        "This leaf does no domain work. It only announces that you are on path-b."
    )
    return {}


def unknown_node(state: GraphState) -> dict[str, str]:
    _emit("")
    _emit("=== NODE: unknown ===")
    _emit("")
    _emit(
        "LangGraph could not parse a path-a or path-b announcement from the "
        "classify node. No dummy leaf ran."
    )
    return {}


def route(state: GraphState) -> IntentId:
    return state["intent"]


def build_graph():
    graph = StateGraph(GraphState)
    graph.add_node("classify", classify_node)
    graph.add_node("path-a", path_a_node)
    graph.add_node("path-b", path_b_node)
    graph.add_node("unknown", unknown_node)
    graph.add_edge(START, "classify")
    graph.add_conditional_edges(
        "classify",
        route,
        {"path-a": "path-a", "path-b": "path-b", "unknown": "unknown"},
    )
    graph.add_edge("path-a", END)
    graph.add_edge("path-b", END)
    graph.add_edge("unknown", END)
    return graph.compile()


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Team Brain LangGraph router (invoked by the skill, not by you)."
    )
    parser.add_argument(
        "--prompt",
        required=True,
        help="User prompt to classify into path-a or path-b",
    )
    args = parser.parse_args(argv)

    prompt = args.prompt.strip()
    if not prompt:
        print("error: empty prompt", file=sys.stderr)
        return 2

    app = build_graph()
    app.invoke({"prompt": prompt, "intent": "unknown", "classify_text": ""})
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

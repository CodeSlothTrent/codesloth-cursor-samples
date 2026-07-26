"""Deterministic checks for Team Brain intent announcement.

Harbor runs these via tests/test.sh (pytest). A pass writes reward 1; a fail writes 0.
"""

from pathlib import Path  # pathlib.Path = filesystem path helper in the standard library

# Absolute path inside the Harbor sandbox where the agent must write its reply.
REPLY = Path("/app/output/reply.txt")
# Exact first-line string the skill contract requires (kept out of instruction.md).
EXPECTED_INTENT = "Intent identified: reference-answer"


def test_reply_file_exists():
    # Fail early if the agent never created the output file.
    assert REPLY.is_file(), f"Missing agent output: {REPLY}"


def test_first_line_is_intent_identified_reference_answer():
    # Read the whole reply as UTF-8 text.
    text = REPLY.read_text(encoding="utf-8")
    assert text.strip(), "reply.txt is empty"
    # First line only - that is where Team Brain announces the intent id.
    first_line = text.splitlines()[0]
    assert first_line == EXPECTED_INTENT, (
        f"Expected first line {EXPECTED_INTENT!r}, got {first_line!r}"
    )


def test_reply_has_body_after_intent():
    # Split into lines, then keep non-empty lines after the intent announcement.
    lines = REPLY.read_text(encoding="utf-8").splitlines()
    body = [ln for ln in lines[1:] if ln.strip()]
    assert body, "Expected at least one non-empty line after the intent announcement"

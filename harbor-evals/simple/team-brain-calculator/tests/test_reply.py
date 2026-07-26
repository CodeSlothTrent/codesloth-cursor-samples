"""Deterministic checks for Team Brain calculator intent + result.

Harbor runs these via tests/test.sh (pytest). A pass writes reward 1; a fail writes 0.
"""

from pathlib import Path  # pathlib.Path = filesystem path helper in the standard library

# Absolute path inside the Harbor sandbox where the agent must write its reply.
REPLY = Path("/app/output/reply.txt")
# Exact first-line string this task's skill contract requires.
EXPECTED_INTENT = "Intent identified: structured-calculator"


def test_reply_file_exists():
    # Fail early if the agent never created the output file.
    assert REPLY.is_file(), f"Missing agent output: {REPLY}"


def test_first_line_is_structured_calculator_intent():
    # Read the whole reply as UTF-8 text.
    text = REPLY.read_text(encoding="utf-8")
    assert text.strip(), "reply.txt is empty"
    # First line only - where Team Brain announces the intent id.
    first_line = text.splitlines()[0]
    assert first_line == EXPECTED_INTENT, (
        f"Expected first line {EXPECTED_INTENT!r}, got {first_line!r}"
    )


def test_result_is_sixty():
    # (12 + 8) * 3 = 60 - the structured block must include this exact marker.
    text = REPLY.read_text(encoding="utf-8")
    assert "result: 60" in text, "Expected 'result: 60' in structured calculation block"


def test_structured_markers_present():
    # Skill output should wrap the calculation in these begin/end markers.
    text = REPLY.read_text(encoding="utf-8")
    assert "=== STRUCTURED_CALCULATION ===" in text
    assert "=== END_STRUCTURED_CALCULATION ===" in text

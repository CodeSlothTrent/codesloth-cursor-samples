"""Deterministic checks for Team Brain calculator intent + result."""

from pathlib import Path

REPLY = Path("/app/output/reply.txt")
EXPECTED_INTENT = "Intent identified: structured-calculator"


def test_reply_file_exists():
    assert REPLY.is_file(), f"Missing agent output: {REPLY}"


def test_first_line_is_structured_calculator_intent():
    text = REPLY.read_text(encoding="utf-8")
    assert text.strip(), "reply.txt is empty"
    first_line = text.splitlines()[0]
    assert first_line == EXPECTED_INTENT, (
        f"Expected first line {EXPECTED_INTENT!r}, got {first_line!r}"
    )


def test_result_is_sixty():
    text = REPLY.read_text(encoding="utf-8")
    assert "result: 60" in text, "Expected 'result: 60' in structured calculation block"


def test_structured_markers_present():
    text = REPLY.read_text(encoding="utf-8")
    assert "=== STRUCTURED_CALCULATION ===" in text
    assert "=== END_STRUCTURED_CALCULATION ===" in text

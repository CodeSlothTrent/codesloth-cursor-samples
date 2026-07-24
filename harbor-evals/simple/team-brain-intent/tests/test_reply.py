"""Deterministic checks for Team Brain intent announcement."""

from pathlib import Path

REPLY = Path("/app/output/reply.txt")
EXPECTED_INTENT = "Intent identified: reference-answer"


def test_reply_file_exists():
    assert REPLY.is_file(), f"Missing agent output: {REPLY}"


def test_first_line_is_intent_identified_reference_answer():
    text = REPLY.read_text(encoding="utf-8")
    assert text.strip(), "reply.txt is empty"
    first_line = text.splitlines()[0]
    assert first_line == EXPECTED_INTENT, (
        f"Expected first line {EXPECTED_INTENT!r}, got {first_line!r}"
    )


def test_reply_has_body_after_intent():
    lines = REPLY.read_text(encoding="utf-8").splitlines()
    body = [ln for ln in lines[1:] if ln.strip()]
    assert body, "Expected at least one non-empty line after the intent announcement"

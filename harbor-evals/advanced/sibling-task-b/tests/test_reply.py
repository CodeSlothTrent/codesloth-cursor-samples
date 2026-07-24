from pathlib import Path

REPLY = Path("/app/output/reply.txt")


def test_calculator_intent_and_result():
    assert REPLY.is_file()
    text = REPLY.read_text(encoding="utf-8")
    assert text.splitlines()[0] == "Intent identified: structured-calculator"
    assert "result: 56" in text

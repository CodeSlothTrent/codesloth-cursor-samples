from pathlib import Path

REPLY = Path("/app/output/reply.txt")


def test_intent_and_keywords():
    assert REPLY.is_file()
    text = REPLY.read_text(encoding="utf-8")
    assert text.splitlines()[0] == "Intent identified: reference-answer"
    lower = text.lower()
    for needle in ("task.toml", "instruction.md", "environment", "tests"):
        assert needle in lower, f"missing mention of {needle}"

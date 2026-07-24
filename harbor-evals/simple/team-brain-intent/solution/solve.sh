#!/bin/bash
# Oracle solution: install the known-good fixture as the agent output.
set -euo pipefail

mkdir -p /app/output
# Harbor copies solution/ to /oracle/ (or runs from task dir). Prefer /tests sibling fixtures via task layout.
# When run via `harbor tasks test --solution`, this script executes in the sandbox.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "${SCRIPT_DIR}/../fixtures/pass_reply.txt" ]; then
  cp "${SCRIPT_DIR}/../fixtures/pass_reply.txt" /app/output/reply.txt
elif [ -f /oracle/../fixtures/pass_reply.txt ]; then
  cp /oracle/../fixtures/pass_reply.txt /app/output/reply.txt
else
  # Inline fallback so oracle still works if fixtures are not mounted
  cat > /app/output/reply.txt << 'EOF'
Intent identified: reference-answer

Harbor is a framework for evaluating and optimizing AI agents in container environments. It grew out of lessons from Terminal-Bench and focuses on modular tasks, environments, and agents.

- Tasks ship with instruction.md, a Dockerfile sandbox, and a verifier that writes a reward.
- Use it to assert skill behavior (for example an intent announcement prefix) reproducibly.
EOF
fi

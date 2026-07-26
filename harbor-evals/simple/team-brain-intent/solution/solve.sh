#!/bin/bash
# Oracle solution: put a known-good reply where a successful agent would write it.
# Used when you run Harbor with -a oracle (or harbor tasks test --solution).
# No model is called - this only proves the verifier and paths work.

# -e exit on error; -u error on unset vars; -o pipefail fail if any pipe stage fails.
set -euo pipefail

# Ensure the output directory exists before writing reply.txt.
mkdir -p /app/output

# Directory containing this script (usually solution/ inside the task).
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Prefer the checked-in pass fixture next to solution/ (../fixtures/...).
if [ -f "${SCRIPT_DIR}/../fixtures/pass_reply.txt" ]; then
  cp "${SCRIPT_DIR}/../fixtures/pass_reply.txt" /app/output/reply.txt
# Fallback path some Harbor layouts use when solution/ is copied under /oracle/.
elif [ -f /oracle/../fixtures/pass_reply.txt ]; then
  cp /oracle/../fixtures/pass_reply.txt /app/output/reply.txt
else
  # Last resort: write a minimal passing reply inline if fixtures are missing.
  cat > /app/output/reply.txt << 'EOF'
Intent identified: reference-answer

Harbor is a framework for evaluating and optimizing AI agents in container environments. It grew out of lessons from Terminal-Bench and focuses on modular tasks, environments, and agents.

- Tasks ship with instruction.md, a Dockerfile sandbox, and a verifier that writes a reward.
- Use it to assert skill behavior (for example an intent announcement prefix) reproducibly.
EOF
fi

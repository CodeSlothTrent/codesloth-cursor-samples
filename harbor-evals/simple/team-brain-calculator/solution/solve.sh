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
else
  # Last resort: write a minimal passing reply inline if the fixture file is missing.
  cat > /app/output/reply.txt << 'EOF'
Intent identified: structured-calculator

```text
=== STRUCTURED_CALCULATION ===
expression: (12 + 8) * 3
result: 60
steps:
  - 12 + 8 = 20
  - 20 * 3 = 60
=== END_STRUCTURED_CALCULATION ===
```
EOF
fi

#!/bin/bash
set -euo pipefail

mkdir -p /app/output
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "${SCRIPT_DIR}/../fixtures/pass_reply.txt" ]; then
  cp "${SCRIPT_DIR}/../fixtures/pass_reply.txt" /app/output/reply.txt
else
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

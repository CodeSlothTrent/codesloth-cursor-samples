#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

if [[ -f .env ]]; then
  set -a
  # shellcheck disable=SC1091
  source .env
  set +a
fi

if [[ ! -x .venv/bin/python ]]; then
  python3 -m venv .venv
  .venv/bin/pip install -r requirements.txt
fi

if [[ $# -eq 0 ]]; then
  echo "usage: ./run.sh <user prompt>" >&2
  exit 2
fi

exec .venv/bin/python -u graph.py --prompt "$*"

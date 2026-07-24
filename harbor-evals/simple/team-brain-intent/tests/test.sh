#!/bin/bash
# Harbor verifier: write 0|1 to /logs/verifier/reward.txt
set -u

mkdir -p /logs/verifier

cd /tests
if python3 -m pytest test_reply.py -v --tb=short; then
  echo "1" > /logs/verifier/reward.txt
  echo "Success: intent eval passed"
  exit 0
else
  echo "0" > /logs/verifier/reward.txt
  echo "Failure: intent eval failed"
  exit 1
fi

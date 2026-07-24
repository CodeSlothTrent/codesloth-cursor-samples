#!/bin/bash
set -u

mkdir -p /logs/verifier

cd /tests
if python3 -m pytest test_reply.py -v --tb=short; then
  echo "1" > /logs/verifier/reward.txt
  echo "Success: calculator smoke passed"
  exit 0
else
  echo "0" > /logs/verifier/reward.txt
  echo "Failure: calculator smoke failed"
  exit 1
fi

#!/bin/bash
# Harbor verifier entrypoint for this task.
# Harbor runs this script after the agent (or Oracle) finishes.
# It must write 0 or 1 to /logs/verifier/reward.txt so the trial gets a score.

# -u: treat unset variables as errors (helps catch typos in paths).
set -u

# Create the directory Harbor expects for verifier outputs (reward, logs).
mkdir -p /logs/verifier

# Harbor uploads this task's tests/ folder to /tests in the sandbox.
cd /tests

# Run pytest on the Python checks. -v = verbose; --tb=short = shorter tracebacks.
if python3 -m pytest test_reply.py -v --tb=short; then
  # All asserts passed -> reward 1 (success).
  echo "1" > /logs/verifier/reward.txt
  echo "Success: calculator eval passed"
  exit 0
else
  # Any assert failed -> reward 0 (failure). Still write the file so Harbor can read it.
  echo "0" > /logs/verifier/reward.txt
  echo "Failure: calculator eval failed"
  exit 1
fi

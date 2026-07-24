# Sibling task B — pattern demo (needs codesloth-harbor-base:local)

Same base image as sibling-task-a; different instruction / verifier.

Write a Team Brain calculator-style reply for:

> What is 7 * 8?

## Requirements

1. Full reply → `/app/output/reply.txt`
2. First line exactly: `Intent identified: structured-calculator`
3. Include `result: 56` somewhere in the file

Build `codesloth-harbor-base:local` first (see `../README.md`).

# Sibling task A (needs codesloth-harbor-base:local)

Use the Team Brain skill with the user message below.

Write everything you would show the user to `/app/output/reply.txt` (create `/app/output/` if it does not exist). Do not only print to stdout.

## User message

> Explain what a Harbor task directory contains.

This task’s Dockerfile `FROM`s the shared base image. Build the base before Harbor can build this environment (see `../base-image/` and `../README.md`).

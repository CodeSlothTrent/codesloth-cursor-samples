# Sibling task A — pattern demo (needs codesloth-harbor-base:local)

Write a Team Brain–style reply for:

> Explain what a Harbor task directory contains.

## Requirements

1. Full reply → `/app/output/reply.txt`
2. First line exactly: `Intent identified: reference-answer`
3. Mention at least: `task.toml`, `instruction.md`, `environment/`, `tests/`

This task’s Dockerfile `FROM`s the shared base image. Build the base before Harbor can build this environment (see `../base-image/` and `../README.md`).

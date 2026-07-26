# Shared base image for sibling Harbor tasks
#
# Pattern: build once with a shallow clone pinned to a commit SHA (or COPY of
# a pinned tree), tag it, then have sibling task Dockerfiles
# `FROM codesloth-harbor-base:local`.
#
# This keeps per-task images thin and avoids re-cloning large repos on every
# Harbor task build. Adjust REPO_URL / REPO_SHA for your own samples repo.
#
# Build:
#   docker build -t codesloth-harbor-base:local .
#   # or, when uncommenting the clone block:
#   docker build -t codesloth-harbor-base:local \
#     --build-arg REPO_SHA=<full-commit-sha> .
#
# Notes:
# - Pin REPO_SHA (a commit hash), not a branch name. Same SHA -> Docker can
#   reuse the clone layer. Bump the SHA when you want a new tree (that ARG
#   change invalidates the layer on purpose).
# - Branch names like `main` make cache hits accidental: the layer may stick
#   while the remote tip moves.
# - Do not bake API keys into this image.
# - Harbor task environments that FROM this image still need their own
#   WORKDIR, /app/output, and verifier deps (or inherit them here).

FROM python:3.12-slim

WORKDIR /opt/base

RUN apt-get update && apt-get install -y --no-install-recommends git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Example: shallow clone pinned to a commit (replace URL + SHA for your repo).
# Disabled by default so `docker build` stays cheap / offline-friendly when
# you only want the layer layout - uncomment the ARG/RUN lines to use it.
#
# This is a manual clone (same end state as `git clone`, built in steps):
# init an empty repo, add the remote, fetch one commit, then check it out.
# That lets you pin a SHA with --depth 1. A plain
# `git clone --depth 1 --branch main` pins a branch tip instead, which is a
# poor Docker cache key (remote `main` can move while the layer stays cached).
#
# ARG REPO_URL=https://github.com/example/your-samples.git
#   ^ Build-time remote URL. Override with --build-arg REPO_URL=...
#     Not set as a runtime ENV in the finished image.
#
# ARG REPO_SHA=0123456789abcdef0123456789abcdef01234567
#   ^ Full commit hash to fetch. Same SHA -> Docker can reuse this layer.
#     Bump SHA (or pass --build-arg REPO_SHA=...) when you want a new tree.
#
# RUN mkdir -p /opt/base/repo \
#   ^ Create the checkout directory. One RUN = one image layer.
#     && git -C /opt/base/repo init \
#   ^ Empty Git repo in that directory (-C runs as if cwd were the path).
#     && git -C /opt/base/repo remote add origin "${REPO_URL}" \
#   ^ Attach the remote; nothing downloaded yet.
#     && git -C /opt/base/repo fetch --depth 1 origin "${REPO_SHA}" \
#   ^ Download only that commit (shallow), not full history / not "current main".
#     && git -C /opt/base/repo checkout FETCH_HEAD
#   ^ Make the working tree match the commit just fetched (FETCH_HEAD).

# Placeholder tree so siblings have something to COPY/RUN against without network.
RUN mkdir -p /opt/base/repo \
    && printf '%s\n' '# placeholder - replace with SHA-pinned shallow clone' > /opt/base/repo/README.md

# Common verifier tooling for all sibling tasks
RUN pip install --no-cache-dir pytest==8.3.5 \
    && mkdir -p /app/output /logs/verifier /logs/agent

ENV CODESLOTH_HARBOR_BASE=1
WORKDIR /app
CMD ["bash"]

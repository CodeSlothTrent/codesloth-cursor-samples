# Shared base image for sibling Harbor tasks
#
# Pattern: build once with a shallow clone (or COPY of a pinned tree), tag it,
# then have sibling task Dockerfiles `FROM codesloth-harbor-base:local`.
#
# This keeps per-task images thin and avoids re-cloning large repos on every
# Harbor task build. Adjust REMOTE / REF for your own samples repo.
#
# Build:
#   docker build -t codesloth-harbor-base:local .
#
# Notes:
# - Prefer shallow clone (--depth 1) for speed; pin a commit SHA in production.
# - Do not bake API keys into this image.
# - Harbor task environments that FROM this image still need their own
#   WORKDIR, /app/output, and verifier deps (or inherit them here).

FROM python:3.12-slim

WORKDIR /opt/base

RUN apt-get update && apt-get install -y --no-install-recommends git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Example shallow clone of a public samples tree (replace with your repo).
# Disabled by default so `docker build` stays cheap / offline-friendly when
# you only want the layer layout — uncomment to exercise the clone pattern:
#
# ARG REPO_URL=https://github.com/example/your-samples.git
# ARG REPO_REF=main
# RUN git clone --depth 1 --branch "${REPO_REF}" "${REPO_URL}" /opt/base/repo

# Placeholder tree so siblings have something to COPY/RUN against without network.
RUN mkdir -p /opt/base/repo \
    && printf '%s\n' '# placeholder — replace with shallow clone' > /opt/base/repo/README.md

# Common verifier tooling for all sibling tasks
RUN pip install --no-cache-dir pytest==8.3.5 \
    && mkdir -p /app/output /logs/verifier /logs/agent

ENV CODESLOTH_HARBOR_BASE=1
WORKDIR /app
CMD ["bash"]

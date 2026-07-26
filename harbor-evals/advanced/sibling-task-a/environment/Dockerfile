# Generated header - edit base tag here, then re-run scripts/generate_common.sh
# Requires: docker build -t codesloth-harbor-base:local ../base-image
# FROM = start from the shared base image (already has common tools / placeholder repo).
FROM codesloth-harbor-base:local

# --- task-specific layers ---
# WORKDIR = default directory for later RUN/CMD and for the agent process.
WORKDIR /app
# Optional: surface the placeholder repo from the base image at /app/repo.
# mkdir -p creates output + verifier log dirs Harbor / the task expect.
RUN ln -sfn /opt/base/repo /app/repo \
    && mkdir -p /app/output /logs/verifier
# Default process if someone starts the container by hand (Harbor overrides as needed).
CMD ["bash"]

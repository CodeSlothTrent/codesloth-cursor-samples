# Generated header — edit base tag here, then re-run scripts/generate_common.sh
# Requires: docker build -t codesloth-harbor-base:local ../base-image
FROM codesloth-harbor-base:local

# --- task-specific layers ---
WORKDIR /app
# Optional: surface the placeholder repo from the base image
RUN ln -sfn /opt/base/repo /app/repo \
    && mkdir -p /app/output /logs/verifier
CMD ["bash"]

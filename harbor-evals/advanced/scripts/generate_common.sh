#!/usr/bin/env bash
# Copy shared task.toml template + Dockerfile FROM-snippet into sibling task dirs.
# Run from anywhere; resolves paths relative to this script.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE_TOML="${ROOT}/scripts/templates/task.toml.common"
DOCKER_SNIPPET="${ROOT}/scripts/templates/Dockerfile.from-base.snippet"

# Sibling task dirs = immediate children of advanced/ that contain task.toml
# (skips base-image/, scripts/, and other helpers).
TASKS=()
shopt -s nullglob
for d in "${ROOT}"/*/; do
  if [[ -f "${d}task.toml" ]]; then
    TASKS+=("$(basename "${d%/}")")
  fi
done
shopt -u nullglob

if ((${#TASKS[@]} == 0)); then
  echo "No sibling tasks found under ${ROOT} (expected */task.toml)." >&2
  exit 1
fi

# Stable order for reproducible codegen.
IFS=$'\n' TASKS=($(printf '%s\n' "${TASKS[@]}" | LC_ALL=C sort))
unset IFS

if [[ ! -f "${TEMPLATE_TOML}" ]]; then
  echo "missing template: ${TEMPLATE_TOML}" >&2
  exit 1
fi
if [[ ! -f "${DOCKER_SNIPPET}" ]]; then
  echo "missing snippet: ${DOCKER_SNIPPET}" >&2
  exit 1
fi

for task in "${TASKS[@]}"; do
  dest_toml="${ROOT}/${task}/task.toml"
  dest_docker="${ROOT}/${task}/environment/Dockerfile"
  mkdir -p "${ROOT}/${task}/environment"

  # Preserve task-specific metadata block if present below a marker; otherwise overwrite.
  {
    cat "${TEMPLATE_TOML}"
    echo ""
    echo "# --- task-specific overrides may follow (managed outside generate_common) ---"
    if [[ -f "${dest_toml}" ]] && grep -q '^# --- task-specific' "${dest_toml}" 2>/dev/null; then
      # Keep lines after the marker from the existing file
      awk 'p; /^# --- task-specific/{p=1}' "${dest_toml}"
    else
      echo ""
      echo "[metadata]"
      echo "category = \"skill-eval\""
      echo "tags = [\"advanced\", \"${task}\"]"
    fi
  } > "${dest_toml}.tmp"
  mv "${dest_toml}.tmp" "${dest_toml}"

  {
    cat "${DOCKER_SNIPPET}"
    echo ""
    echo "# --- task-specific layers ---"
    if [[ -f "${dest_docker}" ]] && grep -q '^# --- task-specific layers ---' "${dest_docker}" 2>/dev/null; then
      awk 'p; /^# --- task-specific layers ---/{p=1}' "${dest_docker}"
    else
      echo "WORKDIR /app"
      echo "RUN mkdir -p /app/output /logs/verifier"
      echo "CMD [\"bash\"]"
    fi
  } > "${dest_docker}.tmp"
  mv "${dest_docker}.tmp" "${dest_docker}"

  echo "updated ${task}"
done

echo "done. Rebuild base image before Harbor runs: docker build -t codesloth-harbor-base:local ${ROOT}/base-image"

#!/usr/bin/env bash
# Bring the Harbor eval suite to a known-good local state, then run trials.
#
# Once you need shared base images, skill injection, and a task × model matrix,
# use this script (or CI that does the same steps) as the normal entry point.
# Ad-hoc `docker build` + hand-picked `harbor run` lines drift from what the
# suite expects.
#
# Usage (from anywhere):
#   export CURSOR_API_KEY=...
#   export SKILL_DIR=/absolute/path/to/.cursor/skills/team-brain-intro
#   ./scripts/run_matrix.sh
#
# Optional env:
#   AGENT=cursor-cli
#   INCLUDE_ADVANCED=1   # default 1; set 0 for simple tasks only
#   N_CONCURRENT=1

# Fail fast: exit on error (-e), treat unset vars as errors (-u), fail pipelines (-o pipefail).
set -euo pipefail

# Absolute path to harbor-evals/ (parent of scripts/), no matter where you launched from.
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Harbor agent adapter name (override with AGENT=... in the environment).
AGENT="${AGENT:-cursor-cli}"
# 1 = also build advanced base image and run sibling tasks; 0 = simple tasks only.
INCLUDE_ADVANCED="${INCLUDE_ADVANCED:-1}"
# How many Harbor trials to run in parallel (keep low until you know cost/latency).
N_CONCURRENT="${N_CONCURRENT:-1}"
# Docker image name:tag that sibling Dockerfiles FROM.
BASE_TAG="${BASE_TAG:-codesloth-harbor-base:local}"

# Models to try. Replace with ids your agent accepts.
MODELS=(
  "cursor/auto"
  # "anthropic/claude-haiku-4-5"
)

# Exit with a clear message if a required binary is missing from PATH.
need_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 1
  fi
}

echo "== Prerequisites =="
need_cmd harbor # Harbor CLI (e.g. from: uv tool install harbor)
need_cmd docker # Docker Engine / Desktop, used to build the shared base image
# Abort if CURSOR_API_KEY is unset or empty (needed for cursor-cli agent runs).
: "${CURSOR_API_KEY:?export CURSOR_API_KEY before running}"
# Skill directory only - not the harbor-evals task tree (fixtures/tests stay out).
: "${SKILL_DIR:?export SKILL_DIR to your Team Brain skill path}"
if [[ ! -d "${SKILL_DIR}" ]]; then
  echo "SKILL_DIR is not a directory: ${SKILL_DIR}" >&2
  exit 1
fi

# Collect Harbor task dirs under a parent (immediate children that contain task.toml).
# Skips helpers like advanced/base-image and advanced/scripts automatically.
discover_tasks() {
  local parent="$1"
  local d
  local -a found=()
  shopt -s nullglob
  for d in "${parent}"/*/; do
    if [[ -f "${d}task.toml" ]]; then
      found+=("${d%/}")
    fi
  done
  shopt -u nullglob
  if ((${#found[@]} == 0)); then
    return 0
  fi
  # Stable order so matrix runs are reproducible across machines.
  printf '%s\n' "${found[@]}" | LC_ALL=C sort
}

# Task directories Harbor will run (each must contain task.toml, instruction.md, etc.).
TASKS=()
while IFS= read -r task; do
  [[ -n "$task" ]] || continue
  TASKS+=("$task")
done < <(discover_tasks "$ROOT/simple")

if ((${#TASKS[@]} == 0)); then
  echo "No simple tasks found under ${ROOT}/simple (expected */task.toml)." >&2
  exit 1
fi

if [[ "${INCLUDE_ADVANCED}" == "1" ]]; then
  echo "== Desired state: advanced shared snippets + base image =="
  # Refresh shared task.toml / Dockerfile headers for sibling tasks when the script exists.
  if [[ -x "$ROOT/advanced/scripts/generate_common.sh" ]]; then
    "$ROOT/advanced/scripts/generate_common.sh"
  fi
  # Build (or rebuild) the shared base image siblings expect via FROM.
  # -t names the image; the path is the build context (folder with the Dockerfile).
  docker build -t "${BASE_TAG}" "$ROOT/advanced/base-image"
  # Append every advanced sibling that looks like a Harbor task.
  while IFS= read -r task; do
    [[ -n "$task" ]] || continue
    TASKS+=("$task")
  done < <(discover_tasks "$ROOT/advanced")
fi

echo "== Harbor trials (${#TASKS[@]} task(s)) =="
for model in "${MODELS[@]}"; do
  for task in "${TASKS[@]}"; do
    echo "=== $(basename "$task") @ ${model} ==="
    # -p  path to one Harbor task directory
    # -a  which agent adapter to run (oracle skips the model)
    # -m  model id for that agent
    # --skill  upload this skill dir into the agent skills location (not fixtures/)
    # --ae  pass an env var into the agent environment (API key here)
    # --n-concurrent  parallel trial limit for this invocation
    harbor run \
      -p "$task" \
      -a "$AGENT" \
      -m "$model" \
      --skill "${SKILL_DIR}" \
      --ae "CURSOR_API_KEY=${CURSOR_API_KEY}" \
      --n-concurrent "${N_CONCURRENT}"
  done
done

# Harbor writes job/trial folders under ./jobs by default; open the local viewer.
echo "Done. Inspect with: harbor view ${ROOT}/jobs"

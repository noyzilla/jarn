#!/bin/sh
# Initialize a new project with the complete Jarn AI-Driven Software Development Blueprint.
# Pure basic shell (POSIX sh) with zero external runtime dependencies.
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/init.sh | sh
#   curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/init.sh | sh -s -- <project-directory>

set -eu

REPO="${JARN_REPO:-noyzilla/jarn}"
BRANCH="${JARN_BRANCH:-main}"
TARGET_DIR="${1:-.}"
TARBALL_URL="https://github.com/${REPO}/archive/refs/heads/${BRANCH}.tar.gz"

echo "Initializing new project from ${REPO}@${BRANCH}..."

if [ "${TARGET_DIR}" != "." ]; then
  mkdir -p "${TARGET_DIR}"
  echo "Target directory: ${TARGET_DIR}"
fi

# Pre-flight safety check: prevent accidental clobbering of existing projects
if [ -d "${TARGET_DIR}" ]; then
  EXISTING_FILES=0
  for item in "${TARGET_DIR}"/* "${TARGET_DIR}"/.[!.]*; do
    if [ -e "${item}" ]; then
      base_item=$(basename "${item}")
      if [ "${base_item}" != ".git" ] && [ "${base_item}" != "*" ]; then
        EXISTING_FILES=1
        break
      fi
    fi
  done

  if [ "${EXISTING_FILES}" -eq 1 ] && [ "${FORCE:-0}" != "1" ]; then
    echo "Error: Target directory '${TARGET_DIR}' is not empty." >&2
    echo "  'scripts/init.sh' is intended only for empty/new projects." >&2
    echo "  To adopt jarn into an existing project safely without clobbering files, run:" >&2
    echo "    curl -fsSL https://raw.githubusercontent.com/${REPO}/${BRANCH}/scripts/adopt.sh | sh" >&2
    echo "  (Or pass FORCE=1 to force overwrite)." >&2
    exit 1
  fi
fi

echo "Downloading Jarn blueprint archive..."
curl -fsSL "${TARBALL_URL}" | tar -xz -C "${TARGET_DIR}" --strip-components 1

cd "${TARGET_DIR}"

# Remove bootstrap scripts from initialized project
rm -f scripts/init.sh scripts/adopt.sh
rmdir scripts 2>/dev/null || true

if command -v git >/dev/null 2>&1 && [ ! -d ".git" ]; then
  git init -q
  echo "Initialized empty Git repository in $(pwd)/.git/"
fi

echo "Project initialized successfully."
echo "Next steps:"
echo "  - Open AGENTS.md and select your language preset (TypeScript, Java, Python, Go, Rust)."
echo "  - Update README.md and ARCHITECTURE.md with your project specifics."
echo "  - Manage Jarn standards and skills via .agents/scripts/jarn-update.sh"
echo "  - Verify with your project's native test and lint commands."
